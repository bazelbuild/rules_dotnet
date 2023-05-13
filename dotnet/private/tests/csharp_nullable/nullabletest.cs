using Lib;
using NUnit.Framework;
using System.Linq;

[TestFixture]
public sealed class LibTests
{
    [Test]
    public void LibCompilesAndValueIsNull()
    {
        Assert.AreEqual(NullableEntity.GetValue(), null);
    }
}

