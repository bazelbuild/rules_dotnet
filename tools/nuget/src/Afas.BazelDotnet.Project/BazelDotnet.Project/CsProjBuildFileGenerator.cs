using System;
using System.Collections.Generic;
using System.IO;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace Afas.BazelDotnet.Project
{
  public class CsProjBuildFileGenerator
  {
    private readonly string _workspace;
    private readonly string _nugetWorkspace;
    private readonly IReadOnlyDictionary<string, string> _importLabels;
    private readonly string _appendString;
    private readonly IReadOnlyDictionary<string, string[]> _visibilityOptions;

    public CsProjBuildFileGenerator(string workspace, string nugetWorkspace, IReadOnlyDictionary<string, string> imports, string appendString,
      Dictionary<string, string[]> visibilityOptions)
    {
      _workspace = workspace;
      _nugetWorkspace = nugetWorkspace;
      _importLabels = imports;
      _appendString = appendString;
      _visibilityOptions = visibilityOptions;
    }

    private static void WriteFileIfChanged(string path, string newContents)
    {
      using var buildFileStream = File.Open(path, FileMode.OpenOrCreate, FileAccess.ReadWrite, FileShare.None);
      using var reader = new StreamReader(buildFileStream);

      // only write to the file when we have changes so we do not introduce git diff's
      if(!string.Equals(newContents, reader.ReadToEnd(), StringComparison.OrdinalIgnoreCase))
      {
        buildFileStream.SetLength(0);
        using var writer = new StreamWriter(buildFileStream);
        writer.Write(newContents);
      }
    }

    public async Task GlobAllProjects(IReadOnlyCollection<string> searchFolders = null, string extension = "csproj", string exportsFileName = null)
    {
      var filesEnum = searchFolders?.Any() == true
        ? searchFolders
          .Select(f => f.Replace('/', '\\'))
          .SelectMany(f => Directory.EnumerateFiles(Path.Combine(_workspace, f), $"*.{extension}", SearchOption.AllDirectories))
        : Directory.EnumerateFiles(_workspace, $"*.{extension}", SearchOption.AllDirectories);

      var files = filesEnum
        // exclude bazel (tmp) folders
        .Where(p => !p.Contains("bazel-"))
        .ToArray();

      files = await Task.WhenAll(files.Select(projectFile => Task.Run(() =>
      {
        var definition = FindAndParseProjectFile(_workspace, projectFile);

        if(definition.ReadPropertyValue("TargetFramework")?.Contains("netstandard") == true)
        {
          return null;
        }

        // only write to the file when we have changes so we do not introduce git diff's
        WriteFileIfChanged(
          Path.Combine(Path.GetDirectoryName(projectFile), "BUILD"),
          new BazelDefinitionBuilder(definition, _nugetWorkspace)
            .Visibility(GetVisibility(projectFile))
            .Build()
            .Serialize(_appendString));

        return projectFile;
      }))).ConfigureAwait(false);

      if(!string.IsNullOrEmpty(exportsFileName))
      {
        var values = files
          .Where(f => !string.IsNullOrEmpty(f))
          .ToDictionary(Path.GetFileNameWithoutExtension, ToLabel, StringComparer.OrdinalIgnoreCase)
          .Select(l => $"{l.Key}={l.Value}");
        File.WriteAllText(exportsFileName, $"{string.Join("\n", values)}");
      }
    }

    private string GetVisibility(string projectFile)
    {
      foreach(var (pattern, visibilities) in _visibilityOptions)
      {
        // Currently not supporting actual glob
        var p = pattern.EndsWith("**") ? Path.GetDirectoryName(pattern) : pattern;
        var prefix = $".\\{p}";
        if(projectFile.StartsWith(prefix, StringComparison.OrdinalIgnoreCase))
        {
          return string.Join(@""", """, visibilities.Select(ReplaceWildcards));

          string ReplaceWildcards(string label)
          {
            var index = label.IndexOf('*');
            if(index < 0)
            {
              return label;
            }

            int pindex = 0;
            int i = 0;
            var substitutions = projectFile.Substring(prefix.Length + 1).Split('\\');
            var sb = new StringBuilder();
            while(index >= 0)
            {
              sb.Append(label.Substring(pindex, index - pindex));
              sb.Append(substitutions[i++]);
              pindex = index + 1;
              index = label.IndexOf('*', pindex);
            }
            sb.Append(label.Substring(pindex, label.Length - pindex));
            return sb.ToString();
          }
        }
      }

      return BazelDefinition.DefaultVisibility;
    }

    private string ToLabel(string csprojFilePath)
    {
      var name = Path.GetDirectoryName(
          Path.GetRelativePath(_workspace, csprojFilePath))
        .Replace('\\', '/');

      return $"//{name}:{Path.GetFileNameWithoutExtension(csprojFilePath)}";
    }

    private CsProjectFileDefinition FindAndParseProjectFile(string solutionBasePath, string projectFilePath)
    {
      var definition = new CsProjectFileDefinition(projectFilePath, solutionBasePath);
      return definition.Deserialize(ToLabel, _importLabels, projectFilePath);
    }
  }
}