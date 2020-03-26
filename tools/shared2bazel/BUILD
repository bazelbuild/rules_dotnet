load("@io_bazel_rules_dotnet//dotnet:defs.bzl", "DEFAULT_DOTNET_CORE_FRAMEWORK", "DOTNET_CORE_FRAMEWORKS", "core_binary")

core_binary(
    name = "shared2bazel.exe",
    srcs = glob(["*.cs"]),
    visibility = ["//visibility:public"],
    deps = [
        "@io_bazel_rules_dotnet//dotnet/stdlib.core:netstandard.dll",
        "@io_bazel_rules_dotnet//dotnet/stdlib.core:system.buffers.dll",
        "@io_bazel_rules_dotnet//dotnet/stdlib.core:system.console.dll",
        "@io_bazel_rules_dotnet//dotnet/stdlib.core:system.core.dll",
        "@io_bazel_rules_dotnet//dotnet/stdlib.core:system.dll",
        "@io_bazel_rules_dotnet//dotnet/stdlib.core:system.io.dll",
        "@io_bazel_rules_dotnet//dotnet/stdlib.core:system.io.filesystem.dll",
        "@io_bazel_rules_dotnet//dotnet/stdlib.core:system.io.filesystem.primitives.dll",
        "@io_bazel_rules_dotnet//dotnet/stdlib.core:system.linq.dll",
        "@io_bazel_rules_dotnet//dotnet/stdlib.core:system.private.corelib.dll",
        "@io_bazel_rules_dotnet//dotnet/stdlib.core:system.runtime.dll",
        "@io_bazel_rules_dotnet//dotnet/stdlib.core:system.runtime.extensions.dll",
        "@io_bazel_rules_dotnet//dotnet/stdlib.core:system.reflection.dll",
        "@io_bazel_rules_dotnet//dotnet/stdlib.core:system.text.dll",
        "@io_bazel_rules_dotnet//dotnet/stdlib.core:system.text.json.dll",
        "@io_bazel_rules_dotnet//dotnet/stdlib.core:system.text.regularexpressions.dll",
    ],
)
