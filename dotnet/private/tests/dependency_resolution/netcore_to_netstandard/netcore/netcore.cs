using NUnit.Framework;
using System.Linq;
using NetstandardLib;

[TestFixture]
public sealed class LibTests
{
    [Test]
    public void ShouldResolveCToNetStandard21()
    {
        Assert.AreEqual("netstandard2.1", NetstandardLib.NetstandardLib.GetCompileTimeFramework());
    }
}

