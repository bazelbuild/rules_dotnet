load("@io_bazel_rules_dotnet//dotnet/private:rules/nuget.bzl", "nuget_package")

def project_dotnet_repositories_nuget():
    source = ["https://www.nuget.org/api/v2/package", "https://dotnet.myget.org/F/dotnet-corefxlab/api/v2/package"]
    ### Generated by the tool
    nuget_package(
        name = "system.buffers",
        package = "system.buffers",
        version = "4.5.1",
        sha256 = "c30b3dd2c7e2f4cee4b823d692fd42118309b42ab1f5007f923d329a5b0d6b12",
        source = source,
        net_lib = {
            "net45": "lib/netstandard1.1/System.Buffers.dll",
            "net451": "lib/netstandard1.1/System.Buffers.dll",
            "net452": "lib/netstandard1.1/System.Buffers.dll",
            "net46": "lib/netstandard1.1/System.Buffers.dll",
            "net461": "lib/net461/System.Buffers.dll",
            "net462": "lib/net461/System.Buffers.dll",
            "net47": "lib/net461/System.Buffers.dll",
            "net471": "lib/net461/System.Buffers.dll",
            "net472": "lib/net461/System.Buffers.dll",
            "net48": "lib/net461/System.Buffers.dll",
            "netstandard1.1": "lib/netstandard1.1/System.Buffers.dll",
            "netstandard1.2": "lib/netstandard1.1/System.Buffers.dll",
            "netstandard1.3": "lib/netstandard1.1/System.Buffers.dll",
            "netstandard1.4": "lib/netstandard1.1/System.Buffers.dll",
            "netstandard1.5": "lib/netstandard1.1/System.Buffers.dll",
            "netstandard1.6": "lib/netstandard1.1/System.Buffers.dll",
            "netstandard2.0": "lib/netstandard2.0/System.Buffers.dll",
            "netstandard2.1": "lib/netstandard2.0/System.Buffers.dll",
        },
        net_ref = {
            "net45": "ref/net45/System.Buffers.dll",
            "net451": "ref/net45/System.Buffers.dll",
            "net452": "ref/net45/System.Buffers.dll",
            "net46": "ref/net45/System.Buffers.dll",
            "net461": "ref/net45/System.Buffers.dll",
            "net462": "ref/net45/System.Buffers.dll",
            "net47": "ref/net45/System.Buffers.dll",
            "net471": "ref/net45/System.Buffers.dll",
            "net472": "ref/net45/System.Buffers.dll",
            "net48": "ref/net45/System.Buffers.dll",
            "netstandard1.1": "ref/netstandard1.1/System.Buffers.dll",
            "netstandard1.2": "ref/netstandard1.1/System.Buffers.dll",
            "netstandard1.3": "ref/netstandard1.1/System.Buffers.dll",
            "netstandard1.4": "ref/netstandard1.1/System.Buffers.dll",
            "netstandard1.5": "ref/netstandard1.1/System.Buffers.dll",
            "netstandard1.6": "ref/netstandard1.1/System.Buffers.dll",
            "netstandard2.0": "ref/netstandard2.0/System.Buffers.dll",
            "netstandard2.1": "ref/netstandard2.0/System.Buffers.dll",
        },
        mono_lib = "lib/net461/System.Buffers.dll",
        mono_ref = "ref/net45/System.Buffers.dll",
        net_files = {
            "net45": [
               "lib/netstandard1.1/System.Buffers.dll",
               "lib/netstandard1.1/System.Buffers.xml",
            ],
            "net451": [
               "lib/netstandard1.1/System.Buffers.dll",
               "lib/netstandard1.1/System.Buffers.xml",
            ],
            "net452": [
               "lib/netstandard1.1/System.Buffers.dll",
               "lib/netstandard1.1/System.Buffers.xml",
            ],
            "net46": [
               "lib/netstandard1.1/System.Buffers.dll",
               "lib/netstandard1.1/System.Buffers.xml",
            ],
            "net461": [
               "lib/net461/System.Buffers.dll",
               "lib/net461/System.Buffers.xml",
            ],
            "net462": [
               "lib/net461/System.Buffers.dll",
               "lib/net461/System.Buffers.xml",
            ],
            "net47": [
               "lib/net461/System.Buffers.dll",
               "lib/net461/System.Buffers.xml",
            ],
            "net471": [
               "lib/net461/System.Buffers.dll",
               "lib/net461/System.Buffers.xml",
            ],
            "net472": [
               "lib/net461/System.Buffers.dll",
               "lib/net461/System.Buffers.xml",
            ],
            "net48": [
               "lib/net461/System.Buffers.dll",
               "lib/net461/System.Buffers.xml",
            ],
            "netstandard1.1": [
               "lib/netstandard1.1/System.Buffers.dll",
               "lib/netstandard1.1/System.Buffers.xml",
            ],
            "netstandard1.2": [
               "lib/netstandard1.1/System.Buffers.dll",
               "lib/netstandard1.1/System.Buffers.xml",
            ],
            "netstandard1.3": [
               "lib/netstandard1.1/System.Buffers.dll",
               "lib/netstandard1.1/System.Buffers.xml",
            ],
            "netstandard1.4": [
               "lib/netstandard1.1/System.Buffers.dll",
               "lib/netstandard1.1/System.Buffers.xml",
            ],
            "netstandard1.5": [
               "lib/netstandard1.1/System.Buffers.dll",
               "lib/netstandard1.1/System.Buffers.xml",
            ],
            "netstandard1.6": [
               "lib/netstandard1.1/System.Buffers.dll",
               "lib/netstandard1.1/System.Buffers.xml",
            ],
            "netstandard2.0": [
               "lib/netstandard2.0/System.Buffers.dll",
               "lib/netstandard2.0/System.Buffers.xml",
            ],
            "netstandard2.1": [
               "lib/netstandard2.0/System.Buffers.dll",
               "lib/netstandard2.0/System.Buffers.xml",
            ],
        },
        mono_files = [
            "lib/net461/System.Buffers.dll",
            "lib/net461/System.Buffers.xml",
        ],
    )
    nuget_package(
        name = "system.numerics.vectors",
        package = "system.numerics.vectors",
        version = "4.5.0",
        sha256 = "a9d49320581fda1b4f4be6212c68c01a22cdf228026099c20a8eabefcf90f9cf",
        source = source,
        net_lib = {
            "net45": "lib/portable-net45+win8+wp8+wpa81/System.Numerics.Vectors.dll",
            "net451": "lib/portable-net45+win8+wp8+wpa81/System.Numerics.Vectors.dll",
            "net452": "lib/portable-net45+win8+wp8+wpa81/System.Numerics.Vectors.dll",
            "net46": "lib/net46/System.Numerics.Vectors.dll",
            "net461": "lib/net46/System.Numerics.Vectors.dll",
            "net462": "lib/net46/System.Numerics.Vectors.dll",
            "net47": "lib/net46/System.Numerics.Vectors.dll",
            "net471": "lib/net46/System.Numerics.Vectors.dll",
            "net472": "lib/net46/System.Numerics.Vectors.dll",
            "net48": "lib/net46/System.Numerics.Vectors.dll",
            "netstandard1.0": "lib/netstandard1.0/System.Numerics.Vectors.dll",
            "netstandard1.1": "lib/netstandard1.0/System.Numerics.Vectors.dll",
            "netstandard1.2": "lib/netstandard1.0/System.Numerics.Vectors.dll",
            "netstandard1.3": "lib/netstandard1.0/System.Numerics.Vectors.dll",
            "netstandard1.4": "lib/netstandard1.0/System.Numerics.Vectors.dll",
            "netstandard1.5": "lib/netstandard1.0/System.Numerics.Vectors.dll",
            "netstandard1.6": "lib/netstandard1.0/System.Numerics.Vectors.dll",
            "netstandard2.0": "lib/netstandard2.0/System.Numerics.Vectors.dll",
            "netstandard2.1": "lib/netstandard2.0/System.Numerics.Vectors.dll",
        },
        net_ref = {
            "net45": "ref/net45/System.Numerics.Vectors.dll",
            "net451": "ref/net45/System.Numerics.Vectors.dll",
            "net452": "ref/net45/System.Numerics.Vectors.dll",
            "net46": "ref/net46/System.Numerics.Vectors.dll",
            "net461": "ref/net46/System.Numerics.Vectors.dll",
            "net462": "ref/net46/System.Numerics.Vectors.dll",
            "net47": "ref/net46/System.Numerics.Vectors.dll",
            "net471": "ref/net46/System.Numerics.Vectors.dll",
            "net472": "ref/net46/System.Numerics.Vectors.dll",
            "net48": "ref/net46/System.Numerics.Vectors.dll",
            "netstandard1.0": "ref/netstandard1.0/System.Numerics.Vectors.dll",
            "netstandard1.1": "ref/netstandard1.0/System.Numerics.Vectors.dll",
            "netstandard1.2": "ref/netstandard1.0/System.Numerics.Vectors.dll",
            "netstandard1.3": "ref/netstandard1.0/System.Numerics.Vectors.dll",
            "netstandard1.4": "ref/netstandard1.0/System.Numerics.Vectors.dll",
            "netstandard1.5": "ref/netstandard1.0/System.Numerics.Vectors.dll",
            "netstandard1.6": "ref/netstandard1.0/System.Numerics.Vectors.dll",
            "netstandard2.0": "ref/netstandard2.0/System.Numerics.Vectors.dll",
            "netstandard2.1": "ref/netstandard2.0/System.Numerics.Vectors.dll",
        },
        mono_lib = "lib/net46/System.Numerics.Vectors.dll",
        mono_ref = "ref/net46/System.Numerics.Vectors.dll",
        net_files = {
            "net45": [
               "lib/portable-net45+win8+wp8+wpa81/System.Numerics.Vectors.dll",
               "lib/portable-net45+win8+wp8+wpa81/System.Numerics.Vectors.xml",
            ],
            "net451": [
               "lib/portable-net45+win8+wp8+wpa81/System.Numerics.Vectors.dll",
               "lib/portable-net45+win8+wp8+wpa81/System.Numerics.Vectors.xml",
            ],
            "net452": [
               "lib/portable-net45+win8+wp8+wpa81/System.Numerics.Vectors.dll",
               "lib/portable-net45+win8+wp8+wpa81/System.Numerics.Vectors.xml",
            ],
            "net46": [
               "lib/net46/System.Numerics.Vectors.dll",
               "lib/net46/System.Numerics.Vectors.xml",
            ],
            "net461": [
               "lib/net46/System.Numerics.Vectors.dll",
               "lib/net46/System.Numerics.Vectors.xml",
            ],
            "net462": [
               "lib/net46/System.Numerics.Vectors.dll",
               "lib/net46/System.Numerics.Vectors.xml",
            ],
            "net47": [
               "lib/net46/System.Numerics.Vectors.dll",
               "lib/net46/System.Numerics.Vectors.xml",
            ],
            "net471": [
               "lib/net46/System.Numerics.Vectors.dll",
               "lib/net46/System.Numerics.Vectors.xml",
            ],
            "net472": [
               "lib/net46/System.Numerics.Vectors.dll",
               "lib/net46/System.Numerics.Vectors.xml",
            ],
            "net48": [
               "lib/net46/System.Numerics.Vectors.dll",
               "lib/net46/System.Numerics.Vectors.xml",
            ],
            "netstandard1.0": [
               "lib/netstandard1.0/System.Numerics.Vectors.dll",
               "lib/netstandard1.0/System.Numerics.Vectors.xml",
            ],
            "netstandard1.1": [
               "lib/netstandard1.0/System.Numerics.Vectors.dll",
               "lib/netstandard1.0/System.Numerics.Vectors.xml",
            ],
            "netstandard1.2": [
               "lib/netstandard1.0/System.Numerics.Vectors.dll",
               "lib/netstandard1.0/System.Numerics.Vectors.xml",
            ],
            "netstandard1.3": [
               "lib/netstandard1.0/System.Numerics.Vectors.dll",
               "lib/netstandard1.0/System.Numerics.Vectors.xml",
            ],
            "netstandard1.4": [
               "lib/netstandard1.0/System.Numerics.Vectors.dll",
               "lib/netstandard1.0/System.Numerics.Vectors.xml",
            ],
            "netstandard1.5": [
               "lib/netstandard1.0/System.Numerics.Vectors.dll",
               "lib/netstandard1.0/System.Numerics.Vectors.xml",
            ],
            "netstandard1.6": [
               "lib/netstandard1.0/System.Numerics.Vectors.dll",
               "lib/netstandard1.0/System.Numerics.Vectors.xml",
            ],
            "netstandard2.0": [
               "lib/netstandard2.0/System.Numerics.Vectors.dll",
               "lib/netstandard2.0/System.Numerics.Vectors.xml",
            ],
            "netstandard2.1": [
               "lib/netstandard2.0/System.Numerics.Vectors.dll",
               "lib/netstandard2.0/System.Numerics.Vectors.xml",
            ],
        },
        mono_files = [
            "lib/net46/System.Numerics.Vectors.dll",
            "lib/net46/System.Numerics.Vectors.xml",
        ],
    )
    nuget_package(
        name = "system.runtime.compilerservices.unsafe",
        package = "system.runtime.compilerservices.unsafe",
        version = "4.7.1",
        sha256 = "52fca80d5f0ed286371cf1b519b039e9855dbf04c611f8d8479816d4eec82b85",
        source = source,
        core_lib = {
            "netcoreapp2.0": "lib/netcoreapp2.0/System.Runtime.CompilerServices.Unsafe.dll",
            "netcoreapp2.1": "lib/netcoreapp2.0/System.Runtime.CompilerServices.Unsafe.dll",
            "netcoreapp3.0": "lib/netcoreapp2.0/System.Runtime.CompilerServices.Unsafe.dll",
            "netcoreapp3.1": "lib/netcoreapp2.0/System.Runtime.CompilerServices.Unsafe.dll",
        },
        core_ref = {
            "netcoreapp2.0": "ref/netstandard2.0/System.Runtime.CompilerServices.Unsafe.dll",
            "netcoreapp2.1": "ref/netstandard2.0/System.Runtime.CompilerServices.Unsafe.dll",
            "netcoreapp3.0": "ref/netstandard2.0/System.Runtime.CompilerServices.Unsafe.dll",
            "netcoreapp3.1": "ref/netstandard2.0/System.Runtime.CompilerServices.Unsafe.dll",
        },
        net_lib = {
            "net45": "lib/netstandard1.0/System.Runtime.CompilerServices.Unsafe.dll",
            "net451": "lib/netstandard1.0/System.Runtime.CompilerServices.Unsafe.dll",
            "net452": "lib/netstandard1.0/System.Runtime.CompilerServices.Unsafe.dll",
            "net46": "lib/netstandard1.0/System.Runtime.CompilerServices.Unsafe.dll",
            "net461": "lib/net461/System.Runtime.CompilerServices.Unsafe.dll",
            "net462": "lib/net461/System.Runtime.CompilerServices.Unsafe.dll",
            "net47": "lib/net461/System.Runtime.CompilerServices.Unsafe.dll",
            "net471": "lib/net461/System.Runtime.CompilerServices.Unsafe.dll",
            "net472": "lib/net461/System.Runtime.CompilerServices.Unsafe.dll",
            "net48": "lib/net461/System.Runtime.CompilerServices.Unsafe.dll",
            "netstandard1.0": "lib/netstandard1.0/System.Runtime.CompilerServices.Unsafe.dll",
            "netstandard1.1": "lib/netstandard1.0/System.Runtime.CompilerServices.Unsafe.dll",
            "netstandard1.2": "lib/netstandard1.0/System.Runtime.CompilerServices.Unsafe.dll",
            "netstandard1.3": "lib/netstandard1.0/System.Runtime.CompilerServices.Unsafe.dll",
            "netstandard1.4": "lib/netstandard1.0/System.Runtime.CompilerServices.Unsafe.dll",
            "netstandard1.5": "lib/netstandard1.0/System.Runtime.CompilerServices.Unsafe.dll",
            "netstandard1.6": "lib/netstandard1.0/System.Runtime.CompilerServices.Unsafe.dll",
            "netstandard2.0": "lib/netstandard2.0/System.Runtime.CompilerServices.Unsafe.dll",
            "netstandard2.1": "lib/netstandard2.0/System.Runtime.CompilerServices.Unsafe.dll",
        },
        net_ref = {
            "net45": "ref/netstandard1.0/System.Runtime.CompilerServices.Unsafe.dll",
            "net451": "ref/netstandard1.0/System.Runtime.CompilerServices.Unsafe.dll",
            "net452": "ref/netstandard1.0/System.Runtime.CompilerServices.Unsafe.dll",
            "net46": "ref/netstandard1.0/System.Runtime.CompilerServices.Unsafe.dll",
            "net461": "ref/net461/System.Runtime.CompilerServices.Unsafe.dll",
            "net462": "ref/net461/System.Runtime.CompilerServices.Unsafe.dll",
            "net47": "ref/net461/System.Runtime.CompilerServices.Unsafe.dll",
            "net471": "ref/net461/System.Runtime.CompilerServices.Unsafe.dll",
            "net472": "ref/net461/System.Runtime.CompilerServices.Unsafe.dll",
            "net48": "ref/net461/System.Runtime.CompilerServices.Unsafe.dll",
            "netstandard1.0": "ref/netstandard1.0/System.Runtime.CompilerServices.Unsafe.dll",
            "netstandard1.1": "ref/netstandard1.0/System.Runtime.CompilerServices.Unsafe.dll",
            "netstandard1.2": "ref/netstandard1.0/System.Runtime.CompilerServices.Unsafe.dll",
            "netstandard1.3": "ref/netstandard1.0/System.Runtime.CompilerServices.Unsafe.dll",
            "netstandard1.4": "ref/netstandard1.0/System.Runtime.CompilerServices.Unsafe.dll",
            "netstandard1.5": "ref/netstandard1.0/System.Runtime.CompilerServices.Unsafe.dll",
            "netstandard1.6": "ref/netstandard1.0/System.Runtime.CompilerServices.Unsafe.dll",
            "netstandard2.0": "ref/netstandard2.0/System.Runtime.CompilerServices.Unsafe.dll",
            "netstandard2.1": "ref/netstandard2.0/System.Runtime.CompilerServices.Unsafe.dll",
        },
        mono_lib = "lib/net461/System.Runtime.CompilerServices.Unsafe.dll",
        mono_ref = "ref/net461/System.Runtime.CompilerServices.Unsafe.dll",
        core_files = {
            "netcoreapp2.0": [
               "lib/netcoreapp2.0/System.Runtime.CompilerServices.Unsafe.dll",
               "lib/netcoreapp2.0/System.Runtime.CompilerServices.Unsafe.xml",
            ],
            "netcoreapp2.1": [
               "lib/netcoreapp2.0/System.Runtime.CompilerServices.Unsafe.dll",
               "lib/netcoreapp2.0/System.Runtime.CompilerServices.Unsafe.xml",
            ],
            "netcoreapp3.0": [
               "lib/netcoreapp2.0/System.Runtime.CompilerServices.Unsafe.dll",
               "lib/netcoreapp2.0/System.Runtime.CompilerServices.Unsafe.xml",
            ],
            "netcoreapp3.1": [
               "lib/netcoreapp2.0/System.Runtime.CompilerServices.Unsafe.dll",
               "lib/netcoreapp2.0/System.Runtime.CompilerServices.Unsafe.xml",
            ],
        },
        net_files = {
            "net45": [
               "lib/netstandard1.0/System.Runtime.CompilerServices.Unsafe.dll",
               "lib/netstandard1.0/System.Runtime.CompilerServices.Unsafe.xml",
            ],
            "net451": [
               "lib/netstandard1.0/System.Runtime.CompilerServices.Unsafe.dll",
               "lib/netstandard1.0/System.Runtime.CompilerServices.Unsafe.xml",
            ],
            "net452": [
               "lib/netstandard1.0/System.Runtime.CompilerServices.Unsafe.dll",
               "lib/netstandard1.0/System.Runtime.CompilerServices.Unsafe.xml",
            ],
            "net46": [
               "lib/netstandard1.0/System.Runtime.CompilerServices.Unsafe.dll",
               "lib/netstandard1.0/System.Runtime.CompilerServices.Unsafe.xml",
            ],
            "net461": [
               "lib/net461/System.Runtime.CompilerServices.Unsafe.dll",
               "lib/net461/System.Runtime.CompilerServices.Unsafe.xml",
            ],
            "net462": [
               "lib/net461/System.Runtime.CompilerServices.Unsafe.dll",
               "lib/net461/System.Runtime.CompilerServices.Unsafe.xml",
            ],
            "net47": [
               "lib/net461/System.Runtime.CompilerServices.Unsafe.dll",
               "lib/net461/System.Runtime.CompilerServices.Unsafe.xml",
            ],
            "net471": [
               "lib/net461/System.Runtime.CompilerServices.Unsafe.dll",
               "lib/net461/System.Runtime.CompilerServices.Unsafe.xml",
            ],
            "net472": [
               "lib/net461/System.Runtime.CompilerServices.Unsafe.dll",
               "lib/net461/System.Runtime.CompilerServices.Unsafe.xml",
            ],
            "net48": [
               "lib/net461/System.Runtime.CompilerServices.Unsafe.dll",
               "lib/net461/System.Runtime.CompilerServices.Unsafe.xml",
            ],
            "netstandard1.0": [
               "lib/netstandard1.0/System.Runtime.CompilerServices.Unsafe.dll",
               "lib/netstandard1.0/System.Runtime.CompilerServices.Unsafe.xml",
            ],
            "netstandard1.1": [
               "lib/netstandard1.0/System.Runtime.CompilerServices.Unsafe.dll",
               "lib/netstandard1.0/System.Runtime.CompilerServices.Unsafe.xml",
            ],
            "netstandard1.2": [
               "lib/netstandard1.0/System.Runtime.CompilerServices.Unsafe.dll",
               "lib/netstandard1.0/System.Runtime.CompilerServices.Unsafe.xml",
            ],
            "netstandard1.3": [
               "lib/netstandard1.0/System.Runtime.CompilerServices.Unsafe.dll",
               "lib/netstandard1.0/System.Runtime.CompilerServices.Unsafe.xml",
            ],
            "netstandard1.4": [
               "lib/netstandard1.0/System.Runtime.CompilerServices.Unsafe.dll",
               "lib/netstandard1.0/System.Runtime.CompilerServices.Unsafe.xml",
            ],
            "netstandard1.5": [
               "lib/netstandard1.0/System.Runtime.CompilerServices.Unsafe.dll",
               "lib/netstandard1.0/System.Runtime.CompilerServices.Unsafe.xml",
            ],
            "netstandard1.6": [
               "lib/netstandard1.0/System.Runtime.CompilerServices.Unsafe.dll",
               "lib/netstandard1.0/System.Runtime.CompilerServices.Unsafe.xml",
            ],
            "netstandard2.0": [
               "lib/netstandard2.0/System.Runtime.CompilerServices.Unsafe.dll",
               "lib/netstandard2.0/System.Runtime.CompilerServices.Unsafe.xml",
            ],
            "netstandard2.1": [
               "lib/netstandard2.0/System.Runtime.CompilerServices.Unsafe.dll",
               "lib/netstandard2.0/System.Runtime.CompilerServices.Unsafe.xml",
            ],
        },
        mono_files = [
            "lib/net461/System.Runtime.CompilerServices.Unsafe.dll",
            "lib/net461/System.Runtime.CompilerServices.Unsafe.xml",
        ],
    )
    nuget_package(
        name = "system.memory",
        package = "system.memory",
        version = "4.5.4",
        sha256 = "dec0847f33b8823e4260672d97d657411461c00ada3107ec7bbcb32a845eeb91",
        source = source,
        core_lib = {
            "netcoreapp2.0": "lib/netstandard2.0/System.Memory.dll",
        },
        net_lib = {
            "net45": "lib/netstandard1.1/System.Memory.dll",
            "net451": "lib/netstandard1.1/System.Memory.dll",
            "net452": "lib/netstandard1.1/System.Memory.dll",
            "net46": "lib/netstandard1.1/System.Memory.dll",
            "net461": "lib/net461/System.Memory.dll",
            "net462": "lib/net461/System.Memory.dll",
            "net47": "lib/net461/System.Memory.dll",
            "net471": "lib/net461/System.Memory.dll",
            "net472": "lib/net461/System.Memory.dll",
            "net48": "lib/net461/System.Memory.dll",
            "netstandard1.1": "lib/netstandard1.1/System.Memory.dll",
            "netstandard1.2": "lib/netstandard1.1/System.Memory.dll",
            "netstandard1.3": "lib/netstandard1.1/System.Memory.dll",
            "netstandard1.4": "lib/netstandard1.1/System.Memory.dll",
            "netstandard1.5": "lib/netstandard1.1/System.Memory.dll",
            "netstandard1.6": "lib/netstandard1.1/System.Memory.dll",
            "netstandard2.0": "lib/netstandard2.0/System.Memory.dll",
            "netstandard2.1": "lib/netstandard2.0/System.Memory.dll",
        },
        mono_lib = "lib/net461/System.Memory.dll",
        core_deps = {
            "netcoreapp2.0": [
               "@system.runtime.compilerservices.unsafe//:netcoreapp2.0_core",
            ],
        },
        net_deps = {
            "net45": [
               "@system.buffers//:net45_net",
               "@system.runtime.compilerservices.unsafe//:net45_net",
            ],
            "net451": [
               "@system.buffers//:net451_net",
               "@system.runtime.compilerservices.unsafe//:net451_net",
            ],
            "net452": [
               "@system.buffers//:net452_net",
               "@system.runtime.compilerservices.unsafe//:net452_net",
            ],
            "net46": [
               "@system.buffers//:net46_net",
               "@system.runtime.compilerservices.unsafe//:net46_net",
            ],
            "net461": [
               "@system.buffers//:net461_net",
               "@system.numerics.vectors//:net461_net",
               "@system.runtime.compilerservices.unsafe//:net461_net",
            ],
            "net462": [
               "@system.buffers//:net462_net",
               "@system.numerics.vectors//:net462_net",
               "@system.runtime.compilerservices.unsafe//:net462_net",
            ],
            "net47": [
               "@system.buffers//:net47_net",
               "@system.numerics.vectors//:net47_net",
               "@system.runtime.compilerservices.unsafe//:net47_net",
            ],
            "net471": [
               "@system.buffers//:net471_net",
               "@system.numerics.vectors//:net471_net",
               "@system.runtime.compilerservices.unsafe//:net471_net",
            ],
            "net472": [
               "@system.buffers//:net472_net",
               "@system.numerics.vectors//:net472_net",
               "@system.runtime.compilerservices.unsafe//:net472_net",
            ],
            "net48": [
               "@system.buffers//:net48_net",
               "@system.numerics.vectors//:net48_net",
               "@system.runtime.compilerservices.unsafe//:net48_net",
            ],
            "netstandard1.1": [
               "@system.buffers//:netstandard1.1_net",
               "@system.runtime.compilerservices.unsafe//:netstandard1.1_net",
            ],
            "netstandard1.2": [
               "@system.buffers//:netstandard1.2_net",
               "@system.runtime.compilerservices.unsafe//:netstandard1.2_net",
            ],
            "netstandard1.3": [
               "@system.buffers//:netstandard1.3_net",
               "@system.runtime.compilerservices.unsafe//:netstandard1.3_net",
            ],
            "netstandard1.4": [
               "@system.buffers//:netstandard1.4_net",
               "@system.runtime.compilerservices.unsafe//:netstandard1.4_net",
            ],
            "netstandard1.5": [
               "@system.buffers//:netstandard1.5_net",
               "@system.runtime.compilerservices.unsafe//:netstandard1.5_net",
            ],
            "netstandard1.6": [
               "@system.buffers//:netstandard1.6_net",
               "@system.runtime.compilerservices.unsafe//:netstandard1.6_net",
            ],
            "netstandard2.0": [
               "@system.buffers//:netstandard2.0_net",
               "@system.numerics.vectors//:netstandard2.0_net",
               "@system.runtime.compilerservices.unsafe//:netstandard2.0_net",
            ],
            "netstandard2.1": [
               "@system.buffers//:netstandard2.1_net",
               "@system.numerics.vectors//:netstandard2.1_net",
               "@system.runtime.compilerservices.unsafe//:netstandard2.1_net",
            ],
        },
        mono_deps = [
            "@system.buffers//:mono",
            "@system.numerics.vectors//:mono",
            "@system.runtime.compilerservices.unsafe//:mono",
        ],
        core_files = {
            "netcoreapp2.0": [
               "lib/netstandard2.0/System.Memory.dll",
               "lib/netstandard2.0/System.Memory.xml",
            ],
        },
        net_files = {
            "net45": [
               "lib/netstandard1.1/System.Memory.dll",
               "lib/netstandard1.1/System.Memory.xml",
            ],
            "net451": [
               "lib/netstandard1.1/System.Memory.dll",
               "lib/netstandard1.1/System.Memory.xml",
            ],
            "net452": [
               "lib/netstandard1.1/System.Memory.dll",
               "lib/netstandard1.1/System.Memory.xml",
            ],
            "net46": [
               "lib/netstandard1.1/System.Memory.dll",
               "lib/netstandard1.1/System.Memory.xml",
            ],
            "net461": [
               "lib/net461/System.Memory.dll",
               "lib/net461/System.Memory.xml",
            ],
            "net462": [
               "lib/net461/System.Memory.dll",
               "lib/net461/System.Memory.xml",
            ],
            "net47": [
               "lib/net461/System.Memory.dll",
               "lib/net461/System.Memory.xml",
            ],
            "net471": [
               "lib/net461/System.Memory.dll",
               "lib/net461/System.Memory.xml",
            ],
            "net472": [
               "lib/net461/System.Memory.dll",
               "lib/net461/System.Memory.xml",
            ],
            "net48": [
               "lib/net461/System.Memory.dll",
               "lib/net461/System.Memory.xml",
            ],
            "netstandard1.1": [
               "lib/netstandard1.1/System.Memory.dll",
               "lib/netstandard1.1/System.Memory.xml",
            ],
            "netstandard1.2": [
               "lib/netstandard1.1/System.Memory.dll",
               "lib/netstandard1.1/System.Memory.xml",
            ],
            "netstandard1.3": [
               "lib/netstandard1.1/System.Memory.dll",
               "lib/netstandard1.1/System.Memory.xml",
            ],
            "netstandard1.4": [
               "lib/netstandard1.1/System.Memory.dll",
               "lib/netstandard1.1/System.Memory.xml",
            ],
            "netstandard1.5": [
               "lib/netstandard1.1/System.Memory.dll",
               "lib/netstandard1.1/System.Memory.xml",
            ],
            "netstandard1.6": [
               "lib/netstandard1.1/System.Memory.dll",
               "lib/netstandard1.1/System.Memory.xml",
            ],
            "netstandard2.0": [
               "lib/netstandard2.0/System.Memory.dll",
               "lib/netstandard2.0/System.Memory.xml",
            ],
            "netstandard2.1": [
               "lib/netstandard2.0/System.Memory.dll",
               "lib/netstandard2.0/System.Memory.xml",
            ],
        },
        mono_files = [
            "lib/net461/System.Memory.dll",
            "lib/net461/System.Memory.xml",
        ],
    )
    nuget_package(
        name = "system.buffers.primitives",
        package = "system.buffers.primitives",
        version = "0.1.2-e200127-1",
        sha256 = "47a5d3971de3d2f77beeec7421bf2d7414cfd3f3fa34147b836da58e50bd7213",
        source = source,
        core_lib = {
            "netcoreapp2.0": "lib/netstandard2.0/System.Buffers.Primitives.dll",
            "netcoreapp2.1": "lib/netstandard2.0/System.Buffers.Primitives.dll",
            "netcoreapp3.0": "lib/netstandard2.0/System.Buffers.Primitives.dll",
            "netcoreapp3.1": "lib/netstandard2.0/System.Buffers.Primitives.dll",
        },
        net_lib = {
            "net461": "lib/netstandard2.0/System.Buffers.Primitives.dll",
            "net462": "lib/netstandard2.0/System.Buffers.Primitives.dll",
            "net47": "lib/netstandard2.0/System.Buffers.Primitives.dll",
            "net471": "lib/netstandard2.0/System.Buffers.Primitives.dll",
            "net472": "lib/netstandard2.0/System.Buffers.Primitives.dll",
            "net48": "lib/netstandard2.0/System.Buffers.Primitives.dll",
            "netstandard2.0": "lib/netstandard2.0/System.Buffers.Primitives.dll",
            "netstandard2.1": "lib/netstandard2.0/System.Buffers.Primitives.dll",
        },
        mono_lib = "lib/netstandard2.0/System.Buffers.Primitives.dll",
        core_deps = {
            "netcoreapp2.0": [
               "@system.memory//:netcoreapp2.0_core",
               "@system.runtime.compilerservices.unsafe//:netcoreapp2.0_core",
            ],
            "netcoreapp2.1": [
               "@system.memory//:netcoreapp2.1_core",
               "@system.runtime.compilerservices.unsafe//:netcoreapp2.1_core",
            ],
            "netcoreapp3.0": [
               "@system.memory//:netcoreapp3.0_core",
               "@system.runtime.compilerservices.unsafe//:netcoreapp3.0_core",
            ],
            "netcoreapp3.1": [
               "@system.memory//:netcoreapp3.1_core",
               "@system.runtime.compilerservices.unsafe//:netcoreapp3.1_core",
            ],
        },
        net_deps = {
            "net461": [
               "@system.memory//:net461_net",
               "@system.runtime.compilerservices.unsafe//:net461_net",
            ],
            "net462": [
               "@system.memory//:net462_net",
               "@system.runtime.compilerservices.unsafe//:net462_net",
            ],
            "net47": [
               "@system.memory//:net47_net",
               "@system.runtime.compilerservices.unsafe//:net47_net",
            ],
            "net471": [
               "@system.memory//:net471_net",
               "@system.runtime.compilerservices.unsafe//:net471_net",
            ],
            "net472": [
               "@system.memory//:net472_net",
               "@system.runtime.compilerservices.unsafe//:net472_net",
            ],
            "net48": [
               "@system.memory//:net48_net",
               "@system.runtime.compilerservices.unsafe//:net48_net",
            ],
            "netstandard2.0": [
               "@system.memory//:netstandard2.0_net",
               "@system.runtime.compilerservices.unsafe//:netstandard2.0_net",
            ],
            "netstandard2.1": [
               "@system.memory//:netstandard2.1_net",
               "@system.runtime.compilerservices.unsafe//:netstandard2.1_net",
            ],
        },
        mono_deps = [
            "@system.memory//:mono",
            "@system.runtime.compilerservices.unsafe//:mono",
        ],
        core_files = {
            "netcoreapp2.0": [
               "lib/netstandard2.0/System.Buffers.Primitives.dll",
            ],
            "netcoreapp2.1": [
               "lib/netstandard2.0/System.Buffers.Primitives.dll",
            ],
            "netcoreapp3.0": [
               "lib/netstandard2.0/System.Buffers.Primitives.dll",
            ],
            "netcoreapp3.1": [
               "lib/netstandard2.0/System.Buffers.Primitives.dll",
            ],
        },
        net_files = {
            "net461": [
               "lib/netstandard2.0/System.Buffers.Primitives.dll",
            ],
            "net462": [
               "lib/netstandard2.0/System.Buffers.Primitives.dll",
            ],
            "net47": [
               "lib/netstandard2.0/System.Buffers.Primitives.dll",
            ],
            "net471": [
               "lib/netstandard2.0/System.Buffers.Primitives.dll",
            ],
            "net472": [
               "lib/netstandard2.0/System.Buffers.Primitives.dll",
            ],
            "net48": [
               "lib/netstandard2.0/System.Buffers.Primitives.dll",
            ],
            "netstandard2.0": [
               "lib/netstandard2.0/System.Buffers.Primitives.dll",
            ],
            "netstandard2.1": [
               "lib/netstandard2.0/System.Buffers.Primitives.dll",
            ],
        },
        mono_files = [
            "lib/netstandard2.0/System.Buffers.Primitives.dll",
        ],
    )
    ### End of generated by the tool

