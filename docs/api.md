<!-- Generated with Stardoc: http://skydoc.bazel.build -->

<a id="#core_binary"></a>

## core_binary

<pre>
core_binary(<a href="#core_binary-name">name</a>, <a href="#core_binary-data">data</a>, <a href="#core_binary-defines">defines</a>, <a href="#core_binary-deps">deps</a>, <a href="#core_binary-dotnet_context_data">dotnet_context_data</a>, <a href="#core_binary-keyfile">keyfile</a>, <a href="#core_binary-langversion">langversion</a>, <a href="#core_binary-nowarn">nowarn</a>, <a href="#core_binary-out">out</a>,
            <a href="#core_binary-resources">resources</a>, <a href="#core_binary-srcs">srcs</a>, <a href="#core_binary-target_framework">target_framework</a>, <a href="#core_binary-unsafe">unsafe</a>, <a href="#core_binary-version">version</a>)
</pre>




**ATTRIBUTES**


| Name  | Description | Type | Mandatory | Default |
| :------------- | :------------- | :------------- | :------------- | :------------- |
| <a id="core_binary-name"></a>name |  A unique name for this target.   | <a href="https://bazel.build/docs/build-ref.html#name">Name</a> | required |  |
| <a id="core_binary-data"></a>data |  -   | <a href="https://bazel.build/docs/build-ref.html#labels">List of labels</a> | optional | [] |
| <a id="core_binary-defines"></a>defines |  -   | List of strings | optional | [] |
| <a id="core_binary-deps"></a>deps |  -   | <a href="https://bazel.build/docs/build-ref.html#labels">List of labels</a> | optional | [] |
| <a id="core_binary-dotnet_context_data"></a>dotnet_context_data |  -   | <a href="https://bazel.build/docs/build-ref.html#labels">Label</a> | optional | @io_bazel_rules_dotnet//:core_context_data |
| <a id="core_binary-keyfile"></a>keyfile |  -   | <a href="https://bazel.build/docs/build-ref.html#labels">Label</a> | optional | None |
| <a id="core_binary-langversion"></a>langversion |  -   | String | optional | "latest" |
| <a id="core_binary-nowarn"></a>nowarn |  -   | List of strings | optional | [] |
| <a id="core_binary-out"></a>out |  -   | String | optional | "" |
| <a id="core_binary-resources"></a>resources |  -   | <a href="https://bazel.build/docs/build-ref.html#labels">List of labels</a> | optional | [] |
| <a id="core_binary-srcs"></a>srcs |  -   | <a href="https://bazel.build/docs/build-ref.html#labels">List of labels</a> | optional | [] |
| <a id="core_binary-target_framework"></a>target_framework |  -   | String | optional | "" |
| <a id="core_binary-unsafe"></a>unsafe |  -   | Boolean | optional | False |
| <a id="core_binary-version"></a>version |  -   | String | optional | "" |


<a id="#core_context_data"></a>

## core_context_data

<pre>
core_context_data(<a href="#core_context_data-name">name</a>, <a href="#core_context_data-csc">csc</a>, <a href="#core_context_data-framework">framework</a>, <a href="#core_context_data-host">host</a>, <a href="#core_context_data-lib">lib</a>, <a href="#core_context_data-libVersion">libVersion</a>, <a href="#core_context_data-mcs_bin">mcs_bin</a>, <a href="#core_context_data-mono_bin">mono_bin</a>, <a href="#core_context_data-runner">runner</a>, <a href="#core_context_data-runtime">runtime</a>,
                  <a href="#core_context_data-shared">shared</a>, <a href="#core_context_data-tools">tools</a>)
</pre>




**ATTRIBUTES**


| Name  | Description | Type | Mandatory | Default |
| :------------- | :------------- | :------------- | :------------- | :------------- |
| <a id="core_context_data-name"></a>name |  A unique name for this target.   | <a href="https://bazel.build/docs/build-ref.html#name">Name</a> | required |  |
| <a id="core_context_data-csc"></a>csc |  -   | <a href="https://bazel.build/docs/build-ref.html#labels">Label</a> | optional | @io_bazel_rules_dotnet//dotnet/stdlib.core:csc.dll |
| <a id="core_context_data-framework"></a>framework |  -   | String | optional | "" |
| <a id="core_context_data-host"></a>host |  -   | <a href="https://bazel.build/docs/build-ref.html#labels">Label</a> | optional | None |
| <a id="core_context_data-lib"></a>lib |  -   | <a href="https://bazel.build/docs/build-ref.html#labels">Label</a> | optional | None |
| <a id="core_context_data-libVersion"></a>libVersion |  -   | String | optional | "" |
| <a id="core_context_data-mcs_bin"></a>mcs_bin |  -   | <a href="https://bazel.build/docs/build-ref.html#labels">Label</a> | optional | None |
| <a id="core_context_data-mono_bin"></a>mono_bin |  -   | <a href="https://bazel.build/docs/build-ref.html#labels">Label</a> | optional | None |
| <a id="core_context_data-runner"></a>runner |  -   | <a href="https://bazel.build/docs/build-ref.html#labels">Label</a> | optional | @core_sdk//:runner |
| <a id="core_context_data-runtime"></a>runtime |  -   | <a href="https://bazel.build/docs/build-ref.html#labels">Label</a> | optional | @io_bazel_rules_dotnet//dotnet/stdlib.core:runtime |
| <a id="core_context_data-shared"></a>shared |  -   | <a href="https://bazel.build/docs/build-ref.html#labels">Label</a> | optional | None |
| <a id="core_context_data-tools"></a>tools |  -   | <a href="https://bazel.build/docs/build-ref.html#labels">Label</a> | optional | None |


<a id="#core_import_binary"></a>

## core_import_binary

<pre>
core_import_binary(<a href="#core_import_binary-name">name</a>, <a href="#core_import_binary-data">data</a>, <a href="#core_import_binary-deps">deps</a>, <a href="#core_import_binary-ref">ref</a>, <a href="#core_import_binary-src">src</a>, <a href="#core_import_binary-version">version</a>)
</pre>




**ATTRIBUTES**


| Name  | Description | Type | Mandatory | Default |
| :------------- | :------------- | :------------- | :------------- | :------------- |
| <a id="core_import_binary-name"></a>name |  A unique name for this target.   | <a href="https://bazel.build/docs/build-ref.html#name">Name</a> | required |  |
| <a id="core_import_binary-data"></a>data |  -   | <a href="https://bazel.build/docs/build-ref.html#labels">List of labels</a> | optional | [] |
| <a id="core_import_binary-deps"></a>deps |  -   | <a href="https://bazel.build/docs/build-ref.html#labels">List of labels</a> | optional | [] |
| <a id="core_import_binary-ref"></a>ref |  -   | <a href="https://bazel.build/docs/build-ref.html#labels">Label</a> | optional | None |
| <a id="core_import_binary-src"></a>src |  -   | <a href="https://bazel.build/docs/build-ref.html#labels">Label</a> | required |  |
| <a id="core_import_binary-version"></a>version |  -   | String | required |  |


<a id="#core_import_binary_internal"></a>

## core_import_binary_internal

<pre>
core_import_binary_internal(<a href="#core_import_binary_internal-name">name</a>, <a href="#core_import_binary_internal-data">data</a>, <a href="#core_import_binary_internal-deps">deps</a>, <a href="#core_import_binary_internal-ref">ref</a>, <a href="#core_import_binary_internal-runner">runner</a>, <a href="#core_import_binary_internal-runtime">runtime</a>, <a href="#core_import_binary_internal-src">src</a>, <a href="#core_import_binary_internal-version">version</a>)
</pre>




**ATTRIBUTES**


| Name  | Description | Type | Mandatory | Default |
| :------------- | :------------- | :------------- | :------------- | :------------- |
| <a id="core_import_binary_internal-name"></a>name |  A unique name for this target.   | <a href="https://bazel.build/docs/build-ref.html#name">Name</a> | required |  |
| <a id="core_import_binary_internal-data"></a>data |  -   | <a href="https://bazel.build/docs/build-ref.html#labels">List of labels</a> | optional | [] |
| <a id="core_import_binary_internal-deps"></a>deps |  -   | <a href="https://bazel.build/docs/build-ref.html#labels">List of labels</a> | optional | [] |
| <a id="core_import_binary_internal-ref"></a>ref |  -   | <a href="https://bazel.build/docs/build-ref.html#labels">Label</a> | optional | None |
| <a id="core_import_binary_internal-runner"></a>runner |  -   | <a href="https://bazel.build/docs/build-ref.html#labels">Label</a> | optional | @core_sdk//:runner |
| <a id="core_import_binary_internal-runtime"></a>runtime |  -   | <a href="https://bazel.build/docs/build-ref.html#labels">Label</a> | optional | @io_bazel_rules_dotnet//dotnet/stdlib.core:runtime |
| <a id="core_import_binary_internal-src"></a>src |  -   | <a href="https://bazel.build/docs/build-ref.html#labels">Label</a> | required |  |
| <a id="core_import_binary_internal-version"></a>version |  -   | String | required |  |


<a id="#core_import_library"></a>

## core_import_library

<pre>
core_import_library(<a href="#core_import_library-name">name</a>, <a href="#core_import_library-data">data</a>, <a href="#core_import_library-deps">deps</a>, <a href="#core_import_library-ref">ref</a>, <a href="#core_import_library-src">src</a>, <a href="#core_import_library-version">version</a>)
</pre>




**ATTRIBUTES**


| Name  | Description | Type | Mandatory | Default |
| :------------- | :------------- | :------------- | :------------- | :------------- |
| <a id="core_import_library-name"></a>name |  A unique name for this target.   | <a href="https://bazel.build/docs/build-ref.html#name">Name</a> | required |  |
| <a id="core_import_library-data"></a>data |  -   | <a href="https://bazel.build/docs/build-ref.html#labels">List of labels</a> | optional | [] |
| <a id="core_import_library-deps"></a>deps |  -   | <a href="https://bazel.build/docs/build-ref.html#labels">List of labels</a> | optional | [] |
| <a id="core_import_library-ref"></a>ref |  -   | <a href="https://bazel.build/docs/build-ref.html#labels">Label</a> | optional | None |
| <a id="core_import_library-src"></a>src |  -   | <a href="https://bazel.build/docs/build-ref.html#labels">Label</a> | required |  |
| <a id="core_import_library-version"></a>version |  -   | String | required |  |


<a id="#core_library"></a>

## core_library

<pre>
core_library(<a href="#core_library-name">name</a>, <a href="#core_library-data">data</a>, <a href="#core_library-defines">defines</a>, <a href="#core_library-deps">deps</a>, <a href="#core_library-dotnet_context_data">dotnet_context_data</a>, <a href="#core_library-keyfile">keyfile</a>, <a href="#core_library-langversion">langversion</a>, <a href="#core_library-nowarn">nowarn</a>, <a href="#core_library-out">out</a>,
             <a href="#core_library-resources">resources</a>, <a href="#core_library-srcs">srcs</a>, <a href="#core_library-target_framework">target_framework</a>, <a href="#core_library-unsafe">unsafe</a>, <a href="#core_library-version">version</a>)
</pre>




**ATTRIBUTES**


| Name  | Description | Type | Mandatory | Default |
| :------------- | :------------- | :------------- | :------------- | :------------- |
| <a id="core_library-name"></a>name |  A unique name for this target.   | <a href="https://bazel.build/docs/build-ref.html#name">Name</a> | required |  |
| <a id="core_library-data"></a>data |  -   | <a href="https://bazel.build/docs/build-ref.html#labels">List of labels</a> | optional | [] |
| <a id="core_library-defines"></a>defines |  -   | List of strings | optional | [] |
| <a id="core_library-deps"></a>deps |  -   | <a href="https://bazel.build/docs/build-ref.html#labels">List of labels</a> | optional | [] |
| <a id="core_library-dotnet_context_data"></a>dotnet_context_data |  -   | <a href="https://bazel.build/docs/build-ref.html#labels">Label</a> | optional | @io_bazel_rules_dotnet//:core_context_data |
| <a id="core_library-keyfile"></a>keyfile |  -   | <a href="https://bazel.build/docs/build-ref.html#labels">Label</a> | optional | None |
| <a id="core_library-langversion"></a>langversion |  -   | String | optional | "latest" |
| <a id="core_library-nowarn"></a>nowarn |  -   | List of strings | optional | [] |
| <a id="core_library-out"></a>out |  -   | String | optional | "" |
| <a id="core_library-resources"></a>resources |  -   | <a href="https://bazel.build/docs/build-ref.html#labels">List of labels</a> | optional | [] |
| <a id="core_library-srcs"></a>srcs |  -   | <a href="https://bazel.build/docs/build-ref.html#labels">List of labels</a> | optional | [] |
| <a id="core_library-target_framework"></a>target_framework |  -   | String | optional | "" |
| <a id="core_library-unsafe"></a>unsafe |  -   | Boolean | optional | False |
| <a id="core_library-version"></a>version |  -   | String | optional | "" |


<a id="#core_libraryset"></a>

## core_libraryset

<pre>
core_libraryset(<a href="#core_libraryset-name">name</a>, <a href="#core_libraryset-data">data</a>, <a href="#core_libraryset-deps">deps</a>)
</pre>




**ATTRIBUTES**


| Name  | Description | Type | Mandatory | Default |
| :------------- | :------------- | :------------- | :------------- | :------------- |
| <a id="core_libraryset-name"></a>name |  A unique name for this target.   | <a href="https://bazel.build/docs/build-ref.html#name">Name</a> | required |  |
| <a id="core_libraryset-data"></a>data |  -   | <a href="https://bazel.build/docs/build-ref.html#labels">List of labels</a> | optional | [] |
| <a id="core_libraryset-deps"></a>deps |  -   | <a href="https://bazel.build/docs/build-ref.html#labels">List of labels</a> | optional | [] |


<a id="#core_nunit3_test"></a>

## core_nunit3_test

<pre>
core_nunit3_test(<a href="#core_nunit3_test-name">name</a>, <a href="#core_nunit3_test-data">data</a>, <a href="#core_nunit3_test-data_with_dirs">data_with_dirs</a>, <a href="#core_nunit3_test-defines">defines</a>, <a href="#core_nunit3_test-deps">deps</a>, <a href="#core_nunit3_test-dotnet_context_data">dotnet_context_data</a>, <a href="#core_nunit3_test-keyfile">keyfile</a>,
                 <a href="#core_nunit3_test-langversion">langversion</a>, <a href="#core_nunit3_test-nowarn">nowarn</a>, <a href="#core_nunit3_test-out">out</a>, <a href="#core_nunit3_test-resources">resources</a>, <a href="#core_nunit3_test-srcs">srcs</a>, <a href="#core_nunit3_test-testlauncher">testlauncher</a>, <a href="#core_nunit3_test-unsafe">unsafe</a>, <a href="#core_nunit3_test-version">version</a>)
</pre>




**ATTRIBUTES**


| Name  | Description | Type | Mandatory | Default |
| :------------- | :------------- | :------------- | :------------- | :------------- |
| <a id="core_nunit3_test-name"></a>name |  A unique name for this target.   | <a href="https://bazel.build/docs/build-ref.html#name">Name</a> | required |  |
| <a id="core_nunit3_test-data"></a>data |  -   | <a href="https://bazel.build/docs/build-ref.html#labels">List of labels</a> | optional | [] |
| <a id="core_nunit3_test-data_with_dirs"></a>data_with_dirs |  -   | <a href="https://bazel.build/docs/skylark/lib/dict.html">Dictionary: Label -> String</a> | optional | {"@vstest//:Microsoft.TestPlatform.TestHostRuntimeProvider.dll": "Extensions", "@NUnit3TestAdapter//:extension": ".", "@JunitXml.TestLogger//:extension": "."} |
| <a id="core_nunit3_test-defines"></a>defines |  -   | List of strings | optional | [] |
| <a id="core_nunit3_test-deps"></a>deps |  -   | <a href="https://bazel.build/docs/build-ref.html#labels">List of labels</a> | optional | [] |
| <a id="core_nunit3_test-dotnet_context_data"></a>dotnet_context_data |  -   | <a href="https://bazel.build/docs/build-ref.html#labels">Label</a> | optional | @io_bazel_rules_dotnet//:core_context_data |
| <a id="core_nunit3_test-keyfile"></a>keyfile |  -   | <a href="https://bazel.build/docs/build-ref.html#labels">Label</a> | optional | None |
| <a id="core_nunit3_test-langversion"></a>langversion |  -   | String | optional | "latest" |
| <a id="core_nunit3_test-nowarn"></a>nowarn |  -   | List of strings | optional | [] |
| <a id="core_nunit3_test-out"></a>out |  -   | String | optional | "" |
| <a id="core_nunit3_test-resources"></a>resources |  -   | <a href="https://bazel.build/docs/build-ref.html#labels">List of labels</a> | optional | [] |
| <a id="core_nunit3_test-srcs"></a>srcs |  -   | <a href="https://bazel.build/docs/build-ref.html#labels">List of labels</a> | optional | [] |
| <a id="core_nunit3_test-testlauncher"></a>testlauncher |  -   | <a href="https://bazel.build/docs/build-ref.html#labels">Label</a> | optional | @vstest//:vstest.console.exe |
| <a id="core_nunit3_test-unsafe"></a>unsafe |  -   | Boolean | optional | False |
| <a id="core_nunit3_test-version"></a>version |  -   | String | optional | "" |


<a id="#core_resource"></a>

## core_resource

<pre>
core_resource(<a href="#core_resource-name">name</a>, <a href="#core_resource-dotnet_context_data">dotnet_context_data</a>, <a href="#core_resource-identifier">identifier</a>, <a href="#core_resource-src">src</a>)
</pre>




**ATTRIBUTES**


| Name  | Description | Type | Mandatory | Default |
| :------------- | :------------- | :------------- | :------------- | :------------- |
| <a id="core_resource-name"></a>name |  A unique name for this target.   | <a href="https://bazel.build/docs/build-ref.html#name">Name</a> | required |  |
| <a id="core_resource-dotnet_context_data"></a>dotnet_context_data |  -   | <a href="https://bazel.build/docs/build-ref.html#labels">Label</a> | optional | @io_bazel_rules_dotnet//:core_context_data |
| <a id="core_resource-identifier"></a>identifier |  -   | String | optional | "" |
| <a id="core_resource-src"></a>src |  -   | <a href="https://bazel.build/docs/build-ref.html#labels">Label</a> | required |  |


<a id="#core_resource_multi"></a>

## core_resource_multi

<pre>
core_resource_multi(<a href="#core_resource_multi-name">name</a>, <a href="#core_resource_multi-dotnet_context_data">dotnet_context_data</a>, <a href="#core_resource_multi-fixedIdentifierBase">fixedIdentifierBase</a>, <a href="#core_resource_multi-identifierBase">identifierBase</a>, <a href="#core_resource_multi-srcs">srcs</a>)
</pre>




**ATTRIBUTES**


| Name  | Description | Type | Mandatory | Default |
| :------------- | :------------- | :------------- | :------------- | :------------- |
| <a id="core_resource_multi-name"></a>name |  A unique name for this target.   | <a href="https://bazel.build/docs/build-ref.html#name">Name</a> | required |  |
| <a id="core_resource_multi-dotnet_context_data"></a>dotnet_context_data |  -   | <a href="https://bazel.build/docs/build-ref.html#labels">Label</a> | optional | @io_bazel_rules_dotnet//:core_context_data |
| <a id="core_resource_multi-fixedIdentifierBase"></a>fixedIdentifierBase |  -   | String | optional | "" |
| <a id="core_resource_multi-identifierBase"></a>identifierBase |  -   | String | optional | "" |
| <a id="core_resource_multi-srcs"></a>srcs |  -   | <a href="https://bazel.build/docs/build-ref.html#labels">List of labels</a> | required |  |


<a id="#core_resx"></a>

## core_resx

<pre>
core_resx(<a href="#core_resx-name">name</a>, <a href="#core_resx-dotnet_context_data">dotnet_context_data</a>, <a href="#core_resx-identifier">identifier</a>, <a href="#core_resx-out">out</a>, <a href="#core_resx-simpleresgen">simpleresgen</a>, <a href="#core_resx-src">src</a>)
</pre>




**ATTRIBUTES**


| Name  | Description | Type | Mandatory | Default |
| :------------- | :------------- | :------------- | :------------- | :------------- |
| <a id="core_resx-name"></a>name |  A unique name for this target.   | <a href="https://bazel.build/docs/build-ref.html#name">Name</a> | required |  |
| <a id="core_resx-dotnet_context_data"></a>dotnet_context_data |  -   | <a href="https://bazel.build/docs/build-ref.html#labels">Label</a> | optional | @io_bazel_rules_dotnet//:core_context_data |
| <a id="core_resx-identifier"></a>identifier |  -   | String | optional | "" |
| <a id="core_resx-out"></a>out |  -   | String | optional | "" |
| <a id="core_resx-simpleresgen"></a>simpleresgen |  -   | <a href="https://bazel.build/docs/build-ref.html#labels">Label</a> | optional | @io_bazel_rules_dotnet//tools/simpleresgen:simpleresgen.exe |
| <a id="core_resx-src"></a>src |  -   | <a href="https://bazel.build/docs/build-ref.html#labels">Label</a> | required |  |


<a id="#core_stdlib"></a>

## core_stdlib

<pre>
core_stdlib(<a href="#core_stdlib-name">name</a>, <a href="#core_stdlib-data">data</a>, <a href="#core_stdlib-deps">deps</a>, <a href="#core_stdlib-dll">dll</a>, <a href="#core_stdlib-dotnet_context_data">dotnet_context_data</a>, <a href="#core_stdlib-ref">ref</a>, <a href="#core_stdlib-stdlib_path">stdlib_path</a>, <a href="#core_stdlib-version">version</a>)
</pre>




**ATTRIBUTES**


| Name  | Description | Type | Mandatory | Default |
| :------------- | :------------- | :------------- | :------------- | :------------- |
| <a id="core_stdlib-name"></a>name |  A unique name for this target.   | <a href="https://bazel.build/docs/build-ref.html#name">Name</a> | required |  |
| <a id="core_stdlib-data"></a>data |  -   | <a href="https://bazel.build/docs/build-ref.html#labels">List of labels</a> | optional | [] |
| <a id="core_stdlib-deps"></a>deps |  -   | <a href="https://bazel.build/docs/build-ref.html#labels">List of labels</a> | optional | [] |
| <a id="core_stdlib-dll"></a>dll |  -   | String | optional | "" |
| <a id="core_stdlib-dotnet_context_data"></a>dotnet_context_data |  -   | <a href="https://bazel.build/docs/build-ref.html#labels">Label</a> | optional | @io_bazel_rules_dotnet//:core_context_data |
| <a id="core_stdlib-ref"></a>ref |  -   | <a href="https://bazel.build/docs/build-ref.html#labels">Label</a> | optional | None |
| <a id="core_stdlib-stdlib_path"></a>stdlib_path |  -   | <a href="https://bazel.build/docs/build-ref.html#labels">Label</a> | optional | None |
| <a id="core_stdlib-version"></a>version |  -   | String | required |  |


<a id="#core_stdlib_internal"></a>

## core_stdlib_internal

<pre>
core_stdlib_internal(<a href="#core_stdlib_internal-name">name</a>, <a href="#core_stdlib_internal-data">data</a>, <a href="#core_stdlib_internal-deps">deps</a>, <a href="#core_stdlib_internal-dll">dll</a>, <a href="#core_stdlib_internal-ref">ref</a>, <a href="#core_stdlib_internal-stdlib_path">stdlib_path</a>, <a href="#core_stdlib_internal-version">version</a>)
</pre>




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


<a id="#core_xunit_test"></a>

## core_xunit_test

<pre>
core_xunit_test(<a href="#core_xunit_test-name">name</a>, <a href="#core_xunit_test-data">data</a>, <a href="#core_xunit_test-data_with_dirs">data_with_dirs</a>, <a href="#core_xunit_test-defines">defines</a>, <a href="#core_xunit_test-deps">deps</a>, <a href="#core_xunit_test-dotnet_context_data">dotnet_context_data</a>, <a href="#core_xunit_test-keyfile">keyfile</a>,
                <a href="#core_xunit_test-langversion">langversion</a>, <a href="#core_xunit_test-nowarn">nowarn</a>, <a href="#core_xunit_test-out">out</a>, <a href="#core_xunit_test-resources">resources</a>, <a href="#core_xunit_test-srcs">srcs</a>, <a href="#core_xunit_test-testlauncher">testlauncher</a>, <a href="#core_xunit_test-unsafe">unsafe</a>, <a href="#core_xunit_test-version">version</a>)
</pre>




**ATTRIBUTES**


| Name  | Description | Type | Mandatory | Default |
| :------------- | :------------- | :------------- | :------------- | :------------- |
| <a id="core_xunit_test-name"></a>name |  A unique name for this target.   | <a href="https://bazel.build/docs/build-ref.html#name">Name</a> | required |  |
| <a id="core_xunit_test-data"></a>data |  -   | <a href="https://bazel.build/docs/build-ref.html#labels">List of labels</a> | optional | [] |
| <a id="core_xunit_test-data_with_dirs"></a>data_with_dirs |  -   | <a href="https://bazel.build/docs/skylark/lib/dict.html">Dictionary: Label -> String</a> | optional | {} |
| <a id="core_xunit_test-defines"></a>defines |  -   | List of strings | optional | [] |
| <a id="core_xunit_test-deps"></a>deps |  -   | <a href="https://bazel.build/docs/build-ref.html#labels">List of labels</a> | optional | [] |
| <a id="core_xunit_test-dotnet_context_data"></a>dotnet_context_data |  -   | <a href="https://bazel.build/docs/build-ref.html#labels">Label</a> | optional | @io_bazel_rules_dotnet//:core_context_data |
| <a id="core_xunit_test-keyfile"></a>keyfile |  -   | <a href="https://bazel.build/docs/build-ref.html#labels">Label</a> | optional | None |
| <a id="core_xunit_test-langversion"></a>langversion |  -   | String | optional | "latest" |
| <a id="core_xunit_test-nowarn"></a>nowarn |  -   | List of strings | optional | [] |
| <a id="core_xunit_test-out"></a>out |  -   | String | optional | "" |
| <a id="core_xunit_test-resources"></a>resources |  -   | <a href="https://bazel.build/docs/build-ref.html#labels">List of labels</a> | optional | [] |
| <a id="core_xunit_test-srcs"></a>srcs |  -   | <a href="https://bazel.build/docs/build-ref.html#labels">List of labels</a> | optional | [] |
| <a id="core_xunit_test-testlauncher"></a>testlauncher |  -   | <a href="https://bazel.build/docs/build-ref.html#labels">Label</a> | optional | @xunit.runner.console//:netcoreapp2.1_core_tool |
| <a id="core_xunit_test-unsafe"></a>unsafe |  -   | Boolean | optional | False |
| <a id="core_xunit_test-version"></a>version |  -   | String | optional | "" |


<a id="#dotnet_nuget_new"></a>

## dotnet_nuget_new

<pre>
dotnet_nuget_new(<a href="#dotnet_nuget_new-name">name</a>, <a href="#dotnet_nuget_new-build_file">build_file</a>, <a href="#dotnet_nuget_new-build_file_content">build_file_content</a>, <a href="#dotnet_nuget_new-package">package</a>, <a href="#dotnet_nuget_new-sha256">sha256</a>, <a href="#dotnet_nuget_new-source">source</a>, <a href="#dotnet_nuget_new-version">version</a>)
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
| <a id="dotnet_nuget_new-sha256"></a>sha256 |  Sha256 digest of the downloaded package.   | String | optional | "" |
| <a id="dotnet_nuget_new-source"></a>source |  Nuget repository to download the nuget package from. The final url is in the format shape \{source\}/\{package\}/\{version\}.   | String | optional | "https://www.nuget.org/api/v2/package" |
| <a id="dotnet_nuget_new-version"></a>version |  The version of the nuget package.   | String | required |  |


<a id="#nuget_package"></a>

## nuget_package

<pre>
nuget_package(<a href="#nuget_package-name">name</a>, <a href="#nuget_package-core_deps">core_deps</a>, <a href="#nuget_package-core_files">core_files</a>, <a href="#nuget_package-core_lib">core_lib</a>, <a href="#nuget_package-core_ref">core_ref</a>, <a href="#nuget_package-core_tool">core_tool</a>, <a href="#nuget_package-mono_deps">mono_deps</a>, <a href="#nuget_package-mono_files">mono_files</a>,
              <a href="#nuget_package-mono_lib">mono_lib</a>, <a href="#nuget_package-mono_ref">mono_ref</a>, <a href="#nuget_package-mono_tool">mono_tool</a>, <a href="#nuget_package-net_deps">net_deps</a>, <a href="#nuget_package-net_files">net_files</a>, <a href="#nuget_package-net_lib">net_lib</a>, <a href="#nuget_package-net_ref">net_ref</a>, <a href="#nuget_package-net_tool">net_tool</a>, <a href="#nuget_package-package">package</a>,
              <a href="#nuget_package-sha256">sha256</a>, <a href="#nuget_package-source">source</a>, <a href="#nuget_package-version">version</a>)
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
| <a id="nuget_package-sha256"></a>sha256 |  The nuget package sha256 digest.   | String | optional | "" |
| <a id="nuget_package-source"></a>source |  The nuget base url for downloading the package. The final url is in the format {source}/{package}/{version}.   | List of strings | optional | ["https://www.nuget.org/api/v2/package"] |
| <a id="nuget_package-version"></a>version |  The nuget package version.   | String | required |  |


<a name="#core_register_sdk"></a>

## core_register_sdk

<pre>
core_register_sdk(<a href="#core_register_sdk-core_version">core_version</a>, <a href="#core_register_sdk-name">name</a>)
</pre>

Registers .NET Core.

It downloads the sdk for given version. Uses [core_download_sdk](api.md#core_download_sdk).
Args:
    core_version: The exact version of the framework. The supported frameworks are listed in [list.bzl](../dotnet/platform/list.bzl).
    name: The name under which the SDK will be registered.

**PARAMETERS**


| Name  | Description | Default Value |
| :-------------: | :-------------: | :-------------: |
| core_version |  <p align="center"> - </p>   |  <code>"v3.1.100"</code> |
| name |  <p align="center"> - </p>   |  <code>"core_sdk"</code> |


<a name="#dotnet_context"></a>

## dotnet_context

<pre>
dotnet_context(<a href="#dotnet_context-ctx">ctx</a>, <a href="#dotnet_context-attr">attr</a>)
</pre>



**PARAMETERS**


| Name  | Description | Default Value |
| :-------------: | :-------------: | :-------------: |
| ctx |  <p align="center"> - </p>   |  none |
| attr |  <p align="center"> - </p>   |  <code>None</code> |


<a name="#dotnet_register_toolchains"></a>

## dotnet_register_toolchains

<pre>
dotnet_register_toolchains()
</pre>

dotnet_register_toolchains

**PARAMETERS**



<a name="#dotnet_repositories_nugets"></a>

## dotnet_repositories_nugets

<pre>
dotnet_repositories_nugets()
</pre>

Loads nugets used by dotnet_rules itself.

**PARAMETERS**



