using NUnit.Framework;
using LibGit2Sharp;

[TestFixture]
public sealed class Tests
{
    [Test]
    public void TestShouldRunUsingNativeDependencies()
    {
        Assert.Throws<RepositoryNotFoundException>(() => { new Repository("./"); });
    }
}

