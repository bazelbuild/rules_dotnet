using System;
using System.Threading.Tasks;
using System.Runtime.InteropServices;
using testlib;
using Xunit;

namespace nuget_single
{
    public class nuget_single : BazelTestBase
    {
        [Fact]
        public void TestRoslyn()
        {
            if (!RuntimeInformation.IsOSPlatform(OSPlatform.Windows))
                return;

            var files = new string[] { "BUILD.in", "WORKSPACE.in", "MyTest.cs.in" };

            string stdout, stderr;
            int rc = DoTest(files, out stdout, out stderr);
            Assert.Equal(0, rc);
        }
    }
}
