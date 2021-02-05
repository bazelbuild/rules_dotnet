del nuget.json
copy base.bzl nuget.bzl
#set tool=bazel run //tools/nuget2bazel:nuget2bazel.exe --
set tool=C:\rules_dotnet\tools\nuget2bazel\bin\Debug\netcoreapp3.1\nuget2bazel.exe

%tool% add -p c:/rules_dotnet/docs/examples/ef/gen -b nuget.bzl -c nuget.json -i -l  microsoft.entityframeworkcore 3.1.3

