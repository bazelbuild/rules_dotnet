using Lib;
using NUnit.Framework;
using System.Linq;

[TestFixture]
public sealed class LibTests
{
    [Test]
    public void SomeTest()
    {
        Assert.AreEqual(true, Stuff.IsTrue());
    }

    [Test]
    public void SomeTestInternal()
    {
        Assert.AreEqual(true, Stuff.IsTrueInternal());
    }
}

