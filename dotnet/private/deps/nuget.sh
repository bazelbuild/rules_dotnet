bazel run //tools/nuget2bazel:nuget2bazel.exe -- delete -p `pwd`/dotnet/private/deps -b nuget.bzl -c nuget.json -i NuGet.PackageManagement.NetStandard 4.9.2
bazel run //tools/nuget2bazel:nuget2bazel.exe -- add -p `pwd`/dotnet/private/deps -b nuget.bzl -c nuget.json -i -l NuGet.PackageManagement.NetStandard 4.9.2
bazel run //tools/nuget2bazel:nuget2bazel.exe -- delete -p `pwd`/dotnet/private/deps -b nuget.bzl -c nuget.json -i CommandLineParser 2.6.0
bazel run //tools/nuget2bazel:nuget2bazel.exe -- add -p `pwd`/dotnet/private/deps -b nuget.bzl -c nuget.json -i CommandLineParser 2.6.0
