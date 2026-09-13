public static class Program
{
    public static void Main()
    {
        var assembly = System.Reflection.Assembly.GetExecutingAssembly();
        const string name = "GeneratedResource.Library.generated.txt";

        using var stream = assembly.GetManifestResourceStream(name);
        if (stream == null)
        {
            throw new System.Exception(
                $"Expected {name} to be embedded, found [{string.Join(", ", assembly.GetManifestResourceNames())}]"
            );
        }

        using var reader = new System.IO.StreamReader(stream);
        var content = reader.ReadToEnd().Trim();
        if (content != "generated at build time")
        {
            throw new System.Exception($"Expected the generated content but got '{content}'");
        }
    }
}
