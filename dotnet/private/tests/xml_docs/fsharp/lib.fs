/// <summary>
///   A module
/// </summary>
///
/// <namespacedoc>
///   <summary>A namespace to remember</summary>
///
///   <remarks>More on that</remarks>
/// </namespacedoc>
///
module SomeModule

/// <summary>
///   Some actual comment
///   <para>Another paragraph, see  <see cref="T:TheNamespace.SomeType"/>. </para>
/// </summary>
///
/// <param name="x">The input</param>
///
/// <returns>The output</returns>
///
/// <example>
///   Try using
///   <code>
///      open TheNamespace
///      SomeModule.a
///   </code>
/// </example>
///
/// <category>Foo</category>
let someFunction x = 42 + x

/// <summary>
///   A type, see  <see cref="T:TheNamespace.SomeModule"/> and
///  <see cref="M:TheNamespace.SomeModule.someFunction"/>.
/// </summary>
///
type SomeType() =
    member x.P = 1
