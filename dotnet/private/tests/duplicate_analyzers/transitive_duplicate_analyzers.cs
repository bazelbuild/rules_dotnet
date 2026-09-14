using System.Text.Json.Serialization;

public class TransitiveItem
{
    public string Name { get; set; }
}

[JsonSerializable(typeof(TransitiveItem))]
public partial class TransitiveItemContext : JsonSerializerContext
{
}
