using NUnit.Framework;
using Bazel;
using System.IO;

[TestFixture]
public sealed class RunfilesTest
{
    [Test]
    public void ShouldBeAbleToReadDataFile()
    {
        var runfiles = Runfiles.Create();
        var dataFilePath = runfiles.Rlocation("rules_dotnet/dotnet/private/tests/runfiles/nested_folder/data-file");
        var data = File.ReadAllLines(dataFilePath)[0];
        Assert.AreEqual("SOME CRAZY DATA!", data);
    }
}
