<!-- Generated with Stardoc: http://skydoc.bazel.build -->


Rules for compiling F# libraries.


<a id="fsharp_library"></a>

## fsharp_library

<pre>
fsharp_library(<a href="#fsharp_library-name">name</a>, <a href="#fsharp_library-data">data</a>, <a href="#fsharp_library-defines">defines</a>, <a href="#fsharp_library-deps">deps</a>, <a href="#fsharp_library-internals_visible_to">internals_visible_to</a>, <a href="#fsharp_library-keyfile">keyfile</a>, <a href="#fsharp_library-langversion">langversion</a>, <a href="#fsharp_library-out">out</a>,
               <a href="#fsharp_library-private_deps">private_deps</a>, <a href="#fsharp_library-resources">resources</a>, <a href="#fsharp_library-runtime_identifier">runtime_identifier</a>, <a href="#fsharp_library-srcs">srcs</a>, <a href="#fsharp_library-strict_deps">strict_deps</a>, <a href="#fsharp_library-target_frameworks">target_frameworks</a>)
</pre>

Compile a F# DLL

**ATTRIBUTES**


| Name  | Description | Type | Mandatory | Default |
| :------------- | :------------- | :------------- | :------------- | :------------- |
| <a id="fsharp_library-name"></a>name |  A unique name for this target.   | <a href="https://bazel.build/concepts/labels#target-names">Name</a> | required |  |
| <a id="fsharp_library-data"></a>data |  Runtime files. It is recommended to use the @rules_dotnet//tools/runfiles library to read the runtime files.   | <a href="https://bazel.build/concepts/labels">List of labels</a> | optional | [] |
| <a id="fsharp_library-defines"></a>defines |  A list of preprocessor directive symbols to define.   | List of strings | optional | [] |
| <a id="fsharp_library-deps"></a>deps |  Other libraries, binaries, or imported DLLs   | <a href="https://bazel.build/concepts/labels">List of labels</a> | optional | [] |
| <a id="fsharp_library-internals_visible_to"></a>internals_visible_to |  Other libraries that can see the assembly's internal symbols. Using this rather than the InternalsVisibleTo assembly attribute will improve build caching.   | List of strings | optional | [] |
| <a id="fsharp_library-keyfile"></a>keyfile |  The key file used to sign the assembly with a strong name.   | <a href="https://bazel.build/concepts/labels">Label</a> | optional | None |
| <a id="fsharp_library-langversion"></a>langversion |  The version string for the language.   | String | optional | "" |
| <a id="fsharp_library-out"></a>out |  File name, without extension, of the built assembly.   | String | optional | "" |
| <a id="fsharp_library-private_deps"></a>private_deps |  Private dependencies <br><br>        This attribute should be used for dependencies are only private to the target.          The dependencies will not be propagated transitively to parent targets and          do not become part of the targets runfiles.   | <a href="https://bazel.build/concepts/labels">List of labels</a> | optional | [] |
| <a id="fsharp_library-resources"></a>resources |  A list of files to embed in the DLL as resources.   | <a href="https://bazel.build/concepts/labels">List of labels</a> | optional | [] |
| <a id="fsharp_library-runtime_identifier"></a>runtime_identifier |  The runtime identifier that is being targeted. See https://docs.microsoft.com/en-us/dotnet/core/rid-catalog   | String | required |  |
| <a id="fsharp_library-srcs"></a>srcs |  The source files used in the compilation.   | <a href="https://bazel.build/concepts/labels">List of labels</a> | optional | [] |
| <a id="fsharp_library-strict_deps"></a>strict_deps |  Whether to use strict dependencies or not. <br><br>        This attribute mirrors the DisableTransitiveProjectReferences in MSBuild.         The default setting of this attribute can be overridden in the toolchain configuration   | Boolean | optional | True |
| <a id="fsharp_library-target_frameworks"></a>target_frameworks |  A list of target framework monikers to buildSee https://docs.microsoft.com/en-us/dotnet/standard/frameworks   | List of strings | required |  |


