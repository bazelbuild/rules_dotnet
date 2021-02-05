using System;
using Grpc.Core;
using Grpc.HealthCheck;
using Grpc.Health.V1;
using Xunit;
using Helloworld;
using System.Threading.Tasks;

namespace Tests
{
    class GreeterImpl : Greeter.GreeterBase
    {
        // Server side handler of the SayHello RPC
        public override Task<HelloReply> SayHello(HelloRequest request, ServerCallContext context)
        {
            return Task.FromResult(new HelloReply { Message = "Hello " + request.Name });
        }
    }

    public class SomeServerTest
    {
        [Fact]
        public static async Task ServerBindsToAPort()
        {
            HealthServiceImpl health = new HealthServiceImpl();

            string host = "127.0.0.1";
            int port = 6000;

            var server = new Server
            {
                Services = {
                    Health.BindService(health),
                    Greeter.BindService(new GreeterImpl())
                },
                Ports = { new ServerPort(host, port, ServerCredentials.Insecure) }
            };

            server.Start();

            foreach (var bound_port in server.Ports)
            {
                Assert.True(bound_port.Port > 0);
            }

            Channel channel = new Channel("127.0.0.1:6000", ChannelCredentials.Insecure);
            var client = new Greeter.GreeterClient(channel);
            String user = "you";

            var reply = client.SayHello(new HelloRequest { Name = user });
            Assert.Equal("Hello you", reply.Message);

            await channel.ShutdownAsync();


        }
    }
}
