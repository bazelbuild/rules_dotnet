namespace Afas.BazelDotnet.Project
{
  internal class EmbeddedResourceDefinition
  {
    public EmbeddedResourceDefinition(EmbeddedResourceType type, string value)
    {
      Type = type;
      Value = value;
    }

    public EmbeddedResourceType Type { get; }

    public string Value { get; }

    public string GetNormalizedValue() => Value.Replace("\\", "/");
  }
}