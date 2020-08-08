del nuget.json
copy base.bzl nuget.bzl
#set tool=bazel run //tools/nuget2bazel:nuget2bazel.exe --
set tool=C:\rules_dotnet\tools\nuget2bazel\bin\Debug\netcoreapp3.1\nuget2bazel.exe

%tool% add -p c:/rules_dotnet/docs/examples/private_nuget/gen -b nuget.bzl -c nuget.json  -i -u -n https://dotnet.myget.org/F/dotnet-corefxlab/api/v3/index.json System.Buffers.Primitives 0.1.2-e200127-1

