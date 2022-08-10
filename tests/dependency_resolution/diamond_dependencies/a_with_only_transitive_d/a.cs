using NUnit.Framework;
using System.Linq;
using AB;
using AC;

[TestFixture]
public sealed class LibTests
{
    [Test]
    public void ShouldResolveCToNetStandard21()
    {
        // Since A only depends on D transitively we should get the netstandard2.1 version of D
        // because AC only supports netstandard2.1
        Assert.AreEqual("netstandard2.1", AB.AB.GetLibDFramework(), "Wrong framework from AB");
        Assert.AreEqual("netstandard2.1", AC.AC.GetLibDFramework(), "Wrong framework from AC");
    }
}

