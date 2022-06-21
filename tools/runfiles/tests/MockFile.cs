using System;
using System.IO;
using System.Collections.Generic;
using System.Text;

namespace Bazel {
    public class MockFile : IDisposable {
        public readonly string Path;

        public MockFile(IEnumerable<string> lines) {
            var testTmpdir = Environment.GetEnvironmentVariable("TEST_TMPDIR");
            if (String.IsNullOrEmpty(testTmpdir)) {
                throw new Exception("TEST_TMPDIR is empty or undefined");
            }

            Path = System.IO.Path.Join(testTmpdir, System.IO.Path.GetRandomFileName());
            File.AppendAllLines(Path, lines, Encoding.UTF8);
        }

        public void Dispose()
        {
            if(Path != null) {
                File.Delete(Path);
            }
        }
    }
}
