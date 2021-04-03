<!-- Generated with Stardoc: http://skydoc.bazel.build -->

<a id="#core_download_sdk"></a>

## core_download_sdk

<pre>
core_download_sdk(<a href="#core_download_sdk-name">name</a>, <a href="#core_download_sdk-arch">arch</a>, <a href="#core_download_sdk-os">os</a>, <a href="#core_download_sdk-repo_mapping">repo_mapping</a>, <a href="#core_download_sdk-runtimeVersion">runtimeVersion</a>, <a href="#core_download_sdk-sdkVersion">sdkVersion</a>, <a href="#core_download_sdk-sdks">sdks</a>, <a href="#core_download_sdk-strip_prefix">strip_prefix</a>)
</pre>

This downloads .NET Core SDK for given version. It usually is not used directly. Use [dotnet_repositories](api.md#dotnet_repositories) instead.


**ATTRIBUTES**


| Name  | Description | Type | Mandatory | Default |
| :------------- | :------------- | :------------- | :------------- | :------------- |
| <a id="core_download_sdk-name"></a>name |  A unique name for this repository.   | <a href="https://bazel.build/docs/build-ref.html#name">Name</a> | required |  |
| <a id="core_download_sdk-arch"></a>arch |  Architecture for the SDK.   | String | required |  |
| <a id="core_download_sdk-os"></a>os |  Operating system for the SDK.   | String | required |  |
| <a id="core_download_sdk-repo_mapping"></a>repo_mapping |  A dictionary from local repository name to global repository name. This allows controls over workspace dependency resolution for dependencies of this repository.&lt;p&gt;For example, an entry <code>"@foo": "@bar"</code> declares that, for any time this repository depends on <code>@foo</code> (such as a dependency on <code>@foo//some:target</code>, it should actually resolve that dependency within globally-declared <code>@bar</code> (<code>@bar//some:target</code>).   | <a href="https://bazel.build/docs/skylark/lib/dict.html">Dictionary: String -> String</a> | required |  |
| <a id="core_download_sdk-runtimeVersion"></a>runtimeVersion |  Runtime version to use. It's bound to sdkVersion.   | String | required |  |
| <a id="core_download_sdk-sdkVersion"></a>sdkVersion |  SDK version to use.   | String | required |  |
| <a id="core_download_sdk-sdks"></a>sdks |  Map of URLs. See CORE_SDK_REPOSITORIES in dotnet/private/toolchain/toolchains.bzl for the expected shape of the parameter.   | <a href="https://bazel.build/docs/skylark/lib/dict.html">Dictionary: String -> List of strings</a> | required |  |
| <a id="core_download_sdk-strip_prefix"></a>strip_prefix |  If present then provided prefix is stripped when extracting SDK.   | String | optional | "" |


<a id="#core_import_binary"></a>

## core_import_binary

<pre>
core_import_binary(<a href="#core_import_binary-name">name</a>, <a href="#core_import_binary-data">data</a>, <a href="#core_import_binary-data_with_dirs">data_with_dirs</a>, <a href="#core_import_binary-deps">deps</a>, <a href="#core_import_binary-ref">ref</a>, <a href="#core_import_binary-src">src</a>, <a href="#core_import_binary-version">version</a>)
</pre>

This imports an external assembly and transforms it into .NET Core binary. 


**ATTRIBUTES**


| Name  | Description | Type | Mandatory | Default |
| :------------- | :------------- | :------------- | :------------- | :------------- |
| <a id="core_import_binary-name"></a>name |  A unique name for this target.   | <a href="https://bazel.build/docs/build-ref.html#name">Name</a> | required |  |
| <a id="core_import_binary-data"></a>data |  Additional files to copy with the target assembly.   | <a href="https://bazel.build/docs/build-ref.html#labels">List of labels</a> | optional | [] |
| <a id="core_import_binary-data_with_dirs"></a>data_with_dirs |  Dictionary of {label:folder}. Files specified by &lt;label&gt; will be put in subdirectory &lt;folder&gt;.   | <a href="https://bazel.build/docs/skylark/lib/dict.html">Dictionary: Label -> String</a> | optional | {} |
| <a id="core_import_binary-deps"></a>deps |  The direct dependencies of this dll. These may be rules or compatible rules with the [DotnetLibraryInfo](api.md#dotnetlibraryinfo) provider.   | <a href="https://bazel.build/docs/build-ref.html#labels">List of labels</a> | optional | [] |
| <a id="core_import_binary-ref"></a>ref |  [Reference assembly](https://docs.microsoft.com/en-us/dotnet/standard/assembly/reference-assemblies) for given library.   | <a href="https://bazel.build/docs/build-ref.html#labels">Label</a> | optional | None |
| <a id="core_import_binary-src"></a>src |  The file to be transformed into [DotnetLibraryInfo](api.md#dotnetlibraryinfo) provider.   | <a href="https://bazel.build/docs/build-ref.html#labels">Label</a> | required |  |
| <a id="core_import_binary-version"></a>version |  Version of the imported assembly.   | String | required |  |


<a id="#core_import_library"></a>

## core_import_library

<pre>
core_import_library(<a href="#core_import_library-name">name</a>, <a href="#core_import_library-data">data</a>, <a href="#core_import_library-deps">deps</a>, <a href="#core_import_library-ref">ref</a>, <a href="#core_import_library-src">src</a>, <a href="#core_import_library-version">version</a>)
</pre>

This imports an external dll and transforms it into [DotnetLibraryInfo](api.md#dotnetlibraryinfo) so it can be referenced as dependency by other rules.


**ATTRIBUTES**


| Name  | Description | Type | Mandatory | Default |
| :------------- | :------------- | :------------- | :------------- | :------------- |
| <a id="core_import_library-name"></a>name |  A unique name for this target.   | <a href="https://bazel.build/docs/build-ref.html#name">Name</a> | required |  |
| <a id="core_import_library-data"></a>data |  Additional files to copy with the target assembly.   | <a href="https://bazel.build/docs/build-ref.html#labels">List of labels</a> | optional | [] |
| <a id="core_import_library-deps"></a>deps |  The direct dependencies of this dll. These may be compatible with the [DotnetLibraryInfo](api.md#dotnetlibraryinfo) provider.   | <a href="https://bazel.build/docs/build-ref.html#labels">List of labels</a> | optional | [] |
| <a id="core_import_library-ref"></a>ref |  [Reference assembly](https://docs.microsoft.com/en-us/dotnet/standard/assembly/reference-assemblies) for given library.   | <a href="https://bazel.build/docs/build-ref.html#labels">Label</a> | optional | None |
| <a id="core_import_library-src"></a>src |  The file to be transformed into [DotnetLibraryInfo](api.md#dotnetlibraryinfo) provider.   | <a href="https://bazel.build/docs/build-ref.html#labels">Label</a> | required |  |
| <a id="core_import_library-version"></a>version |  Version of the imported assembly.   | String | required |  |


<a id="#core_libraryset"></a>

## core_libraryset

<pre>
core_libraryset(<a href="#core_libraryset-name">name</a>, <a href="#core_libraryset-data">data</a>, <a href="#core_libraryset-deps">deps</a>)
</pre>

Groups libraries into sets which may be used as dependency.


**ATTRIBUTES**


| Name  | Description | Type | Mandatory | Default |
| :------------- | :------------- | :------------- | :------------- | :------------- |
| <a id="core_libraryset-name"></a>name |  A unique name for this target.   | <a href="https://bazel.build/docs/build-ref.html#name">Name</a> | required |  |
| <a id="core_libraryset-data"></a>data |  The list of additional files to include in the list of runfiles for compiled assembly.   | <a href="https://bazel.build/docs/build-ref.html#labels">List of labels</a> | optional | [] |
| <a id="core_libraryset-deps"></a>deps |  The list of dependencies.   | <a href="https://bazel.build/docs/build-ref.html#labels">List of labels</a> | optional | [] |


<a id="#core_resource"></a>

## core_resource

<pre>
core_resource(<a href="#core_resource-name">name</a>, <a href="#core_resource-identifier">identifier</a>, <a href="#core_resource-src">src</a>)
</pre>

This wraps a resource so it can be embeded into an assembly.


**ATTRIBUTES**


| Name  | Description | Type | Mandatory | Default |
| :------------- | :------------- | :------------- | :------------- | :------------- |
| <a id="core_resource-name"></a>name |  A unique name for this target.   | <a href="https://bazel.build/docs/build-ref.html#name">Name</a> | required |  |
| <a id="core_resource-identifier"></a>identifier |  The logical name for the resource; the name is used to load the resource. The default is the basename of the file name (no subfolder).   | String | optional | "" |
| <a id="core_resource-src"></a>src |  The source to be embeded.   | <a href="https://bazel.build/docs/build-ref.html#labels">Label</a> | required |  |


<a id="#core_resource_multi"></a>

## core_resource_multi

<pre>
core_resource_multi(<a href="#core_resource_multi-name">name</a>, <a href="#core_resource_multi-fixedIdentifierBase">fixedIdentifierBase</a>, <a href="#core_resource_multi-identifierBase">identifierBase</a>, <a href="#core_resource_multi-srcs">srcs</a>)
</pre>

This wraps multiple resource files so they can be embeded into an assembly.


**ATTRIBUTES**


| Name  | Description | Type | Mandatory | Default |
| :------------- | :------------- | :------------- | :------------- | :------------- |
| <a id="core_resource_multi-name"></a>name |  A unique name for this target.   | <a href="https://bazel.build/docs/build-ref.html#name">Name</a> | required |  |
| <a id="core_resource_multi-fixedIdentifierBase"></a>fixedIdentifierBase |  The logical name for given resource is constructred from fixedIdentiferBase + "." + filename. The resulting name that is used to load the resource. Either identifierBase of fixedIdentifierBase must be specified.   | String | optional | "" |
| <a id="core_resource_multi-identifierBase"></a>identifierBase |  The logical name for given resource is constructred from identiferBase + "." + directory.repalce('/','.') + "." + filename. The resulting name is used to load the resource. Either identifierBase of fixedIdentifierBase must be specified.   | String | optional | "" |
| <a id="core_resource_multi-srcs"></a>srcs |  The source files to be embeded.   | <a href="https://bazel.build/docs/build-ref.html#labels">List of labels</a> | required |  |


<a id="#core_resx"></a>

## core_resx

<pre>
core_resx(<a href="#core_resx-name">name</a>, <a href="#core_resx-identifier">identifier</a>, <a href="#core_resx-out">out</a>, <a href="#core_resx-simpleresgen">simpleresgen</a>, <a href="#core_resx-src">src</a>)
</pre>

This builds a dotnet .resources file from a single .resx file. Uses a custom tool to convert text .resx file to .resources files because no standard tool is provided.


**ATTRIBUTES**


| Name  | Description | Type | Mandatory | Default |
| :------------- | :------------- | :------------- | :------------- | :------------- |
| <a id="core_resx-name"></a>name |  A unique name for this target.   | <a href="https://bazel.build/docs/build-ref.html#name">Name</a> | required |  |
| <a id="core_resx-identifier"></a>identifier |  The logical name for the resource; the name that is used to load the resource. The default is the basename of the file name (no subfolder).   | String | optional | "" |
| <a id="core_resx-out"></a>out |  An alternative name of the output file   | String | optional | "" |
| <a id="core_resx-simpleresgen"></a>simpleresgen |  An alternative tool for generating resources file.   | <a href="https://bazel.build/docs/build-ref.html#labels">Label</a> | optional | @io_bazel_rules_dotnet//tools/simpleresgen:simpleresgen.exe |
| <a id="core_resx-src"></a>src |  The .resx source file that is transformed into .resources file.   | <a href="https://bazel.build/docs/build-ref.html#labels">Label</a> | required |  |


<a id="#core_stdlib"></a>

## core_stdlib

<pre>
core_stdlib(<a href="#core_stdlib-name">name</a>, <a href="#core_stdlib-data">data</a>, <a href="#core_stdlib-deps">deps</a>, <a href="#core_stdlib-dll">dll</a>, <a href="#core_stdlib-dotnet_context_data">dotnet_context_data</a>, <a href="#core_stdlib-ref">ref</a>, <a href="#core_stdlib-stdlib_path">stdlib_path</a>, <a href="#core_stdlib-version">version</a>)
</pre>

It imports a framework dll and transforms it into [DotnetLibraryInfo](api.md#dotnetlibraryinfo) so it can be referenced as dependency by other rules.


**ATTRIBUTES**


| Name  | Description | Type | Mandatory | Default |
| :------------- | :------------- | :------------- | :------------- | :------------- |
| <a id="core_stdlib-name"></a>name |  A unique name for this target.   | <a href="https://bazel.build/docs/build-ref.html#name">Name</a> | required |  |
| <a id="core_stdlib-data"></a>data |  Additional files to copy with the target assembly.   | <a href="https://bazel.build/docs/build-ref.html#labels">List of labels</a> | optional | [] |
| <a id="core_stdlib-deps"></a>deps |  The direct dependencies of this dll. These may be rules or compatible rules with the [DotnetLibraryInfo](api.md#dotnetlibraryinfo) provider.   | <a href="https://bazel.build/docs/build-ref.html#labels">List of labels</a> | optional | [] |
| <a id="core_stdlib-dll"></a>dll |  -   | String | optional | "" |
| <a id="core_stdlib-dotnet_context_data"></a>dotnet_context_data |  -   | <a href="https://bazel.build/docs/build-ref.html#labels">Label</a> | optional | @io_bazel_rules_dotnet//:core_context_data |
| <a id="core_stdlib-ref"></a>ref |  [Reference assembly](https://docs.microsoft.com/en-us/dotnet/standard/assembly/reference-assemblies) for given library.   | <a href="https://bazel.build/docs/build-ref.html#labels">Label</a> | optional | None |
| <a id="core_stdlib-stdlib_path"></a>stdlib_path |  The stdlib_path to be used instead of looking for one in sdk by name speeds up the rule execution because the proper file needs not to be searched for within sdk.   | <a href="https://bazel.build/docs/build-ref.html#labels">Label</a> | optional | None |
| <a id="core_stdlib-version"></a>version |  Version of the assembly.   | String | required |  |


<a id="#core_stdlib_internal"></a>

## core_stdlib_internal

<pre>
core_stdlib_internal(<a href="#core_stdlib_internal-name">name</a>, <a href="#core_stdlib_internal-data">data</a>, <a href="#core_stdlib_internal-deps">deps</a>, <a href="#core_stdlib_internal-dll">dll</a>, <a href="#core_stdlib_internal-ref">ref</a>, <a href="#core_stdlib_internal-stdlib_path">stdlib_path</a>, <a href="#core_stdlib_internal-version">version</a>)
</pre>

Internal. Do not use. It imports a framework dll and transforms it into [DotnetLibraryInfo](api.md#dotnetlibraryinfo) so it can be referenced as dependency by other rules. Used by //dotnet/stdlib... packages. It doesn't use dotnet_context_data. 


**ATTRIBUTES**


| Name  | Description | Type | Mandatory | Default |
| :------------- | :------------- | :------------- | :------------- | :------------- |
| <a id="core_stdlib_internal-name"></a>name |  A unique name for this target.   | <a href="https://bazel.build/docs/build-ref.html#name">Name</a> | required |  |
| <a id="core_stdlib_internal-data"></a>data |  -   | <a href="https://bazel.build/docs/build-ref.html#labels">List of labels</a> | optional | [] |
| <a id="core_stdlib_internal-deps"></a>deps |  -   | <a href="https://bazel.build/docs/build-ref.html#labels">List of labels</a> | optional | [] |
| <a id="core_stdlib_internal-dll"></a>dll |  -   | String | optional | "" |
| <a id="core_stdlib_internal-ref"></a>ref |  -   | <a href="https://bazel.build/docs/build-ref.html#labels">Label</a> | optional | None |
| <a id="core_stdlib_internal-stdlib_path"></a>stdlib_path |  -   | <a href="https://bazel.build/docs/build-ref.html#labels">Label</a> | required |  |
| <a id="core_stdlib_internal-version"></a>version |  -   | String | required |  |


<a id="#csharp_binary"></a>

## csharp_binary

<pre>
csharp_binary(<a href="#csharp_binary-name">name</a>, <a href="#csharp_binary-data">data</a>, <a href="#csharp_binary-data_with_dirs">data_with_dirs</a>, <a href="#csharp_binary-defines">defines</a>, <a href="#csharp_binary-deps">deps</a>, <a href="#csharp_binary-keyfile">keyfile</a>, <a href="#csharp_binary-langversion">langversion</a>, <a href="#csharp_binary-nowarn">nowarn</a>, <a href="#csharp_binary-out">out</a>,
              <a href="#csharp_binary-resources">resources</a>, <a href="#csharp_binary-srcs">srcs</a>, <a href="#csharp_binary-target_framework">target_framework</a>, <a href="#csharp_binary-unsafe">unsafe</a>, <a href="#csharp_binary-version">version</a>)
</pre>

This builds an executable from a set of source files.
    
    You can run the binary with ``bazel run``, or you can build it with ``bazel build`` and run it directly.

    Providers
    ^^^^^^^^^

    * [DotnetLibraryInfo](api.md#dotnetlibraryinfo)
    * [DotnetResourceInfo](api.md#dotnetresourceinfo)

    Example:
    ^^^^^^^^
    ```python
    csharp_binary(
        name = "Program.exe",
        srcs = [
            "Program.cs",
        ],
        deps = [
            "@io_bazel_rules_dotnet//dotnet/stdlib.core:libraryset",
        ],
    )
    ```
    


**ATTRIBUTES**


| Name  | Description | Type | Mandatory | Default |
| :------------- | :------------- | :------------- | :------------- | :------------- |
| <a id="csharp_binary-name"></a>name |  A unique name for this target.   | <a href="https://bazel.build/docs/build-ref.html#name">Name</a> | required |  |
| <a id="csharp_binary-data"></a>data |  The list of additional files to include in the list of runfiles for the assembly.   | <a href="https://bazel.build/docs/build-ref.html#labels">List of labels</a> | optional | [] |
| <a id="csharp_binary-data_with_dirs"></a>data_with_dirs |  Dictionary of {label:folder}. Files specified by &lt;label&gt; will be put in subdirectory &lt;folder&gt;.   | <a href="https://bazel.build/docs/skylark/lib/dict.html">Dictionary: Label -> String</a> | optional | {} |
| <a id="csharp_binary-defines"></a>defines |  The list of defines passed via /define compiler option.   | List of strings | optional | [] |
| <a id="csharp_binary-deps"></a>deps |  The direct dependencies of this library. These may be dotnet_library rules or compatible rules with the [DotnetLibraryInfo](api.md#dotnetlibraryinfo) provider.   | <a href="https://bazel.build/docs/build-ref.html#labels">List of labels</a> | optional | [] |
| <a id="csharp_binary-keyfile"></a>keyfile |  The key to sign the assembly with.   | <a href="https://bazel.build/docs/build-ref.html#labels">Label</a> | optional | None |
| <a id="csharp_binary-langversion"></a>langversion |  Version of the language to use. See [this page](https://docs.microsoft.com/en-us/dotnet/csharp/language-reference/configure-language-version).   | String | optional | "latest" |
| <a id="csharp_binary-nowarn"></a>nowarn |  The list of warnings to be ignored. The warnings are passed to -nowarn compiler opion.   | List of strings | optional | [] |
| <a id="csharp_binary-out"></a>out |  An alternative name of the output file.   | String | optional | "" |
| <a id="csharp_binary-resources"></a>resources |  The list of resources to compile with. Usually provided via reference to [core_resx](api.md#core_resx) or the rules compatible with [DotnetResourceInfo](api.md#dotnetresourceinfo) provider.   | <a href="https://bazel.build/docs/build-ref.html#labels">List of labels</a> | optional | [] |
| <a id="csharp_binary-srcs"></a>srcs |  The list of .cs source files that are compiled to create the assembly.   | <a href="https://bazel.build/docs/build-ref.html#labels">List of labels</a> | optional | [] |
| <a id="csharp_binary-target_framework"></a>target_framework |  Target framework.   | String | optional | "" |
| <a id="csharp_binary-unsafe"></a>unsafe |  If true passes /unsafe flag to the compiler.   | Boolean | optional | False |
| <a id="csharp_binary-version"></a>version |  Version to be set for the assembly. The version is set by compiling in [AssemblyVersion](https://docs.microsoft.com/en-us/troubleshoot/visualstudio/general/assembly-version-assembly-file-version) attribute.   | String | optional | "" |


<a id="#csharp_library"></a>

## csharp_library

<pre>
csharp_library(<a href="#csharp_library-name">name</a>, <a href="#csharp_library-data">data</a>, <a href="#csharp_library-defines">defines</a>, <a href="#csharp_library-deps">deps</a>, <a href="#csharp_library-keyfile">keyfile</a>, <a href="#csharp_library-langversion">langversion</a>, <a href="#csharp_library-nowarn">nowarn</a>, <a href="#csharp_library-out">out</a>, <a href="#csharp_library-resources">resources</a>, <a href="#csharp_library-srcs">srcs</a>,
               <a href="#csharp_library-target_framework">target_framework</a>, <a href="#csharp_library-unsafe">unsafe</a>, <a href="#csharp_library-version">version</a>)
</pre>

This builds a dotnet assembly from a set of source files.

    Providers
    ^^^^^^^^^

    * [DotnetLibraryInfo](api.md#dotnetlibraryinfo)
    * [DotnetResourceInfo](api.md#dotnetresourceinfo)

    Example:
    ^^^^^^^^
    ```python
    [csharp_library(
        name = "{}_TransitiveClass-core.dll".format(framework),
        srcs = [
            "TransitiveClass.cs",
        ],
        dotnet_context_data = "@io_bazel_rules_dotnet//:core_context_data_{}".format(framework),
        visibility = ["//visibility:public"],
        deps = [
            "@io_bazel_rules_dotnet//dotnet/stdlib.core/{}:libraryset".format(framework),
        ],
    ) for framework in DOTNET_CORE_FRAMEWORKS]
    ```
    


**ATTRIBUTES**


| Name  | Description | Type | Mandatory | Default |
| :------------- | :------------- | :------------- | :------------- | :------------- |
| <a id="csharp_library-name"></a>name |  A unique name for this target.   | <a href="https://bazel.build/docs/build-ref.html#name">Name</a> | required |  |
| <a id="csharp_library-data"></a>data |  The list of additional files to include in the list of runfiles for the assembly.   | <a href="https://bazel.build/docs/build-ref.html#labels">List of labels</a> | optional | [] |
| <a id="csharp_library-defines"></a>defines |  The list of defines passed via /define compiler option.   | List of strings | optional | [] |
| <a id="csharp_library-deps"></a>deps |  The direct dependencies of this library. These may be dotnet_library rules or compatible rules with the [DotnetLibraryInfo](api.md#dotnetlibraryinfo) provider.   | <a href="https://bazel.build/docs/build-ref.html#labels">List of labels</a> | optional | [] |
| <a id="csharp_library-keyfile"></a>keyfile |  The key to sign the assembly with.   | <a href="https://bazel.build/docs/build-ref.html#labels">Label</a> | optional | None |
| <a id="csharp_library-langversion"></a>langversion |  Version of the language to use. See [this page](https://docs.microsoft.com/en-us/dotnet/csharp/language-reference/configure-language-version).   | String | optional | "latest" |
| <a id="csharp_library-nowarn"></a>nowarn |  The list of warnings to be ignored. The warnings are passed to -nowarn compiler opion.   | List of strings | optional | [] |
| <a id="csharp_library-out"></a>out |  An alternative name of the output file.   | String | optional | "" |
| <a id="csharp_library-resources"></a>resources |  The list of resources to compile with. Usually provided via reference to [core_resx](api.md#core_resx) or the rules compatible with [DotnetResourceInfo](api.md#dotnetresourceinfo) provider.   | <a href="https://bazel.build/docs/build-ref.html#labels">List of labels</a> | optional | [] |
| <a id="csharp_library-srcs"></a>srcs |  The list of .cs source files that are compiled to create the assembly.   | <a href="https://bazel.build/docs/build-ref.html#labels">List of labels</a> | optional | [] |
| <a id="csharp_library-target_framework"></a>target_framework |  Target framework.   | String | optional | "" |
| <a id="csharp_library-unsafe"></a>unsafe |  If true passes /unsafe flag to the compiler.   | Boolean | optional | False |
| <a id="csharp_library-version"></a>version |  Version to be set for the assembly. The version is set by compiling in [AssemblyVersion](https://docs.microsoft.com/en-us/troubleshoot/visualstudio/general/assembly-version-assembly-file-version) attribute.   | String | optional | "" |


<a id="#csharp_nunit3_test"></a>

## csharp_nunit3_test

<pre>
csharp_nunit3_test(<a href="#csharp_nunit3_test-name">name</a>, <a href="#csharp_nunit3_test-data">data</a>, <a href="#csharp_nunit3_test-data_with_dirs">data_with_dirs</a>, <a href="#csharp_nunit3_test-defines">defines</a>, <a href="#csharp_nunit3_test-deps">deps</a>, <a href="#csharp_nunit3_test-keyfile">keyfile</a>, <a href="#csharp_nunit3_test-langversion">langversion</a>, <a href="#csharp_nunit3_test-nowarn">nowarn</a>, <a href="#csharp_nunit3_test-out">out</a>,
                   <a href="#csharp_nunit3_test-resources">resources</a>, <a href="#csharp_nunit3_test-srcs">srcs</a>, <a href="#csharp_nunit3_test-testlauncher">testlauncher</a>, <a href="#csharp_nunit3_test-unsafe">unsafe</a>, <a href="#csharp_nunit3_test-version">version</a>)
</pre>

This builds a set of tests that can be run with ``bazel test``.

    To run all tests in the workspace, and print output on failure, run
    ```bash
    bazel test --test_output=errors //...
    ```

    You can run specific tests by passing the `--test_filter=pattern <test_filter_>` argument to Bazel.
    You can pass arguments to tests by passing `--test_arg=arg <test_arg_>`_ arguments to Bazel.

    


**ATTRIBUTES**


| Name  | Description | Type | Mandatory | Default |
| :------------- | :------------- | :------------- | :------------- | :------------- |
| <a id="csharp_nunit3_test-name"></a>name |  A unique name for this target.   | <a href="https://bazel.build/docs/build-ref.html#name">Name</a> | required |  |
| <a id="csharp_nunit3_test-data"></a>data |  The list of additional files to include in the list of runfiles for the assembly.   | <a href="https://bazel.build/docs/build-ref.html#labels">List of labels</a> | optional | [] |
| <a id="csharp_nunit3_test-data_with_dirs"></a>data_with_dirs |  Dictionary of {label:folder}. Files specified by &lt;label&gt; will be put in subdirectory &lt;folder&gt;.   | <a href="https://bazel.build/docs/skylark/lib/dict.html">Dictionary: Label -> String</a> | optional | {"@vstest//:Microsoft.TestPlatform.TestHostRuntimeProvider.dll": "Extensions", "@NUnit3TestAdapter//:extension": ".", "@JunitXml.TestLogger//:extension": "."} |
| <a id="csharp_nunit3_test-defines"></a>defines |  The list of defines passed via /define compiler option.   | List of strings | optional | [] |
| <a id="csharp_nunit3_test-deps"></a>deps |  The direct dependencies of this library. These may be dotnet_library rules or compatible rules with the [DotnetLibraryInfo](api.md#dotnetlibraryinfo) provider.   | <a href="https://bazel.build/docs/build-ref.html#labels">List of labels</a> | optional | [] |
| <a id="csharp_nunit3_test-keyfile"></a>keyfile |  The key to sign the assembly with.   | <a href="https://bazel.build/docs/build-ref.html#labels">Label</a> | optional | None |
| <a id="csharp_nunit3_test-langversion"></a>langversion |  Version of the language to use. See [this page](https://docs.microsoft.com/en-us/dotnet/csharp/language-reference/configure-language-version).   | String | optional | "latest" |
| <a id="csharp_nunit3_test-nowarn"></a>nowarn |  The list of warnings to be ignored. The warnings are passed to -nowarn compiler opion.   | List of strings | optional | [] |
| <a id="csharp_nunit3_test-out"></a>out |  An alternative name of the output file.   | String | optional | "" |
| <a id="csharp_nunit3_test-resources"></a>resources |  The list of resources to compile with. Usually provided via reference to [core_resx](api.md#core_resx) or the rules compatible with [DotnetResourceInfo](api.md#dotnetresourceinfo) provider.   | <a href="https://bazel.build/docs/build-ref.html#labels">List of labels</a> | optional | [] |
| <a id="csharp_nunit3_test-srcs"></a>srcs |  The list of .cs source files that are compiled to create the assembly.   | <a href="https://bazel.build/docs/build-ref.html#labels">List of labels</a> | optional | [] |
| <a id="csharp_nunit3_test-testlauncher"></a>testlauncher |  Test launcher to use.   | <a href="https://bazel.build/docs/build-ref.html#labels">Label</a> | optional | @vstest//:vstest.console.exe |
| <a id="csharp_nunit3_test-unsafe"></a>unsafe |  If true passes /unsafe flag to the compiler.   | Boolean | optional | False |
| <a id="csharp_nunit3_test-version"></a>version |  Version to be set for the assembly. The version is set by compiling in [AssemblyVersion](https://docs.microsoft.com/en-us/troubleshoot/visualstudio/general/assembly-version-assembly-file-version) attribute.   | String | optional | "" |


<a id="#csharp_xunit_test"></a>

## csharp_xunit_test

<pre>
csharp_xunit_test(<a href="#csharp_xunit_test-name">name</a>, <a href="#csharp_xunit_test-data">data</a>, <a href="#csharp_xunit_test-data_with_dirs">data_with_dirs</a>, <a href="#csharp_xunit_test-defines">defines</a>, <a href="#csharp_xunit_test-deps">deps</a>, <a href="#csharp_xunit_test-keyfile">keyfile</a>, <a href="#csharp_xunit_test-langversion">langversion</a>, <a href="#csharp_xunit_test-nowarn">nowarn</a>, <a href="#csharp_xunit_test-out">out</a>,
                  <a href="#csharp_xunit_test-resources">resources</a>, <a href="#csharp_xunit_test-srcs">srcs</a>, <a href="#csharp_xunit_test-testlauncher">testlauncher</a>, <a href="#csharp_xunit_test-unsafe">unsafe</a>, <a href="#csharp_xunit_test-version">version</a>)
</pre>

This builds a set of tests that can be run with ``bazel test``.

    To run all tests in the workspace, and print output on failure, run
    ```bash
    bazel test --test_output=errors //...
    ```

    You can run specific tests by passing the `--test_filter=pattern <test_filter_>` argument to Bazel.
    You can pass arguments to tests by passing `--test_arg=arg <test_arg_>`_ arguments to Bazel.

    


**ATTRIBUTES**


| Name  | Description | Type | Mandatory | Default |
| :------------- | :------------- | :------------- | :------------- | :------------- |
| <a id="csharp_xunit_test-name"></a>name |  A unique name for this target.   | <a href="https://bazel.build/docs/build-ref.html#name">Name</a> | required |  |
| <a id="csharp_xunit_test-data"></a>data |  The list of additional files to include in the list of runfiles for the assembly.   | <a href="https://bazel.build/docs/build-ref.html#labels">List of labels</a> | optional | [] |
| <a id="csharp_xunit_test-data_with_dirs"></a>data_with_dirs |  Dictionary of {label:folder}. Files specified by &lt;label&gt; will be put in subdirectory &lt;folder&gt;.   | <a href="https://bazel.build/docs/skylark/lib/dict.html">Dictionary: Label -> String</a> | optional | {} |
| <a id="csharp_xunit_test-defines"></a>defines |  The list of defines passed via /define compiler option.   | List of strings | optional | [] |
| <a id="csharp_xunit_test-deps"></a>deps |  The direct dependencies of this library. These may be dotnet_library rules or compatible rules with the [DotnetLibraryInfo](api.md#dotnetlibraryinfo) provider.   | <a href="https://bazel.build/docs/build-ref.html#labels">List of labels</a> | optional | [] |
| <a id="csharp_xunit_test-keyfile"></a>keyfile |  The key to sign the assembly with.   | <a href="https://bazel.build/docs/build-ref.html#labels">Label</a> | optional | None |
| <a id="csharp_xunit_test-langversion"></a>langversion |  Version of the language to use. See [this page](https://docs.microsoft.com/en-us/dotnet/csharp/language-reference/configure-language-version).   | String | optional | "latest" |
| <a id="csharp_xunit_test-nowarn"></a>nowarn |  The list of warnings to be ignored. The warnings are passed to -nowarn compiler opion.   | List of strings | optional | [] |
| <a id="csharp_xunit_test-out"></a>out |  An alternative name of the output file.   | String | optional | "" |
| <a id="csharp_xunit_test-resources"></a>resources |  The list of resources to compile with. Usually provided via reference to [core_resx](api.md#core_resx) or the rules compatible with [DotnetResourceInfo](api.md#dotnetresourceinfo) provider.   | <a href="https://bazel.build/docs/build-ref.html#labels">List of labels</a> | optional | [] |
| <a id="csharp_xunit_test-srcs"></a>srcs |  The list of .cs source files that are compiled to create the assembly.   | <a href="https://bazel.build/docs/build-ref.html#labels">List of labels</a> | optional | [] |
| <a id="csharp_xunit_test-testlauncher"></a>testlauncher |  Test launcher to use.   | <a href="https://bazel.build/docs/build-ref.html#labels">Label</a> | optional | @xunit.runner.console//:tool |
| <a id="csharp_xunit_test-unsafe"></a>unsafe |  If true passes /unsafe flag to the compiler.   | Boolean | optional | False |
| <a id="csharp_xunit_test-version"></a>version |  Version to be set for the assembly. The version is set by compiling in [AssemblyVersion](https://docs.microsoft.com/en-us/troubleshoot/visualstudio/general/assembly-version-assembly-file-version) attribute.   | String | optional | "" |


<a id="#dotnet_nuget_new"></a>

## dotnet_nuget_new

<pre>
dotnet_nuget_new(<a href="#dotnet_nuget_new-name">name</a>, <a href="#dotnet_nuget_new-build_file">build_file</a>, <a href="#dotnet_nuget_new-build_file_content">build_file_content</a>, <a href="#dotnet_nuget_new-package">package</a>, <a href="#dotnet_nuget_new-repo_mapping">repo_mapping</a>, <a href="#dotnet_nuget_new-sha256">sha256</a>, <a href="#dotnet_nuget_new-source">source</a>,
                 <a href="#dotnet_nuget_new-version">version</a>)
</pre>

Repository rule to download and extract nuget package. Usually [nuget_package](#nuget_package) is a better choice.
    
    Usually used with [dotnet_import_library](#dotnet_import_library).    
    
    Example:
    ```python
    dotnet_nuget_new(
        name = "npgsql", 
        package="Npgsql", 
        version="3.2.7", 
        sha256="fa3e0cfbb2caa9946d2ce3d8174031a06320aad2c9e69a60f7739b9ddf19f172",
        build_file_content = """
    package(default_visibility = [ "//visibility:public" ])
    load("@io_bazel_rules_dotnet//dotnet:defs.bzl", "dotnet_import_library")

    dotnet_import_library(
        name = "npgsqllib",
        src = "lib/net451/Npgsql.dll"
    )   
        """
    )
    ```
    


**ATTRIBUTES**


| Name  | Description | Type | Mandatory | Default |
| :------------- | :------------- | :------------- | :------------- | :------------- |
| <a id="dotnet_nuget_new-name"></a>name |  A unique name for this repository.   | <a href="https://bazel.build/docs/build-ref.html#name">Name</a> | required |  |
| <a id="dotnet_nuget_new-build_file"></a>build_file |  The file to use as the BUILD file for this repository. This attribute is an absolute label (use '@//' for the main repo). The file does not need to be named BUILD, but can be (something like BUILD.new-repo-name may work well for distinguishing it from the repository's actual BUILD files. Either build_file or build_file_content can be specified, but not both.   | <a href="https://bazel.build/docs/build-ref.html#labels">Label</a> | optional | None |
| <a id="dotnet_nuget_new-build_file_content"></a>build_file_content |  The content for the BUILD file for this repository. Either build_file or build_file_content can be specified, but not both.   | String | optional | "" |
| <a id="dotnet_nuget_new-package"></a>package |  The name of the nuget package.   | String | required |  |
| <a id="dotnet_nuget_new-repo_mapping"></a>repo_mapping |  A dictionary from local repository name to global repository name. This allows controls over workspace dependency resolution for dependencies of this repository.&lt;p&gt;For example, an entry <code>"@foo": "@bar"</code> declares that, for any time this repository depends on <code>@foo</code> (such as a dependency on <code>@foo//some:target</code>, it should actually resolve that dependency within globally-declared <code>@bar</code> (<code>@bar//some:target</code>).   | <a href="https://bazel.build/docs/skylark/lib/dict.html">Dictionary: String -> String</a> | required |  |
| <a id="dotnet_nuget_new-sha256"></a>sha256 |  Sha256 digest of the downloaded package.   | String | optional | "" |
| <a id="dotnet_nuget_new-source"></a>source |  Nuget repository to download the nuget package from. The final url is in the format shape \{source\}/\{package\}/\{version\}.   | String | optional | "https://www.nuget.org/api/v2/package" |
| <a id="dotnet_nuget_new-version"></a>version |  The version of the nuget package.   | String | required |  |


<a id="#fsharp_binary"></a>

## fsharp_binary

<pre>
fsharp_binary(<a href="#fsharp_binary-name">name</a>, <a href="#fsharp_binary-data">data</a>, <a href="#fsharp_binary-data_with_dirs">data_with_dirs</a>, <a href="#fsharp_binary-defines">defines</a>, <a href="#fsharp_binary-deps">deps</a>, <a href="#fsharp_binary-keyfile">keyfile</a>, <a href="#fsharp_binary-langversion">langversion</a>, <a href="#fsharp_binary-nowarn">nowarn</a>, <a href="#fsharp_binary-out">out</a>,
              <a href="#fsharp_binary-resources">resources</a>, <a href="#fsharp_binary-srcs">srcs</a>, <a href="#fsharp_binary-target_framework">target_framework</a>, <a href="#fsharp_binary-version">version</a>)
</pre>

This builds an executable from a set of source files.
    
    You can run the binary with ``bazel run``, or you can build it with ``bazel build`` and run it directly.

    Providers
    ^^^^^^^^^

    * [DotnetLibraryInfo](api.md#dotnetlibraryinfo)
    * [DotnetResourceInfo](api.md#dotnetresourceinfo)

    Example:
    ^^^^^^^^
    ```python
    fsharp_binary(
        name = "Program.exe",
        srcs = [
            "Program.fs",
        ],
        deps = [
            "@io_bazel_rules_dotnet//dotnet/stdlib.core:libraryset",
        ],
    )
    ```
    


**ATTRIBUTES**


| Name  | Description | Type | Mandatory | Default |
| :------------- | :------------- | :------------- | :------------- | :------------- |
| <a id="fsharp_binary-name"></a>name |  A unique name for this target.   | <a href="https://bazel.build/docs/build-ref.html#name">Name</a> | required |  |
| <a id="fsharp_binary-data"></a>data |  The list of additional files to include in the list of runfiles for the assembly.   | <a href="https://bazel.build/docs/build-ref.html#labels">List of labels</a> | optional | [] |
| <a id="fsharp_binary-data_with_dirs"></a>data_with_dirs |  Dictionary of {label:folder}. Files specified by &lt;label&gt; will be put in subdirectory &lt;folder&gt;.   | <a href="https://bazel.build/docs/skylark/lib/dict.html">Dictionary: Label -> String</a> | optional | {} |
| <a id="fsharp_binary-defines"></a>defines |  The list of defines passed via /define compiler option.   | List of strings | optional | [] |
| <a id="fsharp_binary-deps"></a>deps |  The direct dependencies of this library. These may be dotnet_library rules or compatible rules with the [DotnetLibraryInfo](api.md#dotnetlibraryinfo) provider.   | <a href="https://bazel.build/docs/build-ref.html#labels">List of labels</a> | optional | [] |
| <a id="fsharp_binary-keyfile"></a>keyfile |  The key to sign the assembly with.   | <a href="https://bazel.build/docs/build-ref.html#labels">Label</a> | optional | None |
| <a id="fsharp_binary-langversion"></a>langversion |  Version of the language to use. See [this page](https://docs.microsoft.com/en-us/dotnet/csharp/language-reference/configure-language-version).   | String | optional | "latest" |
| <a id="fsharp_binary-nowarn"></a>nowarn |  The list of warnings to be ignored. The warnings are passed to -nowarn compiler opion.   | List of strings | optional | [] |
| <a id="fsharp_binary-out"></a>out |  An alternative name of the output file.   | String | optional | "" |
| <a id="fsharp_binary-resources"></a>resources |  The list of resources to compile with. Usually provided via reference to [core_resx](api.md#core_resx) or the rules compatible with [DotnetResourceInfo](api.md#dotnetresourceinfo) provider.   | <a href="https://bazel.build/docs/build-ref.html#labels">List of labels</a> | optional | [] |
| <a id="fsharp_binary-srcs"></a>srcs |  The list of .fs source files that are compiled to create the assembly.   | <a href="https://bazel.build/docs/build-ref.html#labels">List of labels</a> | optional | [] |
| <a id="fsharp_binary-target_framework"></a>target_framework |  Target framework.   | String | optional | "" |
| <a id="fsharp_binary-version"></a>version |  Version to be set for the assembly. The version is set by compiling in [AssemblyVersion](https://docs.microsoft.com/en-us/troubleshoot/visualstudio/general/assembly-version-assembly-file-version) attribute.   | String | optional | "" |


<a id="#fsharp_library"></a>

## fsharp_library

<pre>
fsharp_library(<a href="#fsharp_library-name">name</a>, <a href="#fsharp_library-data">data</a>, <a href="#fsharp_library-defines">defines</a>, <a href="#fsharp_library-deps">deps</a>, <a href="#fsharp_library-keyfile">keyfile</a>, <a href="#fsharp_library-langversion">langversion</a>, <a href="#fsharp_library-nowarn">nowarn</a>, <a href="#fsharp_library-out">out</a>, <a href="#fsharp_library-resources">resources</a>, <a href="#fsharp_library-srcs">srcs</a>,
               <a href="#fsharp_library-target_framework">target_framework</a>, <a href="#fsharp_library-version">version</a>)
</pre>

This builds a dotnet assembly from a set of source files.

    Providers
    ^^^^^^^^^

    * [DotnetLibraryInfo](api.md#dotnetlibraryinfo)
    * [DotnetResourceInfo](api.md#dotnetresourceinfo)

    Example:
    ^^^^^^^^
    ```python
    [fsharp_library(
        name = "{}_TransitiveClass-core.dll".format(framework),
        srcs = [
            "TransitiveClass.fs",
        ],
        visibility = ["//visibility:public"],
        deps = [
            "@io_bazel_rules_dotnet//dotnet/stdlib.core/{}:libraryset".format(framework),
        ],
    ) for framework in DOTNET_CORE_FRAMEWORKS]
    ```
    


**ATTRIBUTES**


| Name  | Description | Type | Mandatory | Default |
| :------------- | :------------- | :------------- | :------------- | :------------- |
| <a id="fsharp_library-name"></a>name |  A unique name for this target.   | <a href="https://bazel.build/docs/build-ref.html#name">Name</a> | required |  |
| <a id="fsharp_library-data"></a>data |  The list of additional files to include in the list of runfiles for the assembly.   | <a href="https://bazel.build/docs/build-ref.html#labels">List of labels</a> | optional | [] |
| <a id="fsharp_library-defines"></a>defines |  The list of defines passed via /define compiler option.   | List of strings | optional | [] |
| <a id="fsharp_library-deps"></a>deps |  The direct dependencies of this library. These may be dotnet_library rules or compatible rules with the [DotnetLibraryInfo](api.md#dotnetlibraryinfo) provider.   | <a href="https://bazel.build/docs/build-ref.html#labels">List of labels</a> | optional | [] |
| <a id="fsharp_library-keyfile"></a>keyfile |  The key to sign the assembly with.   | <a href="https://bazel.build/docs/build-ref.html#labels">Label</a> | optional | None |
| <a id="fsharp_library-langversion"></a>langversion |  Version of the language to use.   | String | optional | "latest" |
| <a id="fsharp_library-nowarn"></a>nowarn |  The list of warnings to be ignored. The warnings are passed to -nowarn compiler opion.   | List of strings | optional | [] |
| <a id="fsharp_library-out"></a>out |  An alternative name of the output file.   | String | optional | "" |
| <a id="fsharp_library-resources"></a>resources |  The list of resources to compile with. Usually provided via reference to [core_resx](api.md#core_resx) or the rules compatible with [DotnetResourceInfo](api.md#dotnetresourceinfo) provider.   | <a href="https://bazel.build/docs/build-ref.html#labels">List of labels</a> | optional | [] |
| <a id="fsharp_library-srcs"></a>srcs |  The list of .fs source files that are compiled to create the assembly.   | <a href="https://bazel.build/docs/build-ref.html#labels">List of labels</a> | optional | [] |
| <a id="fsharp_library-target_framework"></a>target_framework |  Target framework.   | String | optional | "" |
| <a id="fsharp_library-version"></a>version |  Version to be set for the assembly. The version is set by compiling in [AssemblyVersion](https://docs.microsoft.com/en-us/troubleshoot/visualstudio/general/assembly-version-assembly-file-version) attribute.   | String | optional | "" |


<a id="#fsharp_nunit3_test"></a>

## fsharp_nunit3_test

<pre>
fsharp_nunit3_test(<a href="#fsharp_nunit3_test-name">name</a>, <a href="#fsharp_nunit3_test-data">data</a>, <a href="#fsharp_nunit3_test-data_with_dirs">data_with_dirs</a>, <a href="#fsharp_nunit3_test-defines">defines</a>, <a href="#fsharp_nunit3_test-deps">deps</a>, <a href="#fsharp_nunit3_test-keyfile">keyfile</a>, <a href="#fsharp_nunit3_test-langversion">langversion</a>, <a href="#fsharp_nunit3_test-nowarn">nowarn</a>, <a href="#fsharp_nunit3_test-out">out</a>,
                   <a href="#fsharp_nunit3_test-resources">resources</a>, <a href="#fsharp_nunit3_test-srcs">srcs</a>, <a href="#fsharp_nunit3_test-testlauncher">testlauncher</a>, <a href="#fsharp_nunit3_test-version">version</a>)
</pre>

This builds a set of tests that can be run with ``bazel test``.

    To run all tests in the workspace, and print output on failure, run
    ```bash
    bazel test --test_output=errors //...
    ```

    You can run specific tests by passing the `--test_filter=pattern <test_filter_>` argument to Bazel.
    You can pass arguments to tests by passing `--test_arg=arg <test_arg_>`_ arguments to Bazel.

    


**ATTRIBUTES**


| Name  | Description | Type | Mandatory | Default |
| :------------- | :------------- | :------------- | :------------- | :------------- |
| <a id="fsharp_nunit3_test-name"></a>name |  A unique name for this target.   | <a href="https://bazel.build/docs/build-ref.html#name">Name</a> | required |  |
| <a id="fsharp_nunit3_test-data"></a>data |  The list of additional files to include in the list of runfiles for the assembly.   | <a href="https://bazel.build/docs/build-ref.html#labels">List of labels</a> | optional | [] |
| <a id="fsharp_nunit3_test-data_with_dirs"></a>data_with_dirs |  Dictionary of {label:folder}. Files specified by &lt;label&gt; will be put in subdirectory &lt;folder&gt;.   | <a href="https://bazel.build/docs/skylark/lib/dict.html">Dictionary: Label -> String</a> | optional | {"@vstest//:Microsoft.TestPlatform.TestHostRuntimeProvider.dll": "Extensions", "@NUnit3TestAdapter//:extension": ".", "@JunitXml.TestLogger//:extension": "."} |
| <a id="fsharp_nunit3_test-defines"></a>defines |  The list of defines passed via /define compiler option.   | List of strings | optional | [] |
| <a id="fsharp_nunit3_test-deps"></a>deps |  The direct dependencies of this library. These may be dotnet_library rules or compatible rules with the [DotnetLibraryInfo](api.md#dotnetlibraryinfo) provider.   | <a href="https://bazel.build/docs/build-ref.html#labels">List of labels</a> | optional | [] |
| <a id="fsharp_nunit3_test-keyfile"></a>keyfile |  The key to sign the assembly with.   | <a href="https://bazel.build/docs/build-ref.html#labels">Label</a> | optional | None |
| <a id="fsharp_nunit3_test-langversion"></a>langversion |  Version of the language to use. See [this page](https://docs.microsoft.com/en-us/dotnet/csharp/language-reference/configure-language-version).   | String | optional | "latest" |
| <a id="fsharp_nunit3_test-nowarn"></a>nowarn |  The list of warnings to be ignored. The warnings are passed to -nowarn compiler opion.   | List of strings | optional | [] |
| <a id="fsharp_nunit3_test-out"></a>out |  An alternative name of the output file.   | String | optional | "" |
| <a id="fsharp_nunit3_test-resources"></a>resources |  The list of resources to compile with. Usually provided via reference to [core_resx](api.md#core_resx) or the rules compatible with [DotnetResourceInfo](api.md#dotnetresourceinfo) provider.   | <a href="https://bazel.build/docs/build-ref.html#labels">List of labels</a> | optional | [] |
| <a id="fsharp_nunit3_test-srcs"></a>srcs |  The list of .fs source files that are compiled to create the assembly.   | <a href="https://bazel.build/docs/build-ref.html#labels">List of labels</a> | optional | [] |
| <a id="fsharp_nunit3_test-testlauncher"></a>testlauncher |  Test launcher to use.   | <a href="https://bazel.build/docs/build-ref.html#labels">Label</a> | optional | @vstest//:vstest.console.exe |
| <a id="fsharp_nunit3_test-version"></a>version |  Version to be set for the assembly. The version is set by compiling in [AssemblyVersion](https://docs.microsoft.com/en-us/troubleshoot/visualstudio/general/assembly-version-assembly-file-version) attribute.   | String | optional | "" |


<a id="#fsharp_xunit_test"></a>

## fsharp_xunit_test

<pre>
fsharp_xunit_test(<a href="#fsharp_xunit_test-name">name</a>, <a href="#fsharp_xunit_test-data">data</a>, <a href="#fsharp_xunit_test-data_with_dirs">data_with_dirs</a>, <a href="#fsharp_xunit_test-defines">defines</a>, <a href="#fsharp_xunit_test-deps">deps</a>, <a href="#fsharp_xunit_test-keyfile">keyfile</a>, <a href="#fsharp_xunit_test-langversion">langversion</a>, <a href="#fsharp_xunit_test-nowarn">nowarn</a>, <a href="#fsharp_xunit_test-out">out</a>,
                  <a href="#fsharp_xunit_test-resources">resources</a>, <a href="#fsharp_xunit_test-srcs">srcs</a>, <a href="#fsharp_xunit_test-testlauncher">testlauncher</a>, <a href="#fsharp_xunit_test-version">version</a>)
</pre>

This builds a set of tests that can be run with ``bazel test``.

    To run all tests in the workspace, and print output on failure, run
    ```bash
    bazel test --test_output=errors //...
    ```

    You can run specific tests by passing the `--test_filter=pattern <test_filter_>` argument to Bazel.
    You can pass arguments to tests by passing `--test_arg=arg <test_arg_>`_ arguments to Bazel.

    


**ATTRIBUTES**


| Name  | Description | Type | Mandatory | Default |
| :------------- | :------------- | :------------- | :------------- | :------------- |
| <a id="fsharp_xunit_test-name"></a>name |  A unique name for this target.   | <a href="https://bazel.build/docs/build-ref.html#name">Name</a> | required |  |
| <a id="fsharp_xunit_test-data"></a>data |  The list of additional files to include in the list of runfiles for the assembly.   | <a href="https://bazel.build/docs/build-ref.html#labels">List of labels</a> | optional | [] |
| <a id="fsharp_xunit_test-data_with_dirs"></a>data_with_dirs |  Dictionary of {label:folder}. Files specified by &lt;label&gt; will be put in subdirectory &lt;folder&gt;.   | <a href="https://bazel.build/docs/skylark/lib/dict.html">Dictionary: Label -> String</a> | optional | {} |
| <a id="fsharp_xunit_test-defines"></a>defines |  The list of defines passed via /define compiler option.   | List of strings | optional | [] |
| <a id="fsharp_xunit_test-deps"></a>deps |  The direct dependencies of this library. These may be dotnet_library rules or compatible rules with the [DotnetLibraryInfo](api.md#dotnetlibraryinfo) provider.   | <a href="https://bazel.build/docs/build-ref.html#labels">List of labels</a> | optional | [] |
| <a id="fsharp_xunit_test-keyfile"></a>keyfile |  The key to sign the assembly with.   | <a href="https://bazel.build/docs/build-ref.html#labels">Label</a> | optional | None |
| <a id="fsharp_xunit_test-langversion"></a>langversion |  Version of the language to use. See [this page](https://docs.microsoft.com/en-us/dotnet/csharp/language-reference/configure-language-version).   | String | optional | "latest" |
| <a id="fsharp_xunit_test-nowarn"></a>nowarn |  The list of warnings to be ignored. The warnings are passed to -nowarn compiler opion.   | List of strings | optional | [] |
| <a id="fsharp_xunit_test-out"></a>out |  An alternative name of the output file.   | String | optional | "" |
| <a id="fsharp_xunit_test-resources"></a>resources |  The list of resources to compile with. Usually provided via reference to [core_resx](api.md#core_resx) or the rules compatible with [DotnetResourceInfo](api.md#dotnetresourceinfo) provider.   | <a href="https://bazel.build/docs/build-ref.html#labels">List of labels</a> | optional | [] |
| <a id="fsharp_xunit_test-srcs"></a>srcs |  The list of .fs source files that are compiled to create the assembly.   | <a href="https://bazel.build/docs/build-ref.html#labels">List of labels</a> | optional | [] |
| <a id="fsharp_xunit_test-testlauncher"></a>testlauncher |  Test launcher to use.   | <a href="https://bazel.build/docs/build-ref.html#labels">Label</a> | optional | @xunit.runner.console//:tool |
| <a id="fsharp_xunit_test-version"></a>version |  Version to be set for the assembly. The version is set by compiling in [AssemblyVersion](https://docs.microsoft.com/en-us/troubleshoot/visualstudio/general/assembly-version-assembly-file-version) attribute.   | String | optional | "" |


<a id="#nuget_package"></a>

## nuget_package

<pre>
nuget_package(<a href="#nuget_package-name">name</a>, <a href="#nuget_package-core_deps">core_deps</a>, <a href="#nuget_package-core_files">core_files</a>, <a href="#nuget_package-core_lib">core_lib</a>, <a href="#nuget_package-core_ref">core_ref</a>, <a href="#nuget_package-core_tool">core_tool</a>, <a href="#nuget_package-mono_deps">mono_deps</a>, <a href="#nuget_package-mono_files">mono_files</a>,
              <a href="#nuget_package-mono_lib">mono_lib</a>, <a href="#nuget_package-mono_ref">mono_ref</a>, <a href="#nuget_package-mono_tool">mono_tool</a>, <a href="#nuget_package-net_deps">net_deps</a>, <a href="#nuget_package-net_files">net_files</a>, <a href="#nuget_package-net_lib">net_lib</a>, <a href="#nuget_package-net_ref">net_ref</a>, <a href="#nuget_package-net_tool">net_tool</a>, <a href="#nuget_package-package">package</a>,
              <a href="#nuget_package-repo_mapping">repo_mapping</a>, <a href="#nuget_package-sha256">sha256</a>, <a href="#nuget_package-source">source</a>, <a href="#nuget_package-version">version</a>)
</pre>

Repository rule to download and extract nuget package. The rule is usually generated by [nuget2bazel](nuget2bazel.md) tool.

       Example
       ^^^^^^^
       
       ```python
       nuget_package(
        name = "commandlineparser",
        package = "commandlineparser",
        sha256 = "09e60ff23e6953b4fe7d267ef552d8ece76404acf44842012f84430e8b877b13",
        core_lib = "lib/netstandard1.5/CommandLine.dll",
        core_deps = [
            "@io_bazel_rules_dotnet//dotnet/stdlib.core:system.collections.dll",
            "@io_bazel_rules_dotnet//dotnet/stdlib.core:system.console.dll",
            "@io_bazel_rules_dotnet//dotnet/stdlib.core:system.diagnostics.debug.dll",
            "@io_bazel_rules_dotnet//dotnet/stdlib.core:system.globalization.dll",
            "@io_bazel_rules_dotnet//dotnet/stdlib.core:system.io.dll",
            "@io_bazel_rules_dotnet//dotnet/stdlib.core:system.linq.dll",
            "@io_bazel_rules_dotnet//dotnet/stdlib.core:system.linq.expressions.dll",
            "@io_bazel_rules_dotnet//dotnet/stdlib.core:system.reflection.dll",
            "@io_bazel_rules_dotnet//dotnet/stdlib.core:system.reflection.extensions.dll",
            "@io_bazel_rules_dotnet//dotnet/stdlib.core:system.reflection.typeextensions.dll",
            "@io_bazel_rules_dotnet//dotnet/stdlib.core:system.resources.resourcemanager.dll",
            "@io_bazel_rules_dotnet//dotnet/stdlib.core:system.runtime.dll",
            "@io_bazel_rules_dotnet//dotnet/stdlib.core:system.runtime.extensions.dll",
        ],
        core_files = [
            "lib/netstandard1.5/CommandLine.dll",
            "lib/netstandard1.5/CommandLine.xml",
        ],
        )
        ```
        


**ATTRIBUTES**


| Name  | Description | Type | Mandatory | Default |
| :------------- | :------------- | :------------- | :------------- | :------------- |
| <a id="nuget_package-name"></a>name |  A unique name for this repository.   | <a href="https://bazel.build/docs/build-ref.html#name">Name</a> | required |  |
| <a id="nuget_package-core_deps"></a>core_deps |  The list of the dependencies of the package (core).   | <a href="https://bazel.build/docs/skylark/lib/dict.html">Dictionary: String -> List of strings</a> | optional | {} |
| <a id="nuget_package-core_files"></a>core_files |  The list of additional files within the package to be used as runfiles (necessary to run).   | <a href="https://bazel.build/docs/skylark/lib/dict.html">Dictionary: String -> List of strings</a> | optional | {} |
| <a id="nuget_package-core_lib"></a>core_lib |  The path to .net core assembly within the nuget package.   | <a href="https://bazel.build/docs/skylark/lib/dict.html">Dictionary: String -> String</a> | optional | {} |
| <a id="nuget_package-core_ref"></a>core_ref |  The path to .net core reference assembly within the nuget package.   | <a href="https://bazel.build/docs/skylark/lib/dict.html">Dictionary: String -> String</a> | optional | {} |
| <a id="nuget_package-core_tool"></a>core_tool |  The path to .net core assembly within the nuget package (tools subdirectory).   | <a href="https://bazel.build/docs/skylark/lib/dict.html">Dictionary: String -> String</a> | optional | {} |
| <a id="nuget_package-mono_deps"></a>mono_deps |  -   | <a href="https://bazel.build/docs/build-ref.html#labels">List of labels</a> | optional | [] |
| <a id="nuget_package-mono_files"></a>mono_files |  -   | List of strings | optional | [] |
| <a id="nuget_package-mono_lib"></a>mono_lib |  -   | String | optional | "" |
| <a id="nuget_package-mono_ref"></a>mono_ref |  -   | String | optional | "" |
| <a id="nuget_package-mono_tool"></a>mono_tool |  -   | String | optional | "" |
| <a id="nuget_package-net_deps"></a>net_deps |  -   | <a href="https://bazel.build/docs/skylark/lib/dict.html">Dictionary: String -> List of strings</a> | optional | {} |
| <a id="nuget_package-net_files"></a>net_files |  -   | <a href="https://bazel.build/docs/skylark/lib/dict.html">Dictionary: String -> List of strings</a> | optional | {} |
| <a id="nuget_package-net_lib"></a>net_lib |  -   | <a href="https://bazel.build/docs/skylark/lib/dict.html">Dictionary: String -> String</a> | optional | {} |
| <a id="nuget_package-net_ref"></a>net_ref |  -   | <a href="https://bazel.build/docs/skylark/lib/dict.html">Dictionary: String -> String</a> | optional | {} |
| <a id="nuget_package-net_tool"></a>net_tool |  -   | <a href="https://bazel.build/docs/skylark/lib/dict.html">Dictionary: String -> String</a> | optional | {} |
| <a id="nuget_package-package"></a>package |  The nuget package name.   | String | required |  |
| <a id="nuget_package-repo_mapping"></a>repo_mapping |  A dictionary from local repository name to global repository name. This allows controls over workspace dependency resolution for dependencies of this repository.&lt;p&gt;For example, an entry <code>"@foo": "@bar"</code> declares that, for any time this repository depends on <code>@foo</code> (such as a dependency on <code>@foo//some:target</code>, it should actually resolve that dependency within globally-declared <code>@bar</code> (<code>@bar//some:target</code>).   | <a href="https://bazel.build/docs/skylark/lib/dict.html">Dictionary: String -> String</a> | required |  |
| <a id="nuget_package-sha256"></a>sha256 |  The nuget package sha256 digest.   | String | optional | "" |
| <a id="nuget_package-source"></a>source |  The nuget base url for downloading the package. The final url is in the format {source}/{package}/{version}.   | List of strings | optional | ["https://www.nuget.org/api/v2/package"] |
| <a id="nuget_package-version"></a>version |  The nuget package version.   | String | required |  |


<a id="#DotnetContextInfo"></a>

## DotnetContextInfo

<pre>
DotnetContextInfo(<a href="#DotnetContextInfo-label">label</a>, <a href="#DotnetContextInfo-toolchain">toolchain</a>, <a href="#DotnetContextInfo-actions">actions</a>, <a href="#DotnetContextInfo-assembly">assembly</a>, <a href="#DotnetContextInfo-resx">resx</a>, <a href="#DotnetContextInfo-stdlib_byname">stdlib_byname</a>, <a href="#DotnetContextInfo-exe_extension">exe_extension</a>, <a href="#DotnetContextInfo-runner">runner</a>,
                  <a href="#DotnetContextInfo-mcs">mcs</a>, <a href="#DotnetContextInfo-workspace_name">workspace_name</a>, <a href="#DotnetContextInfo-libVersion">libVersion</a>, <a href="#DotnetContextInfo-framework">framework</a>, <a href="#DotnetContextInfo-lib">lib</a>, <a href="#DotnetContextInfo-shared">shared</a>, <a href="#DotnetContextInfo-debug">debug</a>, <a href="#DotnetContextInfo-_ctx">_ctx</a>)
</pre>

Enriches standard context with additional fields used by rules.

    DotnetContextInfo is never returned by a rule, instead you build one using 
    [dotnet_context(ctx)](api.md#dotnet_context) in the top of any custom skylark rule that wants 
    to interact with the dotnet rules.
    It provides all the information needed to create dotnet actions, and create or interact with the 
    other dotnet providers.

    When you get a DotnetContextInfo from a context it exposes a number of fields and methods.

    All methods take the DotnetContextInfo as the only positional argument, all other arguments even if
    mandatory must be specified by name, to allow us to re-order and deprecate individual parameters
    over time.

    

**FIELDS**


| Name  | Description |
| :------------- | :------------- |
| <a id="DotnetContextInfo-label"></a>label |  Rule's label.    |
| <a id="DotnetContextInfo-toolchain"></a>toolchain |  Toolchain selected for the rule.    |
| <a id="DotnetContextInfo-actions"></a>actions |  Copy of ctx.actions (legacy).    |
| <a id="DotnetContextInfo-assembly"></a>assembly |  Toolchain's assembly function. See [emit_assembly_core_csharp](api.md#emit_assembly_core_csharp) and [emit_assembly_core_fsharp](api.md#emit_assembly_core_fsharp) for the function signature.    |
| <a id="DotnetContextInfo-resx"></a>resx |  Toolchain's resx function. See [emit_resx_core](api.md#emit_resx_core) for the function signature.    |
| <a id="DotnetContextInfo-stdlib_byname"></a>stdlib_byname |  Helper function for locating stdlib by name.    |
| <a id="DotnetContextInfo-exe_extension"></a>exe_extension |  The suffix to use for all executables in this build mode. Mostly used when generating the output filenames of binary rules.    |
| <a id="DotnetContextInfo-runner"></a>runner |  An executable to be used by SDK to launch .NET Core programs (dotnet(.exe)).    |
| <a id="DotnetContextInfo-mcs"></a>mcs |  C# compiler.    |
| <a id="DotnetContextInfo-workspace_name"></a>workspace_name |  Workspace name.    |
| <a id="DotnetContextInfo-libVersion"></a>libVersion |  Should not be used.    |
| <a id="DotnetContextInfo-framework"></a>framework |  Framework version as specified in dotnet/platform/list.bzl.    |
| <a id="DotnetContextInfo-lib"></a>lib |  Lib folder as declared in context_data.    |
| <a id="DotnetContextInfo-shared"></a>shared |  Shared folder as declared in context_data.    |
| <a id="DotnetContextInfo-debug"></a>debug |  True if debug compilation is requested.    |
| <a id="DotnetContextInfo-_ctx"></a>_ctx |  Original context.    |


<a id="#DotnetLibraryInfo"></a>

## DotnetLibraryInfo

<pre>
DotnetLibraryInfo(<a href="#DotnetLibraryInfo-label">label</a>, <a href="#DotnetLibraryInfo-name">name</a>, <a href="#DotnetLibraryInfo-version">version</a>, <a href="#DotnetLibraryInfo-ref">ref</a>, <a href="#DotnetLibraryInfo-deps">deps</a>, <a href="#DotnetLibraryInfo-result">result</a>, <a href="#DotnetLibraryInfo-pdb">pdb</a>, <a href="#DotnetLibraryInfo-runfiles">runfiles</a>, <a href="#DotnetLibraryInfo-transitive">transitive</a>)
</pre>

DotnetLibraryInfo is a provider that exposes a compiled assembly along with it's full transitive dependencies.

**FIELDS**


| Name  | Description |
| :------------- | :------------- |
| <a id="DotnetLibraryInfo-label"></a>label |  Label of the rule used to create this DotnetLibraryInfo.    |
| <a id="DotnetLibraryInfo-name"></a>name |  Name of the assembly (label.name if not provided).    |
| <a id="DotnetLibraryInfo-version"></a>version |  Version number of the library. Tuple with 5 elements.    |
| <a id="DotnetLibraryInfo-ref"></a>ref |  Reference assembly for this DotnetLibraryInfo. Must be set to ctx.attr.ref or result if not provided. See [reference assembly](https://docs.microsoft.com/en-us/dotnet/standard/assembly/reference-assemblies).    |
| <a id="DotnetLibraryInfo-deps"></a>deps |  The direct dependencies of this library.    |
| <a id="DotnetLibraryInfo-result"></a>result |  The assembly file.    |
| <a id="DotnetLibraryInfo-pdb"></a>pdb |  The pdb file (with compilation mode dbg).    |
| <a id="DotnetLibraryInfo-runfiles"></a>runfiles |  The depset of direct runfiles (File).    |
| <a id="DotnetLibraryInfo-transitive"></a>transitive |  The full set of transitive dependencies. This does not include this assembly. List of DotnetLibraryInfo    |


<a id="#DotnetResourceInfo"></a>

## DotnetResourceInfo

<pre>
DotnetResourceInfo(<a href="#DotnetResourceInfo-label">label</a>, <a href="#DotnetResourceInfo-name">name</a>, <a href="#DotnetResourceInfo-result">result</a>, <a href="#DotnetResourceInfo-identifier">identifier</a>)
</pre>

Represents a resource file.

**FIELDS**


| Name  | Description |
| :------------- | :------------- |
| <a id="DotnetResourceInfo-label"></a>label |  Label of the rule used to create this provider.    |
| <a id="DotnetResourceInfo-name"></a>name |  Name of the resource.    |
| <a id="DotnetResourceInfo-result"></a>result |  The file to be embeded into assembly.    |
| <a id="DotnetResourceInfo-identifier"></a>identifier |  Identifier used when loading the resource.    |


<a id="#DotnetResourceListInfo"></a>

## DotnetResourceListInfo

<pre>
DotnetResourceListInfo(<a href="#DotnetResourceListInfo-result">result</a>)
</pre>

Represents resource files. 

**FIELDS**


| Name  | Description |
| :------------- | :------------- |
| <a id="DotnetResourceListInfo-result"></a>result |  Array of [DotnetResourceInfo](api.md#dotnetresourceinfo).    |


<a id="#dotnet_context"></a>

## dotnet_context

<pre>
dotnet_context(<a href="#dotnet_context-ctx">ctx</a>, <a href="#dotnet_context-lang">lang</a>)
</pre>

Converts rule's context to [DotnetContextInfo](api.md#dotnetcontextinfo)

It uses the attrbutes and the toolchains.

It can only be used in the implementation of a rule that has the dotnet toolchain attached and
the dotnet context data as an attribute.

If you are writing a new rule that wants to use the Dotnet toolchain, you need to do a couple of things.
First, you have to declare that you want to consume the toolchain on the rule declaration.

```python
my_rule_core = rule(
  _my_rule_impl,
  attrs = {
      ...
    "dotnet_context_data": attr.label(default = Label("@io_bazel_rules_dotnet//:core_context_data"))
  },
  toolchains = ["@io_bazel_rules_dotnet//dotnet:toolchain_type_csharp_core"],
)
```

And then in the rule body, you need to get the toolchain itself and use it's action generators.

```python
def _my_rule_impl(ctx):
    dotnet = dotnet_context(ctx)
```


**PARAMETERS**


| Name  | Description | Default Value |
| :------------- | :------------- | :------------- |
| <a id="dotnet_context-ctx"></a>ctx |  The Bazel ctx object for the current rule.   |  none |
| <a id="dotnet_context-lang"></a>lang |  The proramming languge for the current rule.   |  none |


<a id="#dotnet_register_toolchains"></a>

## dotnet_register_toolchains

<pre>
dotnet_register_toolchains(<a href="#dotnet_register_toolchains-name">name</a>)
</pre>

The macro registers all toolchains.

**PARAMETERS**


| Name  | Description | Default Value |
| :------------- | :------------- | :------------- |
| <a id="dotnet_register_toolchains-name"></a>name |  <p align="center"> - </p>   |  <code>None</code> |


<a id="#dotnet_repositories"></a>

## dotnet_repositories

<pre>
dotnet_repositories()
</pre>

Fetches remote repositories required before loading other rules_dotnet files. 

It fetches basic dependencies. For example: bazel_skylib is loaded.



<a id="#dotnet_repositories_nugets"></a>

## dotnet_repositories_nugets

<pre>
dotnet_repositories_nugets()
</pre>

Loads nugets used by dotnet_rules itself.



<a id="#emit_assembly_core_csharp"></a>

## emit_assembly_core_csharp

<pre>
emit_assembly_core_csharp(<a href="#emit_assembly_core_csharp-dotnet">dotnet</a>, <a href="#emit_assembly_core_csharp-name">name</a>, <a href="#emit_assembly_core_csharp-srcs">srcs</a>, <a href="#emit_assembly_core_csharp-deps">deps</a>, <a href="#emit_assembly_core_csharp-out">out</a>, <a href="#emit_assembly_core_csharp-resources">resources</a>, <a href="#emit_assembly_core_csharp-executable">executable</a>, <a href="#emit_assembly_core_csharp-defines">defines</a>, <a href="#emit_assembly_core_csharp-unsafe">unsafe</a>,
                          <a href="#emit_assembly_core_csharp-data">data</a>, <a href="#emit_assembly_core_csharp-keyfile">keyfile</a>, <a href="#emit_assembly_core_csharp-subdir">subdir</a>, <a href="#emit_assembly_core_csharp-target_framework">target_framework</a>, <a href="#emit_assembly_core_csharp-nowarn">nowarn</a>, <a href="#emit_assembly_core_csharp-langversion">langversion</a>, <a href="#emit_assembly_core_csharp-version">version</a>)
</pre>

Emits actions for assembly build.

The function is used to build C# assemblies..


**PARAMETERS**


| Name  | Description | Default Value |
| :------------- | :------------- | :------------- |
| <a id="emit_assembly_core_csharp-dotnet"></a>dotnet |  DotnetContextInfo provider   |  none |
| <a id="emit_assembly_core_csharp-name"></a>name |  name of the assembly   |  none |
| <a id="emit_assembly_core_csharp-srcs"></a>srcs |  source files (as passed from rules: list of lables/targets)   |  none |
| <a id="emit_assembly_core_csharp-deps"></a>deps |  list of DotnetLibraryInfo. Dependencies as passed from rules)   |  <code>None</code> |
| <a id="emit_assembly_core_csharp-out"></a>out |  output file name if provided. Otherwise name is used   |  <code>None</code> |
| <a id="emit_assembly_core_csharp-resources"></a>resources |  list of DotnetResourceListInfo provider   |  <code>None</code> |
| <a id="emit_assembly_core_csharp-executable"></a>executable |  bool. True for executable assembly, False otherwise   |  <code>True</code> |
| <a id="emit_assembly_core_csharp-defines"></a>defines |  list of string. Defines to pass to a compiler   |  <code>None</code> |
| <a id="emit_assembly_core_csharp-unsafe"></a>unsafe |  /unsafe flag (False - default - /unsafe-, otherwise /unsafe+)   |  <code>False</code> |
| <a id="emit_assembly_core_csharp-data"></a>data |  list of targets (as passed from rules). Additional depdendencies of the target   |  <code>None</code> |
| <a id="emit_assembly_core_csharp-keyfile"></a>keyfile |  File to be used for signing if provided   |  <code>None</code> |
| <a id="emit_assembly_core_csharp-subdir"></a>subdir |  specific subdirectory to be used for target location. Default ./   |  <code>"./"</code> |
| <a id="emit_assembly_core_csharp-target_framework"></a>target_framework |  target framework to define via System.Runtime.Versioning.TargetFramework   |  <code>""</code> |
| <a id="emit_assembly_core_csharp-nowarn"></a>nowarn |  list of warnings to ignore   |  <code>None</code> |
| <a id="emit_assembly_core_csharp-langversion"></a>langversion |  version of the language to use (see https://docs.microsoft.com/en-us/dotnet/csharp/language-reference/configure-language-version)   |  <code>"latest"</code> |
| <a id="emit_assembly_core_csharp-version"></a>version |  version of the file to be compiled   |  <code>(0, 0, 0, 0, "")</code> |


<a id="#emit_assembly_core_fsharp"></a>

## emit_assembly_core_fsharp

<pre>
emit_assembly_core_fsharp(<a href="#emit_assembly_core_fsharp-dotnet">dotnet</a>, <a href="#emit_assembly_core_fsharp-name">name</a>, <a href="#emit_assembly_core_fsharp-srcs">srcs</a>, <a href="#emit_assembly_core_fsharp-deps">deps</a>, <a href="#emit_assembly_core_fsharp-out">out</a>, <a href="#emit_assembly_core_fsharp-resources">resources</a>, <a href="#emit_assembly_core_fsharp-executable">executable</a>, <a href="#emit_assembly_core_fsharp-defines">defines</a>, <a href="#emit_assembly_core_fsharp-data">data</a>,
                          <a href="#emit_assembly_core_fsharp-keyfile">keyfile</a>, <a href="#emit_assembly_core_fsharp-subdir">subdir</a>, <a href="#emit_assembly_core_fsharp-target_framework">target_framework</a>, <a href="#emit_assembly_core_fsharp-nowarn">nowarn</a>, <a href="#emit_assembly_core_fsharp-langversion">langversion</a>, <a href="#emit_assembly_core_fsharp-version">version</a>)
</pre>

Emits actions for assembly build.

The function is used got build F# assemblies.


**PARAMETERS**


| Name  | Description | Default Value |
| :------------- | :------------- | :------------- |
| <a id="emit_assembly_core_fsharp-dotnet"></a>dotnet |  DotnetContextInfo provider   |  none |
| <a id="emit_assembly_core_fsharp-name"></a>name |  name of the assembly   |  none |
| <a id="emit_assembly_core_fsharp-srcs"></a>srcs |  source files (as passed from rules: list of lables/targets)   |  none |
| <a id="emit_assembly_core_fsharp-deps"></a>deps |  list of DotnetLibraryInfo. Dependencies as passed from rules)   |  <code>None</code> |
| <a id="emit_assembly_core_fsharp-out"></a>out |  output file name if provided. Otherwise name is used   |  <code>None</code> |
| <a id="emit_assembly_core_fsharp-resources"></a>resources |  list of DotnetResourceListInfo provider   |  <code>None</code> |
| <a id="emit_assembly_core_fsharp-executable"></a>executable |  bool. True for executable assembly, False otherwise   |  <code>True</code> |
| <a id="emit_assembly_core_fsharp-defines"></a>defines |  list of string. Defines to pass to a compiler   |  <code>None</code> |
| <a id="emit_assembly_core_fsharp-data"></a>data |  list of targets (as passed from rules). Additional depdendencies of the target   |  <code>None</code> |
| <a id="emit_assembly_core_fsharp-keyfile"></a>keyfile |  File to be used for signing if provided   |  <code>None</code> |
| <a id="emit_assembly_core_fsharp-subdir"></a>subdir |  specific subdirectory to be used for target location. Default ./   |  <code>"./"</code> |
| <a id="emit_assembly_core_fsharp-target_framework"></a>target_framework |  target framework to define via System.Runtime.Versioning.TargetFramework   |  <code>""</code> |
| <a id="emit_assembly_core_fsharp-nowarn"></a>nowarn |  list of warnings to ignore   |  <code>None</code> |
| <a id="emit_assembly_core_fsharp-langversion"></a>langversion |  version of the language to use (see https://docs.microsoft.com/en-us/dotnet/csharp/language-reference/configure-language-version)   |  <code>"latest"</code> |
| <a id="emit_assembly_core_fsharp-version"></a>version |  version of the file to be compiled   |  <code>(0, 0, 0, 0, "")</code> |


<a id="#emit_resx_core"></a>

## emit_resx_core

<pre>
emit_resx_core(<a href="#emit_resx_core-dotnet">dotnet</a>, <a href="#emit_resx_core-name">name</a>, <a href="#emit_resx_core-src">src</a>, <a href="#emit_resx_core-identifier">identifier</a>, <a href="#emit_resx_core-out">out</a>, <a href="#emit_resx_core-customresgen">customresgen</a>)
</pre>

The function adds an action that compiles a single .resx file into .resources file.

Returns [DotnetResourceInfo](api.md#dotnetresourceinfo).


**PARAMETERS**


| Name  | Description | Default Value |
| :------------- | :------------- | :------------- |
| <a id="emit_resx_core-dotnet"></a>dotnet |  [DotnetContextInfo](api.md#dotnetcontextinfo).   |  none |
| <a id="emit_resx_core-name"></a>name |  name of the file to generate.   |  <code>""</code> |
| <a id="emit_resx_core-src"></a>src |  The .resx source file that is transformed into .resources file. Only <code>.resx</code> files are permitted.   |  <code>None</code> |
| <a id="emit_resx_core-identifier"></a>identifier |  The logical name for the resource; the name that is used to load the resource. The default is the basename of the file name (no subfolder).   |  <code>None</code> |
| <a id="emit_resx_core-out"></a>out |  An alternative name of the output file (if name should not be used).   |  <code>None</code> |
| <a id="emit_resx_core-customresgen"></a>customresgen |  custom resgen program to use.   |  <code>None</code> |


