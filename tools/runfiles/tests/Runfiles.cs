using NUnit.Framework;
using System.Linq;
using System;
using Bazel;
using System.IO;
using System.Collections.Generic;
using System.Text;

[TestFixture]
public sealed class RunfilesTest
{
    private static bool isWindows()
    {
        return OperatingSystem.IsWindows();
    }

    private void assertRlocationArg(Runfiles runfiles, String path, String error)
    {

        var e = Assert.Throws<ArgumentException>(() => runfiles.Rlocation(path));
        if (error != null)
        {
            StringAssert.Contains(error, e.Message);
        }
    }

    private string createTempDirectory()
    {
        var testTmp = Environment.GetEnvironmentVariable("TEST_TMPDIR");

        if (testTmp == null)
        {
            testTmp = Path.GetTempPath();
        }

        testTmp = Path.Combine(testTmp, Path.GetRandomFileName());
        Directory.CreateDirectory(testTmp);

        return testTmp;
    }

    [Test]
    public void RlocationArgumentValidation()
    {
        var dir = createTempDirectory();

        Runfiles r = Runfiles.Create(new Dictionary<string, string> { { "RUNFILES_DIR", dir } });
        assertRlocationArg(r, null, null);
        assertRlocationArg(r, "", null);
        assertRlocationArg(r, "../foo", "is not normalized");
        assertRlocationArg(r, "foo/..", "is not normalized");
        assertRlocationArg(r, "foo/../bar", "is not normalized");
        assertRlocationArg(r, "./foo", "is not normalized");
        assertRlocationArg(r, "foo/.", "is not normalized");
        assertRlocationArg(r, "foo/./bar", "is not normalized");
        assertRlocationArg(r, "//foobar", "is not normalized");
        assertRlocationArg(r, "foo//", "is not normalized");
        assertRlocationArg(r, "foo//bar", "is not normalized");
        assertRlocationArg(r, "\\foo", "path is absolute without a drive letter");
    }

    [Test]
    public void CreatesManifestBasedRunfiles()
    {
        using (MockFile mf = new MockFile(new string[1] { "a/b c/d" }))
        {
            Runfiles r =
                Runfiles.Create(
                    new Dictionary<string, string>{
                       {"RUNFILES_MANIFEST_ONLY", "1"},
                       {"RUNFILES_MANIFEST_FILE", mf.Path},
                       {"RUNFILES_DIR", "ignored when RUNFILES_MANIFEST_ONLY=1"},
                       {"JAVA_RUNFILES", "ignored when RUNFILES_DIR has a value"},
                       {"TEST_SRCDIR", "should always be ignored"}});
            Assert.AreEqual("c/d", r.Rlocation("a/b"));
            Assert.Null(r.Rlocation("foo"));

            if (isWindows())
            {
                Assert.AreEqual("c:/foo", r.Rlocation("c:/foo"));
                Assert.AreEqual("c:\\foo", r.Rlocation("c:\\foo"));
            }
            else
            {
                Assert.AreEqual("/foo", r.Rlocation("/foo"));
            }
        }
    }

    [Test]
    public void CreatesDirectoryBasedRunfiles()
    {
        var dir = createTempDirectory();

        var r =
            Runfiles.Create(
                new Dictionary<string, string> {
                    {"RUNFILES_MANIFEST_FILE", "ignored when RUNFILES_MANIFEST_ONLY is not set to 1"},
                    {"RUNFILES_DIR", dir},
                    {"JAVA_RUNFILES", "ignored when RUNFILES_DIR has a value"},
                    {"TEST_SRCDIR", "should always be ignored"} });

        StringAssert.EndsWith("a/b", r.Rlocation("a/b"));
        StringAssert.EndsWith("foo", r.Rlocation("/foo"));

        r =
            Runfiles.Create(
                new Dictionary<string, string>{
                    {"RUNFILES_MANIFEST_FILE", "ignored when RUNFILES_MANIFEST_ONLY is not set to 1"},
                    {"RUNFILES_DIR", ""},
                    {"JAVA_RUNFILES", dir},
                    {"TEST_SRCDIR", "should always be ignored"}});
        StringAssert.EndsWith("a/b", r.Rlocation("/a/b"));
        StringAssert.EndsWith("foo", r.Rlocation("/foo"));
    }

    [Test]
    public void IgnoresTestSrcdirWhenJavaRunfilesIsUndefinedAndJustFails()
    {
        var dir = createTempDirectory();

        Runfiles.Create(
            new Dictionary<string, string>{
                {"RUNFILES_DIR", dir},
                {"RUNFILES_MANIFEST_FILE", "ignored when RUNFILES_MANIFEST_ONLY is not set to 1"},
                {"TEST_SRCDIR", "should always be ignored"}});

        Runfiles.Create(
             new Dictionary<string, string>{
                {"JAVA_RUNFILES", dir},
                {"RUNFILES_MANIFEST_FILE", "ignored when RUNFILES_MANIFEST_ONLY is not set to 1"},
                {"TEST_SRCDIR", "should always be ignored"}});

        var e =
             Assert.Throws<FileNotFoundException>(
                 () =>
                     Runfiles.Create(
                         new Dictionary<string, string>{
                            {"RUNFILES_DIR", ""},
                            {"JAVA_RUNFILES", ""},
                            {"RUNFILES_MANIFEST_FILE",
                                "ignored when RUNFILES_MANIFEST_ONLY is not set to 1"},
                            {"TEST_SRCDIR", "should always be ignored"}}));
        StringAssert.Contains("$RUNFILES_DIR and $JAVA_RUNFILES", e.Message);
    }

    [Test]
    public void FailsToCreateManifestBasedBecauseManifestDoesNotExist()
    {
        var e =
        Assert.Throws<FileNotFoundException>(
            () =>
                Runfiles.Create(
                    new Dictionary<string, string>{
                        {"RUNFILES_MANIFEST_ONLY", "1"},
                        {"RUNFILES_MANIFEST_FILE", "non-existing path"}}));
        StringAssert.Contains("non-existing path", e.Message);
    }

    [Test]
    public void ManifestBasedEnvVars()
    {
        var dir =
            createTempDirectory();

        var mf = Path.Combine(dir, "MANIFEST");
        File.WriteAllLines(mf, new string[0] { }, Encoding.UTF8);
        var envvars =
            Runfiles.Create(
                    new Dictionary<string, string>{
                    {"RUNFILES_MANIFEST_ONLY", "1"},
                    {"RUNFILES_MANIFEST_FILE", mf},
                    {"RUNFILES_DIR", "ignored when RUNFILES_MANIFEST_ONLY=1"},
                    {"JAVA_RUNFILES", "ignored when RUNFILES_DIR has a value"},
                    {"TEST_SRCDIR", "should always be ignored"}})
                .GetEnvVars();
        CollectionAssert.AreEquivalent(new string[4] { "RUNFILES_MANIFEST_ONLY", "RUNFILES_MANIFEST_FILE", "RUNFILES_DIR", "JAVA_RUNFILES" }, envvars.Keys);
        Assert.AreEqual("1", envvars["RUNFILES_MANIFEST_ONLY"]);
        Assert.AreEqual(mf, envvars["RUNFILES_MANIFEST_FILE"]);
        Assert.AreEqual(dir, envvars["RUNFILES_DIR"]);
        Assert.AreEqual(dir, envvars["JAVA_RUNFILES"]);

        var rfDir = Path.Combine(dir, "foo.runfiles");
        Directory.CreateDirectory(rfDir);
        mf = Path.Join(dir, "foo.runfiles_manifest");
        File.WriteAllLines(mf, new string[0] { }, Encoding.UTF8);
        envvars =
            Runfiles.Create(
                    new Dictionary<string, string>{
                    {"RUNFILES_MANIFEST_ONLY", "1"},
                    {"RUNFILES_MANIFEST_FILE", mf},
                    {"RUNFILES_DIR", "ignored when RUNFILES_MANIFEST_ONLY=1"},
                    {"JAVA_RUNFILES", "ignored when RUNFILES_DIR has a value"},
                    {"TEST_SRCDIR", "should always be ignored"}})
                .GetEnvVars();
        Assert.AreEqual("1", envvars["RUNFILES_MANIFEST_ONLY"]);
        Assert.AreEqual(mf, envvars["RUNFILES_MANIFEST_FILE"]);
        Assert.AreEqual(rfDir, envvars["RUNFILES_DIR"]);
        Assert.AreEqual(rfDir, envvars["JAVA_RUNFILES"]);

    }

    [Test]
    public void DirectoryBasedEnvVars()
    {
        var dir =
            createTempDirectory();

        var envvars =
            Runfiles.Create(
                    new Dictionary<string, string>{
                    {"RUNFILES_MANIFEST_FILE",
                    "ignored when RUNFILES_MANIFEST_ONLY is not set to 1"},
                    {"RUNFILES_DIR",
                    dir},
                    {"JAVA_RUNFILES",
                    "ignored when RUNFILES_DIR has a value"},
                    {"TEST_SRCDIR",
                    "should always be ignored"}})
                .GetEnvVars();
        CollectionAssert.AreEquivalent(new string[2] { "RUNFILES_DIR", "JAVA_RUNFILES" }, envvars.Keys);
        Assert.AreEqual(dir, envvars["RUNFILES_DIR"]);
        Assert.AreEqual(dir, envvars["JAVA_RUNFILES"]);
    }

    [Test]
    public void DirectoryBasedRlocation()
    {
        // The DirectoryBased implementation simply joins the runfiles directory and the runfile's path
        // on a "/". DirectoryBased does not perform any normalization, nor does it check that the path
        // exists.
        var dir = Path.Combine(Environment.GetEnvironmentVariable("TEST_TMPDIR"), "mock/runfiles");
        Directory.CreateDirectory(dir);
        var r = Runfiles.CreateDirectoryBasedForTesting(dir);
        // Escaping for "\": once for string and once for regex.
        StringAssert.IsMatch(".*[/\\\\]mock[/\\\\]runfiles[/\\\\]arg", r.Rlocation("arg"));
    }

    [Test]
    public void ManifestBasedRlocation()
    {
        using (var mf =
            new MockFile(
                new string[3]{
                "Foo/runfile1 C:/Actual Path\\runfile1",
                "Foo/Bar/runfile2 D:\\the path\\run file 2.txt",
                "Foo/Bar/Dir E:\\Actual Path\\Directory"}))
        {
            var r = Runfiles.CreateManifestBasedForTesting(mf.Path);
            Assert.AreEqual("C:/Actual Path\\runfile1", r.Rlocation("Foo/runfile1"));
            Assert.AreEqual("D:\\the path\\run file 2.txt", r.Rlocation("Foo/Bar/runfile2"));
            Assert.AreEqual("E:\\Actual Path\\Directory", r.Rlocation("Foo/Bar/Dir"));
            Assert.AreEqual("E:\\Actual Path\\Directory/File", r.Rlocation("Foo/Bar/Dir/File"));
            Assert.AreEqual("E:\\Actual Path\\Directory/Deeply/Nested/File", r.Rlocation("Foo/Bar/Dir/Deeply/Nested/File"));
            Assert.IsNull(r.Rlocation("unknown"));
        }
    }

    [Test]
    public void DirectoryBasedCtorArgumentValidation()
    {
        Assert.Throws<ArgumentException>(

            () => Runfiles.CreateDirectoryBasedForTesting(null));

        Assert.Throws<ArgumentException>(() => Runfiles.CreateDirectoryBasedForTesting(""));

        Assert.Throws<ArgumentException>(
            () => Runfiles.CreateDirectoryBasedForTesting("non-existent directory is bad"));

        Runfiles.CreateDirectoryBasedForTesting(Environment.GetEnvironmentVariable("TEST_TMPDIR"));
    }

    [Test]
    public void ManifestBasedCtorArgumentValidation()
    {
        Assert.Throws<FileNotFoundException>(
            () => Runfiles.CreateManifestBasedForTesting(null));

        Assert.Throws<FileNotFoundException>(() => Runfiles.CreateManifestBasedForTesting(""));

        using (var mf = new MockFile(new string[1] { "a b" }))
        {
            Runfiles.CreateManifestBasedForTesting(mf.Path);
        }
    }
}

