#addin nuget:?package=Cake.FileHelpers&version=3.2.1
#addin nuget:?package=Cake.Incubator&version=5.1.0

// ARGUMENTS
var target = Argument("target", "Default");
var configuration = Argument("configuration", "Release");

var slnFile = "./BazelDotnet.sln";

// TASKS
Task("Clean").Does(() =>
{
  var binDirs = GetDirectories("./src/**/bin/*");
  foreach(var directory in binDirs)
  {
    CleanDirectory(directory.FullPath);
  }
  // also the new obj folders
  var objDirs = GetDirectories("./src/**/obj/*");
  foreach(var directory in objDirs)
  {
    CleanDirectory(directory.FullPath);
  }
});

Task("Restore")
    .Does(() =>
{
    DotNetCoreRestore(slnFile);
});

Task("Build")
    // This is the fast build, so no dependencies
    .Does(() =>
{
  var msBuildSettings = new DotNetCoreMSBuildSettings();
  msBuildSettings.Properties["AssemblyVersion"]= new [] {"1.0.0.0"};
  msBuildSettings.Verbosity = DotNetCoreVerbosity.Minimal;

  DotNetCoreBuild(slnFile, new DotNetCoreBuildSettings() {
    MSBuildSettings = msBuildSettings,
    Configuration = configuration,
    Verbosity = DotNetCoreVerbosity.Minimal
  });
});

Task("Rebuild")
    .IsDependentOn("Clean")
    .IsDependentOn("Restore")
    .IsDependentOn("Build")
    .Does(() =>
{
});

Task("Publish")
    .IsDependentOn("Rebuild")
    .Does(() => 
{
    var settings = new DotNetCorePublishSettings
     {
         Framework = "netcoreapp3.1",
         Configuration = configuration,
         OutputDirectory = $"./publish/{configuration}"
     };

     DotNetCorePublish(slnFile, settings);
});

Task("Release")
   .IsDependentOn("Publish")
   .Does(() =>
{
  if(!configuration.EqualsIgnoreCase("Release")){
    throw new Exception("Run this script with configuration release to publish the binaries to the share");  
  }

   var publishedFiles = GetFiles("./publish/" + configuration + "/**/*");
   CopyFiles(publishedFiles, Directory(@"\\afasgroep.nl\data\tfsbuild\output\Tools\bazel-dotnet"), true);
});

// TASK TARGETS
Task("Default").IsDependentOn("Restore").IsDependentOn("Build");

RunTarget(target);