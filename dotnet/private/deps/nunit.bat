bazel run //tools/nuget2bazel:nuget2bazel.exe -- add -p c:/rules_dotnet/dotnet/private/deps -b nunit.bzl -c nunit.json -i nunit 3.12.0
bazel run //tools/nuget2bazel:nuget2bazel.exe -- add -p c:/rules_dotnet/dotnet/private/deps -b nunit.bzl -c nunit.json -i -m nunit3-console.exe nunit.consolerunner 3.11.1
bazel run //tools/nuget2bazel:nuget2bazel.exe -- add -p c:/rules_dotnet/dotnet/private/deps -b nunit.bzl -c nunit.json -i NUnit3TestAdapter  3.16.1
bazel run //tools/nuget2bazel:nuget2bazel.exe -- add -p c:/rules_dotnet/dotnet/private/deps -b nunit.bzl -c nunit.json -i Microsoft.NET.Test.Sdk  16.5.0
bazel run //tools/nuget2bazel:nuget2bazel.exe -- add -p c:/rules_dotnet/dotnet/private/deps -b nunit.bzl -c nunit.json -i Microsoft.TestPlatform.Testhost 16.5.0