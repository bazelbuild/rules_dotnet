using NUnit.Framework;
using System.Text.Json;

[TestFixture]
public sealed class LibTests
{
    [Test]
    public void ShouldResolveCToNetStandard21()
    {
        var options = new JsonSerializerOptions
        {
            WriteIndented = true
        };
        Assert.AreEqual(true, true);
    }
}

