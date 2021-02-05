using System;
using System.IO;

using NUnit.Framework;

namespace example_test
{
    [TestFixture]
    public class MyTest
    {
        [Test]
        public void MyTest2()
        {
            Assert.AreEqual(true, File.Exists("custom_bin.dll"));
        }
    }
}
