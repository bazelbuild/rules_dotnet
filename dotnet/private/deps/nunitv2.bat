bazel run //tools/nuget2bazel:nuget2bazel.exe -- add -p c:/rules_dotnet/dotnet/private/deps -b nunitv2.bzl -c nunitv2.json -i -v nunitv2 nunit 2.7.1 
bazel run //tools/nuget2bazel:nuget2bazel.exe -- add -p c:/rules_dotnet/dotnet/private/deps -b nunitv2.bzl -c nunitv2.json -i -m nunit-console.exe -v nunitrunnersv2 nunit.runners 2.7.1 
