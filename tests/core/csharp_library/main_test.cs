using System;
using System.IO;

using Xunit;

namespace example_test
{
    public class MyTest
    {
        [Fact]
        public void MyTest2()
        {
            Assert.True("bar" == "bar");
        }
        [Fact]
        public void CheckVersion()
        {
            var version = GetType().Assembly.GetName().Version;
            Assert.Equal(1, version.Major);
            Assert.Equal(0, version.Minor);
        }
    }
}
