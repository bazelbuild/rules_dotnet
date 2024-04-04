"Cross publishing tests"

load(
    "//dotnet:defs.bzl",
    "publish_binary",
)

permutations = [
    ("linux-x64", "'ELF 64-bit LSB pie executable, x86-64, version 1 (GNU/Linux), dynamically linked'"),
    ("linux-arm64", "'ELF 64-bit LSB shared object, ARM aarch64, version 1 (SYSV), dynamically linked'"),
    ("osx-x64", "'Mach-O 64-bit x86_64 executable'"),
    ("osx-arm64", "'Mach-O 64-bit arm64 executable'"),
    ("win-x64", "'PE32+ executable (console) x86-64, for MS Windows'"),
    ("win-arm64", "'PE32+ executable (console) Aarch64, for MS Windows'"),
]

# buildifier: disable=unnamed-macro
def tests():
    for (rid, expected_output) in permutations:
        publish_binary(
            name = "cross_publish_{}".format(rid),
            binary = "//dotnet/private/tests/publish/app_to_publish",
            runtime_identifier = rid,
            self_contained = True,
            target_framework = "net6.0",
        )

        native.sh_test(
            name = "cross_publish_test_{}".format(rid),
            srcs = ["test.sh"],
            args = [
                "$(rootpath :cross_publish_{})".format(rid),
                expected_output,
            ],
            data = [
                ":cross_publish_{}".format(rid),
            ],
            # Disable RBE for this test since the system tools required for the test are not available in the RBE executors
            tags = ["no-remote-exec"],
        )
