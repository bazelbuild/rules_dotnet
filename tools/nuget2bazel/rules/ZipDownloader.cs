using System;
using System.Collections.Generic;
using System.IO;
using System.IO.Compression;
using System.Net;
using System.Text;
using System.Threading.Tasks;
using ICSharpCode.SharpZipLib.Tar;

namespace nuget2bazel.rules
{
    public static class ZipDownloader
    {
        public static async Task<string> DownloadIfNedeed(string configDir, string url)
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
                var dest = Path.Combine(dir, entry.FullName);
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
