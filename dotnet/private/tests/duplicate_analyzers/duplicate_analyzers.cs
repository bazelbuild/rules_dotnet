using System.Text.Json.Serialization;

public class Item
{
    public string Name { get; set; }
}

// The generator emits the other half of this partial class, so a second run of
// it fails the compilation.
[JsonSerializable(typeof(Item))]
public partial class ItemContext : JsonSerializerContext
{
}
