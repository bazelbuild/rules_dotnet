using System;
using System.IO;
using System.Collections.Generic;
using System.Text;

namespace Bazel
{
    public class MockFile : IDisposable
    {
        public readonly string Path;

        public MockFile(IEnumerable<string> lines, string relativePath = null)
        {
            var testTmpdir = Environment.GetEnvironmentVariable("TEST_TMPDIR");
            if (String.IsNullOrEmpty(testTmpdir))
            {
                throw new Exception("TEST_TMPDIR is empty or undefined");
            }

            if (relativePath == null)
            {
                Path = System.IO.Path.Join(testTmpdir, System.IO.Path.GetRandomFileName());
            }
            else
            {
                Path = System.IO.Path.Join(testTmpdir, relativePath);
                var dir = System.IO.Directory.GetParent(Path).ToString();
                if (!System.IO.Directory.Exists(dir))
                {
                    System.IO.Directory.CreateDirectory(dir);

                }
            }
            File.AppendAllLines(Path, lines, Encoding.UTF8);
        }


        public void Dispose()
        {
            if (Path != null)
            {
                File.Delete(Path);
            }
        }
    }
}
