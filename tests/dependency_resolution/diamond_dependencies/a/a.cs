using NUnit.Framework;
using System.Linq;
using AB;
using AC;

[TestFixture]
public sealed class LibTests {
    [Test]
    public void ShouldResolveCToNet60() {
        Assert.AreEqual("net6.0", AB.AB.GetLibDFramework());
        Assert.AreEqual("net6.0", AC.AC.GetLibDFramework());
    }
}

