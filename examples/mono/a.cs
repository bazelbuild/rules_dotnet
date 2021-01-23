using System;
using NUnit.Framework;

namespace example_tool
{
    [TestFixture]
    public class MainClass
    {
        [Test]
        public void MyTest1()
        {
            Assert.That("bar", Is.EqualTo("bar"));
        }
    }
}
