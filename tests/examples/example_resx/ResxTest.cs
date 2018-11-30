using System;
using Xunit;

namespace example_resx
{
    public class ResxTest
    {
        [Fact]
        public void Test1()
        {
            Assert.True(Resources.Test1 == "This is a test");
        }
    }
}
