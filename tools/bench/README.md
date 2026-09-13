# rules_dotnet performance benchmarks

A synthetic workspace generator and a runner, so performance claims about the
rules can be reproduced rather than asserted.

## Generate a workspace

```
python3 tools/bench/gen_workspace.py --out /tmp/ws --rules-path . --libs 1000
```

Libraries are laid out in layers, each depending on several targets from the two
layers below it, so the transitive closures look like a real dependency graph
rather than a chain. The paket files are copied out of `examples/`, so a
generated workspace reuses NuGet archives already in the repository cache.

## Run the benchmarks

```
python3 tools/bench/bench.py run \
    --ws /tmp/ws --output-base /tmp/bench-ob \
    --label baseline --out results/baseline.json
python3 tools/bench/bench.py report results/baseline.json results/candidate.json
```

Use a dedicated `--output-base`, and the same one for every label being compared,
so repository fetching is never on the clock.

Scenarios: `load`, `analysis-cold`, `analysis-warm`, `analysis-null`, `exec-cold`,
`exec-incr-leaf`, `exec-null`. Each is the median of `--repeats` runs with the
first discarded. `analysis-warm` flips a `--define` instead of using
`--discard_analysis_cache`, which leaves Skyframe nodes in place and so cannot
force re-analysis.
