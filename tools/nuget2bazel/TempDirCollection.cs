using System;
using System.Collections.Generic;
using System.IO;
using System.Text;

namespace nuget2bazel
{
    public class TempDirCollection : IDisposable
    {
        private List<string> _dirs = new List<string>();

        public string GetTempDir()
        {
            var d = Path.Combine(Path.GetTempPath(), "nuget2bazel", Guid.NewGuid().ToString());
            Directory.CreateDirectory(d);
            _dirs.Add(d);
            return d;
        }
        public void Dispose()
        {
            foreach (var d in _dirs)
            {
                try
                {
                    Directory.Delete(d, true);
                }
                catch (Exception)
                {

                }
            }
        }
    }
}
