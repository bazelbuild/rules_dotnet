del nuget.json
copy base.bzl nuget.bzl
#set tool=bazel run //tools/nuget2bazel:nuget2bazel.exe --
set tool=C:\rules_dotnet\tools\nuget2bazel\bin\Debug\netcoreapp3.1\nuget2bazel.exe

%tool% add -p c:/rules_dotnet/dotnet/private/deps/gen -b nuget.bzl -c nuget.json -i -l  NETStandard.Library 2.0.3

%tool% add -p c:/rules_dotnet/dotnet/private/deps/gen -b nuget.bzl -c nuget.json -i nunit 3.12.0
%tool% add -p c:/rules_dotnet/dotnet/private/deps/gen -b nuget.bzl -c nuget.json -i -m nunit3-console.exe nunit.consolerunner 3.11.1

%tool% add -p c:/rules_dotnet/dotnet/private/deps/gen -b nuget.bzl -c nuget.json -i Microsoft.Extensions.FileSystemGlobbing 3.1.3
%tool% add -p c:/rules_dotnet/dotnet/private/deps/gen -b nuget.bzl -c nuget.json -i Microsoft.Extensions.DependencyModel 3.1.3

%tool% add -p c:/rules_dotnet/dotnet/private/deps/gen -b nuget.bzl -c nuget.json -i -m xunit.console xunit.runner.console 2.4.1
%tool% add -p c:/rules_dotnet/dotnet/private/deps/gen -b nuget.bzl -c nuget.json -i xunit.assert 2.4.1
%tool% add -p c:/rules_dotnet/dotnet/private/deps/gen -b nuget.bzl -c nuget.json -i xunit 2.4.1

%tool% add -p c:/rules_dotnet/dotnet/private/deps/gen -b nuget.bzl -c nuget.json -i -l NuGet.PackageManagement.NetStandard 4.9.2
%tool% add -p c:/rules_dotnet/dotnet/private/deps/gen -b nuget.bzl -c nuget.json -i -l CommandLineParser 2.6.0
%tool% add -p c:/rules_dotnet/dotnet/private/deps/gen -b nuget.bzl -c nuget.json -i -l System.Reflection.MetadataLoadContext 4.7.1
