# Dotnet toolchains

The design and implementation is heavily based on 
[rules_go toolchains](https://github.com/bazelbuild/rules_go/blob/master/go/toolchains.rst).


## Design

The Dotnet toolchain consists of three main layers, [the sdk](#the-sdk) and [the toolchain](#the-toolchain)
and [the context](api.md#dotnetcontextinfo).

### The SDK

At the bottom there are frameworks (.NET Core). More than one version of the
framework may be used at the same time.

The frameworks are bound to ``@core_sdk_<version>``.
They can be referred to directly if needed, but in general you should always access it through the toolchain.

The [core_register_sdk](api.md#core_register_sdk) function is
responsible for downloading SDK, and adding just enough of a build file to expose the 
contents to Bazel.


### The toolchain

This a wrapper over the sdk that provides enough extras to match, target and work on a specific
platforms. It should be considered an opaque type, you only ever use it through [the context](api.md#dotnetcontextinfo).

#### Declaration

Toolchains are declared using the dotnet_toolchain macro.

Toolchains are pre-declared for all the known combinations of host and target, and the names
are a predictable
"<**host**>"
So for instance if the rules_dotnet repository is loaded with
it's default name, the following toolchain labels (along with many others) will be available

  ```python

    @io_bazel_rules_dotnet//dotnet/toolchain:core_linux_amd64
  ```
  
The toolchains are not usable until you register them.

#### Registration

Normally you would just call [dotnet_register_toolchains](api.md#dotnet_register_toolchains) from your WORKSPACE 
to register all the pre-declared toolchains, and allow normal selection logic to pick the right one.

It is fine to add more toolchains to the available set if you like. Because the normal
toolchain matching mechanism prefers the first declared match, you can also override individual
toolchains by declaring and registering toolchains with the same constraints *before* calling
[dotnet_register_toolchains](api.md#dotnet_register_toolchains).

If you wish to have more control over the toolchains you can instead just make direct
calls to [dotnet_register_toolchains](api.md#dotnet_register_toolchains) with only the toolchains you 
wish to install. You can see an
example of this in [limiting the available toolchains](https://docs.bazel.build/versions/master/toolchains.html#toolchain-resolution>).

