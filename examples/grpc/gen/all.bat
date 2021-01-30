del nuget.json
copy base.bzl nuget.bzl
set tool=bazel run @io_bazel_rules_dotnet//tools/nuget2bazel:nuget2bazel.exe --
#set tool=C:\rules_dotnet\tools\nuget2bazel\bin\Debug\netcoreapp3.1\nuget2bazel.exe

%tool% add -p %cd% -b nuget.bzl -c nuget.json -i -l  grpc.core 2.28.1
%tool% add -p %cd% -b nuget.bzl -c nuget.json -i -l  grpc.healthcheck 2.28.1
%tool% add -p %cd% -b nuget.bzl -c nuget.json -i -l  google.protobuf 3.12.0-rc1



