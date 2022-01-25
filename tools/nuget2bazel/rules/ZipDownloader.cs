using System;
using System.Collections.Generic;
using System.IO;
using System.IO.Compression;
using System.Net;
using System.Runtime.InteropServices;
using System.Text;
using System.Threading.Tasks;
using ICSharpCode.SharpZipLib.Tar;

namespace nuget2bazel.rules
{
    public static class ZipDownloader
    {
        public static async Task<string> DownloadIfNeeded(string configDir, string url)
        {
            var fname = Path.GetFileName(url);
            var dir = Path.Combine(configDir, Path.GetFileNameWithoutExtension(fname));
            if (Directory.Exists(dir))
                return dir;

            var client = new WebClient();
            var downloadedFile = Path.Combine(configDir, fname);
            if (!File.Exists(downloadedFile))
                await client.DownloadFileTaskAsync(new Uri(url), downloadedFile);

            if (Path.GetExtension(fname) != ".zip")
                UntarFile(downloadedFile, dir);
            else
                UnzipFile(downloadedFile, dir);

            return dir;
        }

        private static void UnzipFile(string file, string dir)
        {
            using var archive = ZipFile.OpenRead(file);
            foreach (var entry in archive.Entries)
            {
                // This allows you to run this program on Linux/MacOS since the
                // Windows zip files have `\` intead of `/` in their paths
                var fullName = RuntimeInformation.IsOSPlatform(OSPlatform.Windows) ? entry.FullName : entry.FullName.Replace("\\", "/");
                var dest = Path.Combine(dir, fullName);
                Directory.CreateDirectory(Path.GetDirectoryName(dest));
                if (!File.Exists(dest))
                    entry.ExtractToFile(dest);
            }
        }

        private static void UntarFile(string file, string dir)
        {
            using var instream = File.OpenRead(file);
            using var decompressed = new GZipStream(instream, CompressionMode.Decompress);
            using var archive = TarArchive.CreateInputTarArchive(decompressed);

            archive.ExtractContents(dir);
        }
    }
}
