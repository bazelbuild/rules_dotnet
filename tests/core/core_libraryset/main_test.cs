using System;
using System.IO;
using System.Reflection;

using Xunit;

namespace example_test
{
    public class MyTest
    {
        [Fact]
        public void MyTest2()
        {
            var src = Path.Combine(Path.GetDirectoryName(typeof(MyTest).Assembly.Location), "test.txt");
            Assert.True(File.Exists(src));
        }
    }
}
