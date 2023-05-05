using Lib;
using NUnit.Framework;
using System.Linq;

[TestFixture]
public sealed class LibTests
{
    [Test]
    public void LibCompilesAndValueIsSet()
    {
        Assert.AreEqual(UnsafeNode.GetZero(), 0);
    }
}

