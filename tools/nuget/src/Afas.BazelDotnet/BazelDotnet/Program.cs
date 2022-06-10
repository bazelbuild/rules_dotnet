using System;
using System.Collections.Generic;
using System.IO;
using System.Linq;
using System.Threading.Tasks;
using System.Xml.Linq;
using Afas.BazelDotnet.Nuget;
using Afas.BazelDotnet.Project;
using McMaster.Extensions.CommandLineUtils;

namespace Afas.BazelDotnet
{
  public class Program
  {
    public static void Main(string[] args)
    {
      var app = new CommandLineApplication
      {
        Name = "BazelDotnet",
        Description = "Bazel file generator for .NET Core projects",
      };

      app.HelpOption("-?|-h|--help");

      // set the WorkingDir!
      // repository C:/Anta/platform/nuget.config -p C:/Anta/platform/Packages.Props
      app.Command("repository", repoCmd =>
      {
        var nugetConfig = repoCmd.Argument("nugetConfig", "The path to the Packages.Props file");
        var tfmOption = repoCmd.Option("-t|--tfm", "The target framework to restore", CommandOptionType.SingleOrNoValue);
        var packageProps = repoCmd.Option("-p|--package", "Packages.Props files", CommandOptionType.MultipleValue);
        var importsOption = repoCmd.Option("-i|--imports", "Import files with dictionary of imported project labels (PackageName=Label)", CommandOptionType.MultipleValue);

        repoCmd.OnExecuteAsync(async _ =>
        {
          var packagePropsFilePaths = packageProps.Values.Select(v => Path.Combine(Directory.GetCurrentDirectory(), v)).ToArray();
          var nugetConfigFilePath = Path.Combine(Directory.GetCurrentDirectory(), nugetConfig.Value);
          var tfm = tfmOption.HasValue() ? tfmOption.Value() : "net5.0";
          await WriteRepository(tfm, packagePropsFilePaths, nugetConfigFilePath, importsOption.Values).ConfigureAwait(false);
          return 0;
        });
      });

      // set the WorkingDir!
      // repository C:/Anta/platform/nuget.config -p C:/Anta/platform/Packages.Props
      app.Command("repository2", repoCmd =>
      {
        var nugetConfig = repoCmd.Argument("nugetConfig", "The path to the Packages.Props file");
        var tfmOption = repoCmd.Option("-t|--tfm", "The target framework to restore", CommandOptionType.SingleOrNoValue);
        var packageProps = repoCmd.Option("-p|--package", "Packages.Props files", CommandOptionType.MultipleValue);

        repoCmd.OnExecuteAsync(async _ =>
        {
          var packagePropsFilePaths = packageProps.Values.Select(v => Path.Combine(Directory.GetCurrentDirectory(), v)).ToArray();
          var nugetConfigFilePath = Path.Combine(Directory.GetCurrentDirectory(), nugetConfig.Value);
          var tfm = tfmOption.HasValue() ? tfmOption.Value() : "net5.0";
          await WriteRepository2(tfm, packagePropsFilePaths, nugetConfigFilePath).ConfigureAwait(false);
          return 0;
        });
      });

      // projects --path=C:/Anta/platform --search=generator --workspace=nuget
      app.Command("projects", repoCmd =>
      {
        var pathOption = repoCmd.Option("-p|--path", "The path to the workspace root", CommandOptionType.SingleOrNoValue);
        var workspaceOption = repoCmd.Option("-w|--workspace", "The workspace to load nugets from", CommandOptionType.SingleOrNoValue);
        var exportsOption = repoCmd.Option("-e|--exports", "Exports file with dictionary of provided project labels (PackageName=Label)", CommandOptionType.SingleOrNoValue);
        var importsOption = repoCmd.Option("-i|--imports", "Import files with dictionary of imported project labels (PackageName=Label)", CommandOptionType.MultipleValue);
        var searchOption = repoCmd.Option("--search", "Specify folders to search", CommandOptionType.MultipleValue);
        var appendOption = repoCmd.Option("--append", "Specify a file which contents should be appended to each BUILD file.", CommandOptionType.MultipleValue);
        var visibilityOption = repoCmd.Option("-v|--visibility", "Specify {glob}={label} to define visibility for a set of generated BUILD files.", CommandOptionType.MultipleValue);

        repoCmd.HelpOption("-?|-h|--help");
        repoCmd.OnExecuteAsync(async _ =>
        {
          string path;

          if(pathOption.HasValue())
          {
            path = pathOption.Value();
          }
          else
          {
            path = Environment.GetEnvironmentVariable("BUILD_WORKSPACE_DIRECTORY");

            if(string.IsNullOrEmpty(path))
            {
              throw new ArgumentException("Environment variable BUILD_WORKSPACE_DIRECTORY is missing");
            }
          }

          await GenerateBuildFiles(path, workspaceOption.Value(), exportsOption.Value(),
            importsOption.Values, searchOption.Values, appendOption.Values, visibilityOption.Values).ConfigureAwait(false);
          return 0;
        });
      });

      if(!args.Any())
      {
        app.ShowHelp();
        throw new Exception("No arguments provided");
      }

      app.Execute(args);
    }

    private static (string, string)[] ResolvePackages(string packageProps)
    {
      if(File.Exists(packageProps))
      {
        var packagesProps = XElement.Load(packageProps);

        return packagesProps
          .Element("ItemGroup")
          .Elements("PackageReference")
          .Select(el => (el.Attribute("Update")?.Value, el.Attribute("Version")?.Value))
          .Where(Included)
          // This one is upgrade due to the FrameworkReference in Afas.Cqrs
          .Append(("microsoft.aspnetcore.http.features", "3.1.0"))
          .ToArray();
      }

      return Directory.EnumerateFiles(packageProps, "*.csproj", SearchOption.AllDirectories)
        .Select(XDocument.Load)
        .SelectMany(f => f.Descendants("PackageReference"))
        .Select(p => (p.Attribute("Include")?.Value, p.Attribute("Version")?.Value))
        .Where(t => t.Item1 != null && t.Item2 != null)
        .Distinct()
        .ToArray();

      bool Included((string update, string version) arg) =>
        !string.IsNullOrEmpty(arg.update) &&
        !string.IsNullOrEmpty(arg.version) &&
        !arg.version.EndsWith("-local-dev", StringComparison.OrdinalIgnoreCase);
    }

    private static async Task WriteRepository(string tfm, IEnumerable<string> packagePropsFiles, string nugetConfig, IReadOnlyCollection<string> importMappings = null)
    {
      // Note: no conlict resolution. Maybe we can add them in the dep graph. For now multiple Packages.Props is not really a use case anymore
      (string, string)[] deps = packagePropsFiles
        .SelectMany(ResolvePackages)
        .Distinct()
        .ToArray();

      var imports = ParseImports(importMappings)
        .ToLookup(i => i.project, i => (i.target, i.configSetting), StringComparer.OrdinalIgnoreCase);

      await new NugetRepositoryGenerator(nugetConfig, tfm, "win-x64", imports)
        .WriteRepository(deps)
        .ConfigureAwait(false);
    }


    private static async Task WriteRepository2(string tfm, IEnumerable<string> packagePropsFiles, string nugetConfig)
    {
      // Note: no conlict resolution. Maybe we can add them in the dep graph. For now multiple Packages.Props is not really a use case anymore
      (string, string)[] deps = packagePropsFiles
        .SelectMany(ResolvePackages)
        .Distinct()
        .ToArray();

      await new ZipArchiveRepositoryGenerator(nugetConfig, tfm, "win-x64")
        .Write(deps)
        .ConfigureAwait(false);
    }

    private static Task GenerateBuildFiles(string workspace, string nugetWorkspace, string exportsFileName,
      IReadOnlyCollection<string> importMappings, IReadOnlyCollection<string> searchFolders,
      IReadOnlyCollection<string> appendOptionValues, IReadOnlyCollection<string> visibilityOptionValues)
    {
      var imports = ParseImports(importMappings)
        .ToDictionary(i => i.project, i => i.target);

      var appendString = appendOptionValues?.Any() != true ? null :
        string.Join("\r\n", appendOptionValues.Select(File.ReadAllText));

      var visibilityOptions = visibilityOptionValues
        .Select(o => o.Split('='))
        .ToDictionary(o => o[0].Replace('/', '\\'), o => o[1].Split(','), StringComparer.OrdinalIgnoreCase);

      return new CsProjBuildFileGenerator(workspace, nugetWorkspace, imports, appendString, visibilityOptions)
        .GlobAllProjects(searchFolders, exportsFileName: exportsFileName);
    }

    private static IEnumerable<(string project, string target, string configSetting)> ParseImports(IReadOnlyCollection<string> importMappings = null)
    {
      if(importMappings == null)
      {
        yield break;
      }

      // parse import cli arguments {reponame}={exports_file}(={conditional_config_setting})
      foreach(var importMapping in importMappings)
      {
        var split = importMapping.Split("="); // @projects=C:/bazel/external/projects/.exports
        var repoOrTarget = split[0]; // @backend//src/Afas.Cqrs:Afas.Cqrs.Definitions==@platform//:use_local_backend
        var file = split[1];
        string configSetting = split.Length > 2 ? split[2] : null; // @backend=C:/bazel/external/backend/.exports=@platform//:use_local_backend

        if(string.IsNullOrEmpty(file))
        {
          if(!repoOrTarget.Contains(":"))
          {
            throw new Exception("Received an import without a targetname or mapping file");
          }

          yield return (repoOrTarget.Split(":")[1], repoOrTarget, configSetting);
        }
        else
        {
          var lines = File.ReadAllLines(file)
            .Select(l => l.Trim())
            .Where(l => !string.IsNullOrEmpty(l));

          // parse exports_file lines {project_name}={local_target_name}
          foreach(var line in lines)
          {
            var splitLine = line.Split("="); // Project=//src/Project:Project
            var project = splitLine[0];
            var target = splitLine[1];

            // return mapping for project to global_target_name (with repo prefix)
            yield return (project, $"{repoOrTarget}{target}", configSetting); // (Project, @projects//src/Project:Project)
          }
        }
      }
    }
  }
}
