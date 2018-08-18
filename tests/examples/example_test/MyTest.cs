using System;

using NUnit.Framework;

using example_lib;

namespace example_test
{
    [TestFixture]
    public class MyTest
    {
        [Test]
        [ExpectedException( typeof( ArgumentException ) )]
        public void MyTest1()
        {
            throw new ArgumentException();
        }

        [Test]
        public void MyTest2()
        {
            Assert.That("bar", Is.EqualTo("bar"));
        }
        [Test]
        public void MyTest3()
        {
            Assert.That(1, Is.EqualTo(1));
        }
    }
}