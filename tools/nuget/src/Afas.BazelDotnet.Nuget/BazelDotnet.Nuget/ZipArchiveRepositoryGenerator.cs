using System;
using System.Collections.Generic;
using System.IO;
using System.Linq;
using System.Threading.Tasks;
using NuGet.Packaging.Core;

namespace Afas.BazelDotnet.Nuget
{
  public class ZipArchiveRepositoryGenerator
  {
    private readonly IDependencyResolver _dependencyResolver;

    public ZipArchiveRepositoryGenerator(string nugetConfig, string targetFramework, string targetRuntime)
      : this(new DependencyResolver(nugetConfig, targetFramework, targetRuntime))
    {
    }

    private ZipArchiveRepositoryGenerator(IDependencyResolver dependencyResolver)
    {
      _dependencyResolver = dependencyResolver;
    }

    public async Task Write(IEnumerable<(string package, string version)> packageReferences)
    {
      var packages = await _dependencyResolver.Resolve(packageReferences).ConfigureAwait(false);

      await using var file = File.Open("nuget.bzl", FileMode.Create, FileAccess.Write);
      await using var writer = new StreamWriter(file);

      Write(packages, writer);
    }

    private void Write(INugetRepositoryEntry[] nugetRepositoryEntries, TextWriter writer)
    {
      writer.WriteLine("packages = [");
      foreach(var entry in nugetRepositoryEntries)
      {
        writer.Write($"(\"{entry.Id}\", \"{entry.Version}\", \"{entry.Hash}\", [");
        foreach(var dependency in entry.DependencyGroups.SingleOrDefault()?.Packages ?? Array.Empty<PackageDependency>())
        {
          writer.Write($"\n  \"{dependency.Id}\",");
        }
        writer.WriteLine("]),");
      }
      writer.WriteLine("]");
    }
  }
}
