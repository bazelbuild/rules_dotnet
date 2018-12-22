set nuget2bazel=dotnet run -- add -s -p c:/rules_dotnet

%nuget2bazel% CommandLineParser 2.3.0
%nuget2bazel% Newtonsoft.Json 11.0.2
%nuget2bazel% nuget.frameworks 4.8.0
%nuget2bazel% nuget.common 4.8.0
%nuget2bazel% nuget.configuration 4.8.0
%nuget2bazel% nuget.versioning 4.8.0
%nuget2bazel% nuget.packaging.core 4.8.0
%nuget2bazel% nuget.packaging 4.8.0
%nuget2bazel% nuget.protocol 4.8.0
%nuget2bazel% nuget.credentials 4.8.0
%nuget2bazel% nuget.resolver 4.8.0
%nuget2bazel% nuget.librarymodel 4.8.0
%nuget2bazel% nuget.dependencyresolver.core 4.8.0
%nuget2bazel% nuget.projectmodel 4.8.0
%nuget2bazel% nuget.commands 4.8.0
%nuget2bazel% nuget.packagemanagement 4.8.0
%nuget2bazel% -m xunit.console xunit.runner.console 2.4.1
%nuget2bazel% xunit.assert 2.4.1
%nuget2bazel% xunit 2.4.1
