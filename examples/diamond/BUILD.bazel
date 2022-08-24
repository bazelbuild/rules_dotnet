load("@rules_dotnet//dotnet:defs.bzl", "csharp_library")

# This example comes from docs/MultiTargetingDesign.md.
# It demonstrates how framework selection works, and why, sometimes, we compile
# more things than we need to ship, but in the same way as MSBuild. This
# example isn't meant to be realistic.

csharp_library(
    name = "Top",
    srcs = ["Top.cs"],
    target_frameworks = ["net48"],
    deps = [
        "Left",
        "Right",
    ],
)

csharp_library(
    name = "Left",
    srcs = ["Left.cs"],
    target_frameworks = ["net45"],
    deps = ["Bottom"],
)

csharp_library(
    name = "Right",
    srcs = ["Right.cs"],
    target_frameworks = ["netstandard2.0"],
    deps = ["Bottom"],
)

csharp_library(
    name = "Bottom",
    srcs = ["Bottom.cs"],
    target_frameworks = [
        "net48",
        "net40",
        "netstandard1.4",
    ],
)
