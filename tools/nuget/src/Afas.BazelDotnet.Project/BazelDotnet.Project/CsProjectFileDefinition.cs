using System;
using System.Collections.Generic;
using System.IO;
using System.Linq;
using System.Xml.Linq;

namespace Afas.BazelDotnet.Project
{
  internal class CsProjectFileDefinition
  {
    private XDocument _document;

    public CsProjectFileDefinition(string projectFilePath, string slnBasePath)
    {
      RelativeFilePath = Path.GetRelativePath(slnBasePath, projectFilePath);
      PackageReferences = new List<string>
      {
        "Microsoft.NETCore.App.Ref",
      };
      ProjectReference = new List<string>();
      BazelData = new List<string>();
      EmbeddedResources = new List<EmbeddedResourceDefinition>();
      CopyToOutput = new List<string>();
    }

    public string RelativeFilePath { get; }

    public ProjectType Type { get; private set; }

    public List<string> PackageReferences { get; }

    public List<string> ProjectReference { get; }

    public List<string> BazelData { get; }

    public List<EmbeddedResourceDefinition> EmbeddedResources { get; }

    public List<string> CopyToOutput { get; }

    public bool TestOnly { get; private set; }

    public string ReadPropertyValue(string name) => _document.Descendants(name).LastOrDefault()?.Value;

    public bool IsWebSdk => string.Equals(_document.Root?.Attribute("Sdk")?.Value, "Microsoft.NET.Sdk.Web");

    public CsProjectFileDefinition Deserialize(Func<string, string> csprojToLabel,
      IReadOnlyDictionary<string, string> importLabels, string projectFilePath)
    {
      _document = XDocument.Load(projectFilePath);
      var projectFileDir = Path.GetDirectoryName(projectFilePath);

      Type = GetProjectType(_document);

      foreach(var reference in _document.Descendants("PackageReference"))
      {
        var name = reference.Attribute("Include").Value;

        if(importLabels.ContainsKey(name))
        {
          ProjectReference.Add(importLabels[name]);
        }
        else
        {
          if(name.Equals("microsoft.net.test.sdk", StringComparison.OrdinalIgnoreCase))
          {
            PackageReferences.Add("microsoft.testplatform.testhost");
            PackageReferences.Add("microsoft.codecoverage");
          }
          else
          {
            PackageReferences.Add(name);
          }
        }
      }

      foreach(var frameworkReference in _document.Descendants("FrameworkReference"))
      {
        // TODO naming .Ref?
        var name = frameworkReference.Attribute("Include").Value;
        PackageReferences.Add($"{name}.Ref");
      }

      foreach(var descendant in _document.Descendants("ProjectReference"))
      {
        var include = descendant.Attribute("Include").Value;
        var name = Path.GetFileNameWithoutExtension(include);

        if(importLabels.ContainsKey(name))
        {
          ProjectReference.Add(importLabels[name]);
        }
        else
        {
          ProjectReference.Add(csprojToLabel(Path.Combine(projectFileDir, include)));
        }
      }

      foreach(var bazelDataArray in _document.Descendants("BazelData"))
      {
        BazelData.AddRange(bazelDataArray.Value.Split(';'));
      }

      foreach(var resource in _document.Descendants("EmbeddedResource"))
      {
        var include = resource.Attribute("Include")?.Value;
        var remove = resource.Attribute("Remove")?.Value;
        var update = resource.Attribute("Update")?.Value;

        if(include != null)
        {
          EmbeddedResources.Add(new EmbeddedResourceDefinition(EmbeddedResourceType.Include, include));
        }
        if(remove != null)
        {
          EmbeddedResources.Add(new EmbeddedResourceDefinition(EmbeddedResourceType.Remove, remove));
        }
        if(update != null)
        {
          EmbeddedResources.Add(new EmbeddedResourceDefinition(EmbeddedResourceType.Update, update));
        }
      }

      foreach(var copyNode in _document.Descendants("CopyToOutputDirectory"))
      {
        // PreserveNewest ?

        var include = copyNode.Parent?.Attribute("Include")?.Value
                   ?? copyNode.Parent?.Attribute("Update")?.Value;
        if(include != null)
        {
          CopyToOutput.Add(include.Replace("\\", "/"));
        }
      }

      TestOnly = string.Equals(_document.Descendants("BazelTestOnly").LastOrDefault()?.Value, "true", StringComparison.OrdinalIgnoreCase);

      return this;
    }

    private ProjectType GetProjectType(XDocument document)
    {
      var outputType = document.Descendants("OutputType").FirstOrDefault();
      if(outputType != null && outputType.Value.Equals("Exe", StringComparison.OrdinalIgnoreCase))
      {
        return ProjectType.Binary;
      }

      if(RelativeFilePath.EndsWith("Test.csproj") || RelativeFilePath.EndsWith("Tests.csproj"))
      {
        return ProjectType.Test;
      }

      return ProjectType.Library;
    }
  }
}