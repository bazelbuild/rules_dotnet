#!/usr/bin/env python3
"""Run and report the rules_dotnet performance benchmarks.

Each scenario is a (setup, timed) pair of Bazel invocations; setup is never on
the clock. Timings are the median of `--repeats` runs with the first discarded.

Usage:
  bench.py run    --ws WS --output-base OB --label baseline --out results/baseline.json
  bench.py report results/baseline.json results/candidate.json
"""

import argparse
import gzip
import json
import os
import re
import statistics
import subprocess
import sys
import time

ANALYZED_RE = re.compile(
    r"Analyzed (\d+) targets? \((\d+) packages? loaded, (\d+) targets? configured\)")
CONFIG_RE = re.compile(r"^[0-9a-f]{16,}\s", re.M)


def bazel(ws, output_base, args, check=True, merge_stderr=True):
    """Run bazel. `merge_stderr` is off for commands whose stdout is parsed."""
    cmd = ["bazel", "--output_base=" + output_base] + args
    proc = subprocess.run(
        cmd, cwd=ws, check=False,
        stdout=subprocess.PIPE,
        stderr=subprocess.STDOUT if merge_stderr else subprocess.PIPE,
        text=True)
    if check and proc.returncode != 0:
        sys.stderr.write((proc.stdout or "")[-4000:])
        raise SystemExit("bazel %s failed (%d)" % (" ".join(args[:3]), proc.returncode))
    return proc


def timed(ws, output_base, args):
    start = time.monotonic()
    proc = bazel(ws, output_base, args)
    return (time.monotonic() - start) * 1000.0, proc.stdout or ""


# Each scenario: setup runs untimed before every repeat, then `timed` is clocked.
SCENARIOS = {
    "load": {
        "doc": "loading phase + .bzl load-time tables, cold server",
        "setup": [["shutdown"]],
        "timed": ["query", "--output=label", "//..."],
    },
    "analysis-cold": {
        "doc": "loading + analysis from a cold server",
        "setup": [["shutdown"]],
        "timed": ["build", "--nobuild", "//..."],
    },
    "analysis-warm": {
        # --discard_analysis_cache leaves Skyframe nodes in place, so it cannot
        # force re-analysis. Flipping a --define changes the configuration, which
        # does, while the loading phase stays warm.
        "doc": "analysis only, packages already loaded",
        "setup": [["build", "--nobuild", "//..."]],
        "timed": ["build", "--nobuild", "//..."],
        "vary_define": True,
    },
    "analysis-null": {
        "doc": "Skyframe no-op",
        "setup": [["build", "--nobuild", "//..."]],
        "timed": ["build", "--nobuild", "//..."],
    },
    "exec-cold": {
        "doc": "full build, no action cache",
        "setup": [["clean"]],
        "timed": ["build", "//..."],
    },
    "exec-incr-leaf": {
        "doc": "rebuild after editing one leaf source",
        "setup": [["build", "//..."]],
        "timed": ["build", "//..."],
        "touch": True,
    },
    "exec-null": {
        "doc": "rebuild with no change",
        "setup": [["build", "//..."]],
        "timed": ["build", "//..."],
    },
}


def touch_leaf(ws):
    """Edit one layer-0 source so dependents must actually recompile."""
    target = os.path.join(ws, "pkg0000", "Src0.cs")
    if not os.path.exists(target):
        return
    with open(target) as handle:
        body = handle.read()
    match = re.search(r"Value => (\d+);", body)
    bumped = int(match.group(1)) + 1 if match else 1
    with open(target, "w") as handle:
        handle.write(re.sub(r"Value => \d+;", "Value => %d;" % bumped, body))


def parse_profile(path):
    """Aggregate a Bazel JSON profile into phases, categories and Starlark calls.

    Phase markers are instant events, so a phase lasts until the next one.
    """
    if not os.path.exists(path):
        return {}
    with gzip.open(path, "rt") as handle:
        data = json.load(handle)
    events = data.get("traceEvents", data) if isinstance(data, dict) else data

    by_category = {}
    starlark = {}
    markers = []
    for event in events:
        category = event.get("cat", "?")
        if event.get("ph") == "X" and "dur" in event:
            by_category[category] = by_category.get(category, 0) + event["dur"]
            if category == "Starlark user function call":
                name = event.get("name", "?")
                slot = starlark.setdefault(name, [0, 0])
                slot[0] += event["dur"]
                slot[1] += 1
        elif category == "build phase marker":
            markers.append((event.get("ts", 0), event.get("name", "?")))

    markers.sort()
    phases = {}
    for index, (ts, name) in enumerate(markers):
        end = markers[index + 1][0] if index + 1 < len(markers) else ts
        phases[name] = round((end - ts) / 1000.0)

    return {
        "phase_ms": phases,
        "category_ms": {k: round(v / 1000.0) for k, v in
                        sorted(by_category.items(), key=lambda kv: -kv[1])[:12]},
        "starlark_ms": {k: {"ms": round(v[0] / 1000.0), "calls": v[1]} for k, v in
                        sorted(starlark.items(), key=lambda kv: -kv[1][0])[:15]},
    }


def collect_static(ws, output_base):
    """One-off facts that do not need timing."""
    out = {}
    # Cold, so Bazel actually reports the package and configured-target counts
    # instead of the zeros a warm server prints.
    bazel(ws, output_base, ["shutdown"], check=False)
    proc = bazel(ws, output_base, ["build", "--nobuild", "//..."], check=False)
    match = ANALYZED_RE.search(proc.stdout or "")
    if match:
        out["targets_analyzed"] = int(match.group(1))
        out["packages_loaded"] = int(match.group(2))
        out["targets_configured"] = int(match.group(3))

    proc = bazel(ws, output_base, ["config"], check=False)
    out["configurations"] = len(CONFIG_RE.findall(proc.stdout or ""))

    proc = bazel(ws, output_base, ["info", "used-heap-size-after-gc"], check=False)
    lines = (proc.stdout or "").strip().splitlines()
    out["heap_after_gc"] = lines[-1] if lines else ""

    # Inputs per CSharpCompile: the number the action-input work shows up in.
    proc = bazel(ws, output_base, [
        "aquery", "--output=jsonproto", 'mnemonic("CSharpCompile", //...)'],
        check=False, merge_stderr=False)
    try:
        aq = json.loads(proc.stdout)
        sets = {s["id"]: s for s in aq.get("depSetOfFiles", [])}

        def size(dep_id, seen):
            if dep_id in seen:
                return 0
            seen.add(dep_id)
            node = sets.get(dep_id, {})
            return len(node.get("directArtifactIds", [])) + sum(
                size(t, seen) for t in node.get("transitiveDepSetIds", []))

        counts = []
        for action in aq.get("actions", []):
            seen = set()
            counts.append(sum(size(d, seen) for d in action.get("inputDepSetIds", [])))
        if counts:
            out["csharp_compile_actions"] = len(counts)
            out["inputs_per_compile_median"] = int(statistics.median(counts))
            out["inputs_per_compile_total"] = sum(counts)
    except Exception as exc:  # aquery output shape varies by version
        out["aquery_error"] = str(exc)
    return out


def run(args):
    ws, ob = os.path.abspath(args.ws), os.path.abspath(args.output_base)
    scenarios = args.scenarios.split(",") if args.scenarios else list(SCENARIOS)
    profile_dir = os.path.join(os.path.dirname(os.path.abspath(args.out)) or ".", "profiles")
    os.makedirs(profile_dir, exist_ok=True)

    # Warm the repository cache once so no scenario pays for fetching.
    bazel(ws, ob, ["build", "--nobuild", "//..."])
    results = {"label": args.label, "ws": ws, "scenarios": {}, "static": collect_static(ws, ob)}

    for name in scenarios:
        spec = SCENARIOS[name]
        samples = []
        for attempt in range(args.repeats + 1):
            for setup in spec["setup"]:
                bazel(ws, ob, setup, check=False)
            if spec.get("touch"):
                touch_leaf(ws)
            profile = os.path.join(profile_dir, "%s-%s.json.gz" % (args.label, name))
            extra = ["--config=profile", "--profile=" + profile]
            if spec.get("vary_define"):
                extra.append("--define=bench_iteration=%d" % attempt)
            elapsed, _ = timed(ws, ob, spec["timed"] + extra)
            if attempt:  # discard the first
                samples.append(elapsed)
        entry = {
            "doc": spec["doc"],
            "samples_ms": [round(s) for s in samples],
            "median_ms": round(statistics.median(samples)),
            "profile": parse_profile(os.path.join(profile_dir, "%s-%s.json.gz" % (args.label, name))),
        }
        results["scenarios"][name] = entry
        print("%-16s %7d ms  (%s)" % (name, entry["median_ms"],
                                      " ".join(str(round(s)) for s in samples)))

    os.makedirs(os.path.dirname(os.path.abspath(args.out)) or ".", exist_ok=True)
    with open(args.out, "w") as handle:
        json.dump(results, handle, indent=2)
    print("\nwrote %s" % args.out)
    for key, value in results["static"].items():
        print("  %-28s %s" % (key, value))
    return 0


def report(args):
    loaded = []
    for path in args.results:
        with open(path) as handle:
            loaded.append(json.load(handle))
    base, rest = loaded[0], loaded[1:]

    names = list(base["scenarios"])
    width = max(len(n) for n in names) + 2
    header = "| %-*s | %10s |" % (width, "scenario", base["label"])
    for other in rest:
        header += " %10s | %8s |" % (other["label"], "delta")
    print(header)
    print("|" + "-" * (width + 2) + "|" + "------------|" * (1 + 2 * len(rest)))
    for name in names:
        baseline = base["scenarios"][name]["median_ms"]
        row = "| %-*s | %10d |" % (width, name, baseline)
        for other in rest:
            value = other["scenarios"].get(name, {}).get("median_ms")
            if value is None:
                row += " %10s | %8s |" % ("-", "-")
            else:
                row += " %10d | %+7.1f%% |" % (value, (value - baseline) * 100.0 / baseline)
        print(row)

    print()
    keys = sorted({k for r in loaded for k in r["static"]})
    width = max(len(k) for k in keys) + 2
    print("| %-*s | %14s |%s" % (width, "metric", base["label"],
                                 "".join(" %14s |" % o["label"] for o in rest)))
    print("|" + "-" * (width + 2) + "|" + "----------------|" * (1 + len(rest)))
    for key in keys:
        row = "| %-*s | %14s |" % (width, key, base["static"].get(key, "-"))
        for other in rest:
            row += " %14s |" % other["static"].get(key, "-")
        print(row)
    return 0


def main(argv=None):
    parser = argparse.ArgumentParser(description=__doc__,
                                     formatter_class=argparse.RawDescriptionHelpFormatter)
    sub = parser.add_subparsers(dest="cmd", required=True)

    run_parser = sub.add_parser("run")
    run_parser.add_argument("--ws", required=True)
    run_parser.add_argument("--output-base", required=True)
    run_parser.add_argument("--label", required=True)
    run_parser.add_argument("--out", required=True)
    run_parser.add_argument("--scenarios", default=None,
                            help="Comma separated subset of: " + ",".join(SCENARIOS))
    run_parser.add_argument("--repeats", type=int, default=5)
    run_parser.set_defaults(func=run)

    report_parser = sub.add_parser("report")
    report_parser.add_argument("results", nargs="+")
    report_parser.set_defaults(func=report)

    args = parser.parse_args(argv)
    return args.func(args)


if __name__ == "__main__":
    sys.exit(main())
