using System;

using NUnit.Framework;

using example_lib;

namespace example_test
{
    [TestFixture]
    public class MyTest
    {
        [Test]
        public void MyTest1()
        {
            Assert.That("bar", Is.EqualTo("bar"));
        }
        [Test]
        public void MyTest2()
        {
            Assert.That(1, Is.EqualTo(1));
        }
        [Test]
        public void MyTest3()
        {
            Assert.That(2.0, Is.EqualTo(2.0));
        }
    }
}