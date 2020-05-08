del nuget2.json
copy base2.bzl nuget2.bzl
#set tool=bazel run //tools/nuget2bazel:nuget2bazel.exe --
set tool=C:\rules_dotnet\tools\nuget2bazel\bin\Debug\netcoreapp3.1\nuget2bazel.exe

%tool% add -p c:/rules_dotnet/dotnet/private/deps/gen -b nuget2.bzl -c nuget2.json -i -v nunitv2 nunit 2.7.1
%tool% add -p c:/rules_dotnet/dotnet/private/deps/gen -b nuget2.bzl -c nuget2.json -i -m nunit-console.exe -v nunitrunnersv2 nunit.runners 2.7.1
