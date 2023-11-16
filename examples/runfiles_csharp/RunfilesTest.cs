using NUnit.Framework;
using Bazel;
using System.IO;

[TestFixture]
public sealed class RunfilesTest {
    [Test]
    public void ShouldBeAbleToReadDataFile() {
        var runfiles = Runfiles.Create();
        var dataFilePath = runfiles.Rlocation("rules_dotnet_examples/runfiles_csharp/data-file");
        var data = File.ReadAllLines(dataFilePath)[0];
        Assert.AreEqual("SOME CRAZY DATA!", data);
    }
}
