using System;
using Xunit;
using System.Buffers.Operations;

namespace Tests
{
    public class TestInterface : IBufferOperation
    {
        public System.Buffers.OperationStatus Execute(ReadOnlySpan<byte> a1, Span<byte> a2, out int a3, out int a4)
        {
            throw new NotImplementedException();
        }
    }
    public class SomeTest
    {
        [Fact]
        public void DoTest()
        {
            var r = new TestInterface();
            Assert.NotNull(r);
        }
    }
}
