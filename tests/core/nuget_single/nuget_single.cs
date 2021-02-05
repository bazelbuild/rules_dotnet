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
        public async Task TestRoslyn()
        {
            if (!RuntimeInformation.IsOSPlatform(OSPlatform.Windows))
                return;

            var files = new string[] { "BUILD.in", "WORKSPACE.in", "MyTest.cs.in" };

            int rc = await DoTest(files);
            Assert.Equal(0, rc);
        }
    }
}
