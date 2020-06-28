using System;
using System.IO;
using System.Reflection;
using System.Text;

using Xunit;

namespace example_test
{
    public class MyTest
    {
        [Fact]
        public void CheckData1()
        {
            using var stream = typeof(MyTest).GetTypeInfo().Assembly.GetManifestResourceStream("example_test.data1.txt");
            using var reader = new StreamReader(stream, Encoding.UTF8);
            var txt = reader.ReadToEnd();
            Assert.Equal("data1", txt);
        }
        [Fact]
        public void CheckDataMulti1()
        {
            using var stream = typeof(MyTest).GetTypeInfo().Assembly.GetManifestResourceStream("example_test2.data1.txt");
            using var reader = new StreamReader(stream, Encoding.UTF8);
            var txt = reader.ReadToEnd();
            Assert.Equal("data1", txt);
        }

        [Fact]
        public void CheckDataMulti2()
        {
            using var stream = typeof(MyTest).GetTypeInfo().Assembly.GetManifestResourceStream("example_test2.data2.txt");
            using var reader = new StreamReader(stream, Encoding.UTF8);
            var txt = reader.ReadToEnd();
            Assert.Equal("data2", txt);
        }
    }
}
