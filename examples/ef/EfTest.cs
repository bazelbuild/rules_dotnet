using System;
using Xunit;
using Microsoft.EntityFrameworkCore;

namespace Tests
{
    public class SomeServerTest
    {
        [Fact]
        public void DoTest()
        {
            // Check entity framework
            var g = new Guid();
            var z = new DbContextId(g, 1);
            Assert.Equal(g, z.InstanceId);

            // Check aspnet core
            var builder = Microsoft.AspNetCore.WebHost.CreateDefaultBuilder();
            Assert.NotNull(builder);
        }
    }
}
