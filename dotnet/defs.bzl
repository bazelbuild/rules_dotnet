"""Public API surface is re-exported here.

Users should not load files under "/dotnet"
"""

load(
    "//dotnet/private:rules/csharp/binary.bzl",
    _csharp_binary = "csharp_binary",
)
load(
    "//dotnet/private:rules/fsharp/binary.bzl",
    _fsharp_binary = "fsharp_binary",
)
load(
    "//dotnet/private:rules/wrapper.bzl",
    _dotnet_wrapper = "dotnet_wrapper",
)
load(
    "//dotnet/private:rules/csharp/library.bzl",
    _csharp_library = "csharp_library",
)
load(
    "//dotnet/private:rules/fsharp/library.bzl",
    _fsharp_library = "fsharp_library",
)
load(
    "//dotnet/private:rules/library_set.bzl",
    _library_set = "library_set",
)
load(
    "//dotnet/private:rules/csharp/nunit_test.bzl",
    _csharp_nunit_test = "csharp_nunit_test",
)
load(
    "//dotnet/private:rules/fsharp/nunit_test.bzl",
    _fsharp_nunit_test = "fsharp_nunit_test",
)
load(
    "//dotnet/private:rules/imports.bzl",
    _import_library = "import_library",
)

dotnet_wrapper = _dotnet_wrapper
csharp_binary = _csharp_binary
csharp_library = _csharp_library
csharp_nunit_test = _csharp_nunit_test
fsharp_binary = _fsharp_binary
fsharp_library = _fsharp_library
fsharp_nunit_test = _fsharp_nunit_test
library_set = _library_set
import_library = _import_library
