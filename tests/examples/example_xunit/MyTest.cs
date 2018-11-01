using System;
using Xunit;

namespace example_test
{
    public class MyTest
    {
        [Fact]
        public void MyTest2()
        {
            Assert.True("bar"=="bar");
        }
        [Fact]
        public void MyTest3()
        {
            Assert.True(1==1);
        }
    }
}