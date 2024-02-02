<!-- Generated with Stardoc: http://skydoc.bazel.build -->

Public API surface is re-exported here.

Users should not load files under "/dotnet"


<a id="import_dll"></a>

## import_dll

<pre>
import_dll(<a href="#import_dll-name">name</a>, <a href="#import_dll-data">data</a>, <a href="#import_dll-dll">dll</a>, <a href="#import_dll-version">version</a>)
</pre>

Imports a DLL

**ATTRIBUTES**


| Name  | Description | Type | Mandatory | Default |
| :------------- | :------------- | :------------- | :------------- | :------------- |
| <a id="import_dll-name"></a>name |  A unique name for this target.   | <a href="https://bazel.build/concepts/labels#target-names">Name</a> | required |  |
| <a id="import_dll-data"></a>data |  Other files that this DLL depends on at runtime   | <a href="https://bazel.build/concepts/labels">List of labels</a> | optional | <code>[]</code> |
| <a id="import_dll-dll"></a>dll |  The name of the library   | <a href="https://bazel.build/concepts/labels">Label</a> | required |  |
| <a id="import_dll-version"></a>version |  The version of the library   | String | optional | <code>""</code> |


<a id="import_library"></a>

## import_library

<pre>
import_library(<a href="#import_library-name">name</a>, <a href="#import_library-analyzers">analyzers</a>, <a href="#import_library-data">data</a>, <a href="#import_library-deps">deps</a>, <a href="#import_library-framework_list">framework_list</a>, <a href="#import_library-library_name">library_name</a>, <a href="#import_library-libs">libs</a>, <a href="#import_library-native">native</a>, <a href="#import_library-nupkg">nupkg</a>, <a href="#import_library-refs">refs</a>,
               <a href="#import_library-sha512">sha512</a>, <a href="#import_library-targeting_pack_overrides">targeting_pack_overrides</a>, <a href="#import_library-version">version</a>)
</pre>

Creates a target for a static DLL for a specific target framework

**ATTRIBUTES**


| Name  | Description | Type | Mandatory | Default |
| :------------- | :------------- | :------------- | :------------- | :------------- |
| <a id="import_library-name"></a>name |  A unique name for this target.   | <a href="https://bazel.build/concepts/labels#target-names">Name</a> | required |  |
| <a id="import_library-analyzers"></a>analyzers |  Static analyzer DLLs   | <a href="https://bazel.build/concepts/labels">List of labels</a> | optional | <code>[]</code> |
| <a id="import_library-data"></a>data |  Other files that this DLL depends on at runtime   | <a href="https://bazel.build/concepts/labels">List of labels</a> | optional | <code>[]</code> |
| <a id="import_library-deps"></a>deps |  Other DLLs that this DLL depends on.   | <a href="https://bazel.build/concepts/labels">List of labels</a> | optional | <code>[]</code> |
| <a id="import_library-framework_list"></a>framework_list |  Targeting packs like e.g. Microsoft.NETCore.App.Ref have a PlatformManifest.txt that includes all the DLLs that are included in the targeting pack. This is used to determine which version of a DLL should be used during compilation or runtime.   | <a href="https://bazel.build/rules/lib/dict">Dictionary: String -> String</a> | optional | <code>{}</code> |
| <a id="import_library-library_name"></a>library_name |  The name of the library   | String | required |  |
| <a id="import_library-libs"></a>libs |  Static runtime DLLs   | <a href="https://bazel.build/concepts/labels">List of labels</a> | optional | <code>[]</code> |
| <a id="import_library-native"></a>native |  Native runtime DLLs   | <a href="https://bazel.build/concepts/labels">List of labels</a> | optional | <code>[]</code> |
| <a id="import_library-nupkg"></a>nupkg |  The <code>.nupkg</code> file providing this import   | <a href="https://bazel.build/concepts/labels">Label</a> | optional | <code>None</code> |
| <a id="import_library-refs"></a>refs |  Compile time DLLs   | <a href="https://bazel.build/concepts/labels">List of labels</a> | optional | <code>[]</code> |
| <a id="import_library-sha512"></a>sha512 |  The SHA512 sum of the NuGet package   | String | optional | <code>""</code> |
| <a id="import_library-targeting_pack_overrides"></a>targeting_pack_overrides |  Targeting packs like e.g. Microsoft.NETCore.App.Ref have a PackageOverride.txt that includes a list of NuGet packages that should be omitted in a compiliation because they are included in the targeting pack   | <a href="https://bazel.build/rules/lib/dict">Dictionary: String -> String</a> | optional | <code>{}</code> |
| <a id="import_library-version"></a>version |  The version of the library   | String | optional | <code>""</code> |


<a id="nuget_archive"></a>

## nuget_archive

<pre>
nuget_archive(<a href="#nuget_archive-name">name</a>, <a href="#nuget_archive-id">id</a>, <a href="#nuget_archive-netrc">netrc</a>, <a href="#nuget_archive-repo_mapping">repo_mapping</a>, <a href="#nuget_archive-sha512">sha512</a>, <a href="#nuget_archive-sources">sources</a>, <a href="#nuget_archive-version">version</a>)
</pre>



**ATTRIBUTES**


| Name  | Description | Type | Mandatory | Default |
| :------------- | :------------- | :------------- | :------------- | :------------- |
| <a id="nuget_archive-name"></a>name |  A unique name for this repository.   | <a href="https://bazel.build/concepts/labels#target-names">Name</a> | required |  |
| <a id="nuget_archive-id"></a>id |  -   | String | optional | <code>""</code> |
| <a id="nuget_archive-netrc"></a>netrc |  -   | <a href="https://bazel.build/concepts/labels">Label</a> | optional | <code>None</code> |
| <a id="nuget_archive-repo_mapping"></a>repo_mapping |  A dictionary from local repository name to global repository name. This allows controls over workspace dependency resolution for dependencies of this repository.&lt;p&gt;For example, an entry <code>"@foo": "@bar"</code> declares that, for any time this repository depends on <code>@foo</code> (such as a dependency on <code>@foo//some:target</code>, it should actually resolve that dependency within globally-declared <code>@bar</code> (<code>@bar//some:target</code>).   | <a href="https://bazel.build/rules/lib/dict">Dictionary: String -> String</a> | required |  |
| <a id="nuget_archive-sha512"></a>sha512 |  -   | String | optional | <code>""</code> |
| <a id="nuget_archive-sources"></a>sources |  -   | List of strings | optional | <code>[]</code> |
| <a id="nuget_archive-version"></a>version |  -   | String | optional | <code>""</code> |


<a id="csharp_binary"></a>

## csharp_binary

<pre>
csharp_binary(<a href="#csharp_binary-runtime_identifier">runtime_identifier</a>, <a href="#csharp_binary-use_apphost_shim">use_apphost_shim</a>, <a href="#csharp_binary-treat_warnings_as_errors">treat_warnings_as_errors</a>, <a href="#csharp_binary-warnings_as_errors">warnings_as_errors</a>,
              <a href="#csharp_binary-warnings_not_as_errors">warnings_not_as_errors</a>, <a href="#csharp_binary-warning_level">warning_level</a>, <a href="#csharp_binary-strict_deps">strict_deps</a>, <a href="#csharp_binary-kwargs">kwargs</a>)
</pre>



**PARAMETERS**


| Name  | Description | Default Value |
| :------------- | :------------- | :------------- |
| <a id="csharp_binary-runtime_identifier"></a>runtime_identifier |  <p align="center"> - </p>   |  <code>None</code> |
| <a id="csharp_binary-use_apphost_shim"></a>use_apphost_shim |  <p align="center"> - </p>   |  <code>True</code> |
| <a id="csharp_binary-treat_warnings_as_errors"></a>treat_warnings_as_errors |  <p align="center"> - </p>   |  <code>None</code> |
| <a id="csharp_binary-warnings_as_errors"></a>warnings_as_errors |  <p align="center"> - </p>   |  <code>None</code> |
| <a id="csharp_binary-warnings_not_as_errors"></a>warnings_not_as_errors |  <p align="center"> - </p>   |  <code>None</code> |
| <a id="csharp_binary-warning_level"></a>warning_level |  <p align="center"> - </p>   |  <code>None</code> |
| <a id="csharp_binary-strict_deps"></a>strict_deps |  <p align="center"> - </p>   |  <code>None</code> |
| <a id="csharp_binary-kwargs"></a>kwargs |  <p align="center"> - </p>   |  none |


<a id="csharp_library"></a>

## csharp_library

<pre>
csharp_library(<a href="#csharp_library-runtime_identifier">runtime_identifier</a>, <a href="#csharp_library-treat_warnings_as_errors">treat_warnings_as_errors</a>, <a href="#csharp_library-warnings_as_errors">warnings_as_errors</a>,
               <a href="#csharp_library-warnings_not_as_errors">warnings_not_as_errors</a>, <a href="#csharp_library-warning_level">warning_level</a>, <a href="#csharp_library-strict_deps">strict_deps</a>, <a href="#csharp_library-kwargs">kwargs</a>)
</pre>



**PARAMETERS**


| Name  | Description | Default Value |
| :------------- | :------------- | :------------- |
| <a id="csharp_library-runtime_identifier"></a>runtime_identifier |  <p align="center"> - </p>   |  <code>None</code> |
| <a id="csharp_library-treat_warnings_as_errors"></a>treat_warnings_as_errors |  <p align="center"> - </p>   |  <code>None</code> |
| <a id="csharp_library-warnings_as_errors"></a>warnings_as_errors |  <p align="center"> - </p>   |  <code>None</code> |
| <a id="csharp_library-warnings_not_as_errors"></a>warnings_not_as_errors |  <p align="center"> - </p>   |  <code>None</code> |
| <a id="csharp_library-warning_level"></a>warning_level |  <p align="center"> - </p>   |  <code>None</code> |
| <a id="csharp_library-strict_deps"></a>strict_deps |  <p align="center"> - </p>   |  <code>None</code> |
| <a id="csharp_library-kwargs"></a>kwargs |  <p align="center"> - </p>   |  none |


<a id="csharp_nunit_test"></a>

## csharp_nunit_test

<pre>
csharp_nunit_test(<a href="#csharp_nunit_test-runtime_identifier">runtime_identifier</a>, <a href="#csharp_nunit_test-use_apphost_shim">use_apphost_shim</a>, <a href="#csharp_nunit_test-treat_warnings_as_errors">treat_warnings_as_errors</a>,
                  <a href="#csharp_nunit_test-warnings_as_errors">warnings_as_errors</a>, <a href="#csharp_nunit_test-warnings_not_as_errors">warnings_not_as_errors</a>, <a href="#csharp_nunit_test-warning_level">warning_level</a>, <a href="#csharp_nunit_test-strict_deps">strict_deps</a>, <a href="#csharp_nunit_test-kwargs">kwargs</a>)
</pre>



**PARAMETERS**


| Name  | Description | Default Value |
| :------------- | :------------- | :------------- |
| <a id="csharp_nunit_test-runtime_identifier"></a>runtime_identifier |  <p align="center"> - </p>   |  <code>None</code> |
| <a id="csharp_nunit_test-use_apphost_shim"></a>use_apphost_shim |  <p align="center"> - </p>   |  <code>True</code> |
| <a id="csharp_nunit_test-treat_warnings_as_errors"></a>treat_warnings_as_errors |  <p align="center"> - </p>   |  <code>None</code> |
| <a id="csharp_nunit_test-warnings_as_errors"></a>warnings_as_errors |  <p align="center"> - </p>   |  <code>None</code> |
| <a id="csharp_nunit_test-warnings_not_as_errors"></a>warnings_not_as_errors |  <p align="center"> - </p>   |  <code>None</code> |
| <a id="csharp_nunit_test-warning_level"></a>warning_level |  <p align="center"> - </p>   |  <code>None</code> |
| <a id="csharp_nunit_test-strict_deps"></a>strict_deps |  <p align="center"> - </p>   |  <code>None</code> |
| <a id="csharp_nunit_test-kwargs"></a>kwargs |  <p align="center"> - </p>   |  none |


<a id="csharp_test"></a>

## csharp_test

<pre>
csharp_test(<a href="#csharp_test-runtime_identifier">runtime_identifier</a>, <a href="#csharp_test-use_apphost_shim">use_apphost_shim</a>, <a href="#csharp_test-treat_warnings_as_errors">treat_warnings_as_errors</a>, <a href="#csharp_test-warnings_as_errors">warnings_as_errors</a>,
            <a href="#csharp_test-warnings_not_as_errors">warnings_not_as_errors</a>, <a href="#csharp_test-warning_level">warning_level</a>, <a href="#csharp_test-strict_deps">strict_deps</a>, <a href="#csharp_test-kwargs">kwargs</a>)
</pre>



**PARAMETERS**


| Name  | Description | Default Value |
| :------------- | :------------- | :------------- |
| <a id="csharp_test-runtime_identifier"></a>runtime_identifier |  <p align="center"> - </p>   |  <code>None</code> |
| <a id="csharp_test-use_apphost_shim"></a>use_apphost_shim |  <p align="center"> - </p>   |  <code>True</code> |
| <a id="csharp_test-treat_warnings_as_errors"></a>treat_warnings_as_errors |  <p align="center"> - </p>   |  <code>None</code> |
| <a id="csharp_test-warnings_as_errors"></a>warnings_as_errors |  <p align="center"> - </p>   |  <code>None</code> |
| <a id="csharp_test-warnings_not_as_errors"></a>warnings_not_as_errors |  <p align="center"> - </p>   |  <code>None</code> |
| <a id="csharp_test-warning_level"></a>warning_level |  <p align="center"> - </p>   |  <code>None</code> |
| <a id="csharp_test-strict_deps"></a>strict_deps |  <p align="center"> - </p>   |  <code>None</code> |
| <a id="csharp_test-kwargs"></a>kwargs |  <p align="center"> - </p>   |  none |


<a id="fsharp_binary"></a>

## fsharp_binary

<pre>
fsharp_binary(<a href="#fsharp_binary-runtime_identifier">runtime_identifier</a>, <a href="#fsharp_binary-use_apphost_shim">use_apphost_shim</a>, <a href="#fsharp_binary-treat_warnings_as_errors">treat_warnings_as_errors</a>, <a href="#fsharp_binary-warnings_as_errors">warnings_as_errors</a>,
              <a href="#fsharp_binary-warnings_not_as_errors">warnings_not_as_errors</a>, <a href="#fsharp_binary-warning_level">warning_level</a>, <a href="#fsharp_binary-strict_deps">strict_deps</a>, <a href="#fsharp_binary-kwargs">kwargs</a>)
</pre>



**PARAMETERS**


| Name  | Description | Default Value |
| :------------- | :------------- | :------------- |
| <a id="fsharp_binary-runtime_identifier"></a>runtime_identifier |  <p align="center"> - </p>   |  <code>None</code> |
| <a id="fsharp_binary-use_apphost_shim"></a>use_apphost_shim |  <p align="center"> - </p>   |  <code>True</code> |
| <a id="fsharp_binary-treat_warnings_as_errors"></a>treat_warnings_as_errors |  <p align="center"> - </p>   |  <code>None</code> |
| <a id="fsharp_binary-warnings_as_errors"></a>warnings_as_errors |  <p align="center"> - </p>   |  <code>None</code> |
| <a id="fsharp_binary-warnings_not_as_errors"></a>warnings_not_as_errors |  <p align="center"> - </p>   |  <code>None</code> |
| <a id="fsharp_binary-warning_level"></a>warning_level |  <p align="center"> - </p>   |  <code>None</code> |
| <a id="fsharp_binary-strict_deps"></a>strict_deps |  <p align="center"> - </p>   |  <code>None</code> |
| <a id="fsharp_binary-kwargs"></a>kwargs |  <p align="center"> - </p>   |  none |


<a id="fsharp_library"></a>

## fsharp_library

<pre>
fsharp_library(<a href="#fsharp_library-runtime_identifier">runtime_identifier</a>, <a href="#fsharp_library-treat_warnings_as_errors">treat_warnings_as_errors</a>, <a href="#fsharp_library-warnings_as_errors">warnings_as_errors</a>,
               <a href="#fsharp_library-warnings_not_as_errors">warnings_not_as_errors</a>, <a href="#fsharp_library-warning_level">warning_level</a>, <a href="#fsharp_library-strict_deps">strict_deps</a>, <a href="#fsharp_library-kwargs">kwargs</a>)
</pre>



**PARAMETERS**


| Name  | Description | Default Value |
| :------------- | :------------- | :------------- |
| <a id="fsharp_library-runtime_identifier"></a>runtime_identifier |  <p align="center"> - </p>   |  <code>None</code> |
| <a id="fsharp_library-treat_warnings_as_errors"></a>treat_warnings_as_errors |  <p align="center"> - </p>   |  <code>None</code> |
| <a id="fsharp_library-warnings_as_errors"></a>warnings_as_errors |  <p align="center"> - </p>   |  <code>None</code> |
| <a id="fsharp_library-warnings_not_as_errors"></a>warnings_not_as_errors |  <p align="center"> - </p>   |  <code>None</code> |
| <a id="fsharp_library-warning_level"></a>warning_level |  <p align="center"> - </p>   |  <code>None</code> |
| <a id="fsharp_library-strict_deps"></a>strict_deps |  <p align="center"> - </p>   |  <code>None</code> |
| <a id="fsharp_library-kwargs"></a>kwargs |  <p align="center"> - </p>   |  none |


<a id="fsharp_nunit_test"></a>

## fsharp_nunit_test

<pre>
fsharp_nunit_test(<a href="#fsharp_nunit_test-runtime_identifier">runtime_identifier</a>, <a href="#fsharp_nunit_test-use_apphost_shim">use_apphost_shim</a>, <a href="#fsharp_nunit_test-treat_warnings_as_errors">treat_warnings_as_errors</a>,
                  <a href="#fsharp_nunit_test-warnings_as_errors">warnings_as_errors</a>, <a href="#fsharp_nunit_test-warnings_not_as_errors">warnings_not_as_errors</a>, <a href="#fsharp_nunit_test-warning_level">warning_level</a>, <a href="#fsharp_nunit_test-strict_deps">strict_deps</a>, <a href="#fsharp_nunit_test-kwargs">kwargs</a>)
</pre>



**PARAMETERS**


| Name  | Description | Default Value |
| :------------- | :------------- | :------------- |
| <a id="fsharp_nunit_test-runtime_identifier"></a>runtime_identifier |  <p align="center"> - </p>   |  <code>None</code> |
| <a id="fsharp_nunit_test-use_apphost_shim"></a>use_apphost_shim |  <p align="center"> - </p>   |  <code>True</code> |
| <a id="fsharp_nunit_test-treat_warnings_as_errors"></a>treat_warnings_as_errors |  <p align="center"> - </p>   |  <code>None</code> |
| <a id="fsharp_nunit_test-warnings_as_errors"></a>warnings_as_errors |  <p align="center"> - </p>   |  <code>None</code> |
| <a id="fsharp_nunit_test-warnings_not_as_errors"></a>warnings_not_as_errors |  <p align="center"> - </p>   |  <code>None</code> |
| <a id="fsharp_nunit_test-warning_level"></a>warning_level |  <p align="center"> - </p>   |  <code>None</code> |
| <a id="fsharp_nunit_test-strict_deps"></a>strict_deps |  <p align="center"> - </p>   |  <code>None</code> |
| <a id="fsharp_nunit_test-kwargs"></a>kwargs |  <p align="center"> - </p>   |  none |


<a id="fsharp_test"></a>

## fsharp_test

<pre>
fsharp_test(<a href="#fsharp_test-runtime_identifier">runtime_identifier</a>, <a href="#fsharp_test-use_apphost_shim">use_apphost_shim</a>, <a href="#fsharp_test-treat_warnings_as_errors">treat_warnings_as_errors</a>, <a href="#fsharp_test-warnings_as_errors">warnings_as_errors</a>,
            <a href="#fsharp_test-warnings_not_as_errors">warnings_not_as_errors</a>, <a href="#fsharp_test-warning_level">warning_level</a>, <a href="#fsharp_test-strict_deps">strict_deps</a>, <a href="#fsharp_test-kwargs">kwargs</a>)
</pre>



**PARAMETERS**


| Name  | Description | Default Value |
| :------------- | :------------- | :------------- |
| <a id="fsharp_test-runtime_identifier"></a>runtime_identifier |  <p align="center"> - </p>   |  <code>None</code> |
| <a id="fsharp_test-use_apphost_shim"></a>use_apphost_shim |  <p align="center"> - </p>   |  <code>True</code> |
| <a id="fsharp_test-treat_warnings_as_errors"></a>treat_warnings_as_errors |  <p align="center"> - </p>   |  <code>None</code> |
| <a id="fsharp_test-warnings_as_errors"></a>warnings_as_errors |  <p align="center"> - </p>   |  <code>None</code> |
| <a id="fsharp_test-warnings_not_as_errors"></a>warnings_not_as_errors |  <p align="center"> - </p>   |  <code>None</code> |
| <a id="fsharp_test-warning_level"></a>warning_level |  <p align="center"> - </p>   |  <code>None</code> |
| <a id="fsharp_test-strict_deps"></a>strict_deps |  <p align="center"> - </p>   |  <code>None</code> |
| <a id="fsharp_test-kwargs"></a>kwargs |  <p align="center"> - </p>   |  none |


<a id="nuget_repo"></a>

## nuget_repo

<pre>
nuget_repo(<a href="#nuget_repo-name">name</a>, <a href="#nuget_repo-packages">packages</a>)
</pre>



**PARAMETERS**


| Name  | Description | Default Value |
| :------------- | :------------- | :------------- |
| <a id="nuget_repo-name"></a>name |  <p align="center"> - </p>   |  none |
| <a id="nuget_repo-packages"></a>packages |  <p align="center"> - </p>   |  none |


<a id="publish_binary"></a>

## publish_binary

<pre>
publish_binary(<a href="#publish_binary-name">name</a>, <a href="#publish_binary-binary">binary</a>, <a href="#publish_binary-target_framework">target_framework</a>, <a href="#publish_binary-self_contained">self_contained</a>, <a href="#publish_binary-runtime_packs">runtime_packs</a>, <a href="#publish_binary-runtime_identifier">runtime_identifier</a>,
               <a href="#publish_binary-kwargs">kwargs</a>)
</pre>



**PARAMETERS**


| Name  | Description | Default Value |
| :------------- | :------------- | :------------- |
| <a id="publish_binary-name"></a>name |  <p align="center"> - </p>   |  none |
| <a id="publish_binary-binary"></a>binary |  <p align="center"> - </p>   |  none |
| <a id="publish_binary-target_framework"></a>target_framework |  <p align="center"> - </p>   |  none |
| <a id="publish_binary-self_contained"></a>self_contained |  <p align="center"> - </p>   |  <code>False</code> |
| <a id="publish_binary-runtime_packs"></a>runtime_packs |  <p align="center"> - </p>   |  <code>[]</code> |
| <a id="publish_binary-runtime_identifier"></a>runtime_identifier |  <p align="center"> - </p>   |  <code>None</code> |
| <a id="publish_binary-kwargs"></a>kwargs |  <p align="center"> - </p>   |  none |


