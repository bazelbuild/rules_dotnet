using System;
using Grpc.Core;
using Grpc.HealthCheck;
using Grpc.Health.V1;
using Xunit;

namespace Tests
{
    public class SomeServerTest
    {
        [Fact]
        public static void ServerBindsToAPort()
        {
            HealthServiceImpl health = new HealthServiceImpl();

            string host = "127.0.0.1";
            int port = 6000;

            var server = new Server
            {
                Services = {
                    Health.BindService(health),
                },
                Ports = { new ServerPort(host, port, ServerCredentials.Insecure) }
            };

            server.Start();

            foreach(var bound_port in server.Ports)
            {
                Assert.True(bound_port.Port > 0);
            }
        }
    }
}
