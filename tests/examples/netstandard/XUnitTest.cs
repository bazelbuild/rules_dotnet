using System;
using Xunit;

namespace netstandard
{
    public class MyTest
    {
        [Fact]
        public void MyTest3()
        {
            var l = new Lib();
            Assert.True(l.Message == "Ok");
        }
    }
}