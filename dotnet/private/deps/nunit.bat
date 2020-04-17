bazel run //tools/nuget2bazel:nuget2bazel.exe -- add -p c:/rules_dotnet/dotnet/private/deps -b nunit.bzl -c nunit.json -i nunit 3.12.0
bazel run //tools/nuget2bazel:nuget2bazel.exe -- add -p c:/rules_dotnet/dotnet/private/deps -b nunit.bzl -c nunit.json -i -m nunit3-console.exe nunit.consolerunner 3.11.1
