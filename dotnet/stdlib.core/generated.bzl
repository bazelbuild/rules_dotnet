load("@io_bazel_rules_dotnet//dotnet/private:rules/stdlib.bzl", "core_stdlib_internal")
load("@io_bazel_rules_dotnet//dotnet/private:rules/libraryset.bzl", "core_libraryset")

def define_stdlib(context_data):
    core_libraryset(
        name = "libraryset",
        deps = [
            ":microsoft.csharp.dll",
            ":microsoft.visualbasic.core.dll",
            ":microsoft.visualbasic.dll",
            ":microsoft.win32.primitives.dll",
            ":mscorlib.dll",
            ":netstandard.dll",
            ":system.appcontext.dll",
            ":system.buffers.dll",
            ":system.collections.concurrent.dll",
            ":system.collections.dll",
            ":system.collections.immutable.dll",
            ":system.collections.nongeneric.dll",
            ":system.collections.specialized.dll",
            ":system.componentmodel.annotations.dll",
            ":system.componentmodel.dataannotations.dll",
            ":system.componentmodel.dll",
            ":system.componentmodel.eventbasedasync.dll",
            ":system.componentmodel.primitives.dll",
            ":system.componentmodel.typeconverter.dll",
            ":system.configuration.dll",
            ":system.console.dll",
            ":system.core.dll",
            ":system.data.common.dll",
            ":system.data.datasetextensions.dll",
            ":system.data.dll",
            ":system.diagnostics.contracts.dll",
            ":system.diagnostics.debug.dll",
            ":system.diagnostics.diagnosticsource.dll",
            ":system.diagnostics.fileversioninfo.dll",
            ":system.diagnostics.process.dll",
            ":system.diagnostics.stacktrace.dll",
            ":system.diagnostics.textwritertracelistener.dll",
            ":system.diagnostics.tools.dll",
            ":system.diagnostics.tracesource.dll",
            ":system.diagnostics.tracing.dll",
            ":system.dll",
            ":system.drawing.dll",
            ":system.drawing.primitives.dll",
            ":system.dynamic.runtime.dll",
            ":system.globalization.calendars.dll",
            ":system.globalization.dll",
            ":system.globalization.extensions.dll",
            ":system.io.compression.brotli.dll",
            ":system.io.compression.dll",
            ":system.io.compression.filesystem.dll",
            ":system.io.compression.zipfile.dll",
            ":system.io.dll",
            ":system.io.filesystem.dll",
            ":system.io.filesystem.driveinfo.dll",
            ":system.io.filesystem.primitives.dll",
            ":system.io.filesystem.watcher.dll",
            ":system.io.isolatedstorage.dll",
            ":system.io.memorymappedfiles.dll",
            ":system.io.pipes.dll",
            ":system.io.unmanagedmemorystream.dll",
            ":system.linq.dll",
            ":system.linq.expressions.dll",
            ":system.linq.parallel.dll",
            ":system.linq.queryable.dll",
            ":system.memory.dll",
            ":system.net.dll",
            ":system.net.http.dll",
            ":system.net.httplistener.dll",
            ":system.net.mail.dll",
            ":system.net.nameresolution.dll",
            ":system.net.networkinformation.dll",
            ":system.net.ping.dll",
            ":system.net.primitives.dll",
            ":system.net.requests.dll",
            ":system.net.security.dll",
            ":system.net.servicepoint.dll",
            ":system.net.sockets.dll",
            ":system.net.webclient.dll",
            ":system.net.webheadercollection.dll",
            ":system.net.webproxy.dll",
            ":system.net.websockets.client.dll",
            ":system.net.websockets.dll",
            ":system.numerics.dll",
            ":system.numerics.vectors.dll",
            ":system.objectmodel.dll",
            ":system.reflection.dispatchproxy.dll",
            ":system.reflection.dll",
            ":system.reflection.emit.dll",
            ":system.reflection.emit.ilgeneration.dll",
            ":system.reflection.emit.lightweight.dll",
            ":system.reflection.extensions.dll",
            ":system.reflection.metadata.dll",
            ":system.reflection.primitives.dll",
            ":system.reflection.typeextensions.dll",
            ":system.resources.reader.dll",
            ":system.resources.resourcemanager.dll",
            ":system.resources.writer.dll",
            ":system.runtime.compilerservices.unsafe.dll",
            ":system.runtime.compilerservices.visualc.dll",
            ":system.runtime.dll",
            ":system.runtime.extensions.dll",
            ":system.runtime.handles.dll",
            ":system.runtime.interopservices.dll",
            ":system.runtime.interopservices.runtimeinformation.dll",
            ":system.runtime.interopservices.windowsruntime.dll",
            ":system.runtime.intrinsics.dll",
            ":system.runtime.loader.dll",
            ":system.runtime.numerics.dll",
            ":system.runtime.serialization.dll",
            ":system.runtime.serialization.formatters.dll",
            ":system.runtime.serialization.json.dll",
            ":system.runtime.serialization.primitives.dll",
            ":system.runtime.serialization.xml.dll",
            ":system.security.claims.dll",
            ":system.security.cryptography.algorithms.dll",
            ":system.security.cryptography.csp.dll",
            ":system.security.cryptography.encoding.dll",
            ":system.security.cryptography.primitives.dll",
            ":system.security.cryptography.x509certificates.dll",
            ":system.security.dll",
            ":system.security.principal.dll",
            ":system.security.securestring.dll",
            ":system.servicemodel.web.dll",
            ":system.serviceprocess.dll",
            ":system.text.encoding.codepages.dll",
            ":system.text.encoding.dll",
            ":system.text.encoding.extensions.dll",
            ":system.text.encodings.web.dll",
            ":system.text.json.dll",
            ":system.text.regularexpressions.dll",
            ":system.threading.channels.dll",
            ":system.threading.dll",
            ":system.threading.overlapped.dll",
            ":system.threading.tasks.dataflow.dll",
            ":system.threading.tasks.dll",
            ":system.threading.tasks.extensions.dll",
            ":system.threading.tasks.parallel.dll",
            ":system.threading.thread.dll",
            ":system.threading.threadpool.dll",
            ":system.threading.timer.dll",
            ":system.transactions.dll",
            ":system.transactions.local.dll",
            ":system.valuetuple.dll",
            ":system.web.dll",
            ":system.web.httputility.dll",
            ":system.windows.dll",
            ":system.xml.dll",
            ":system.xml.linq.dll",
            ":system.xml.readerwriter.dll",
            ":system.xml.serialization.dll",
            ":system.xml.xdocument.dll",
            ":system.xml.xmldocument.dll",
            ":system.xml.xmlserializer.dll",
            ":system.xml.xpath.dll",
            ":system.xml.xpath.xdocument.dll",
            ":windowsbase.dll",
        ],
    )
    core_stdlib_internal(
        name = "microsoft.csharp.dll",
        version = "4.0.0.0",
        ref = "@core_sdk//:core/packs/Microsoft.NETCore.App.Ref/3.1.0/ref/netcoreapp3.1/Microsoft.CSharp.dll",
        stdlib_path = "@core_sdk//:core/shared/Microsoft.NETCore.App/3.1.0/Microsoft.CSharp.dll",
        deps = [
            ":netstandard.dll",
        ],
    )
    core_stdlib_internal(
        name = "microsoft.visualbasic.core.dll",
        version = "10.0.5.0",
        ref = "@core_sdk//:core/packs/Microsoft.NETCore.App.Ref/3.1.0/ref/netcoreapp3.1/Microsoft.VisualBasic.Core.dll",
        stdlib_path = "@core_sdk//:core/shared/Microsoft.NETCore.App/3.1.0/Microsoft.VisualBasic.Core.dll",
        deps = [
            ":system.runtime.dll",
            ":system.runtime.interopservices.dll",
            ":system.io.filesystem.driveinfo.dll",
            ":system.io.filesystem.dll",
            ":system.runtime.extensions.dll",
            ":system.diagnostics.debug.dll",
        ],
    )
    core_stdlib_internal(
        name = "microsoft.visualbasic.dll",
        version = "10.0.0.0",
        ref = "@core_sdk//:core/packs/Microsoft.NETCore.App.Ref/3.1.0/ref/netcoreapp3.1/Microsoft.VisualBasic.dll",
        stdlib_path = "@core_sdk//:core/shared/Microsoft.NETCore.App/3.1.0/Microsoft.VisualBasic.dll",
        deps = [
            ":system.runtime.dll",
            ":microsoft.visualbasic.core.dll",
        ],
    )
    core_stdlib_internal(
        name = "microsoft.win32.primitives.dll",
        version = "4.1.2.0",
        ref = "@core_sdk//:core/packs/Microsoft.NETCore.App.Ref/3.1.0/ref/netcoreapp3.1/Microsoft.Win32.Primitives.dll",
        stdlib_path = "@core_sdk//:core/shared/Microsoft.NETCore.App/3.1.0/Microsoft.Win32.Primitives.dll",
        deps = [
            ":system.runtime.dll",
        ],
    )
    core_stdlib_internal(
        name = "mscorlib.dll",
        version = "4.0.0.0",
        ref = "@core_sdk//:core/packs/Microsoft.NETCore.App.Ref/3.1.0/ref/netcoreapp3.1/mscorlib.dll",
        stdlib_path = "@core_sdk//:core/shared/Microsoft.NETCore.App/3.1.0/mscorlib.dll",
        deps = [
            ":system.runtime.dll",
            ":system.runtime.extensions.dll",
            ":system.collections.dll",
            ":system.collections.nongeneric.dll",
            ":system.collections.concurrent.dll",
            ":system.objectmodel.dll",
            ":system.console.dll",
            ":system.runtime.interopservices.dll",
            ":system.diagnostics.tools.dll",
            ":system.diagnostics.contracts.dll",
            ":system.diagnostics.debug.dll",
            ":system.diagnostics.stacktrace.dll",
            ":system.diagnostics.tracing.dll",
            ":system.io.filesystem.dll",
            ":system.io.filesystem.driveinfo.dll",
            ":system.io.isolatedstorage.dll",
            ":system.componentmodel.dll",
            ":system.threading.thread.dll",
            ":system.threading.tasks.dll",
            ":system.reflection.emit.dll",
            ":system.reflection.emit.ilgeneration.dll",
            ":system.reflection.emit.lightweight.dll",
            ":system.reflection.primitives.dll",
            ":system.resources.resourcemanager.dll",
            ":system.resources.writer.dll",
            ":system.runtime.compilerservices.visualc.dll",
            ":system.runtime.interopservices.runtimeinformation.dll",
            ":system.runtime.interopservices.windowsruntime.dll",
            ":system.runtime.serialization.formatters.dll",
            ":system.security.claims.dll",
            ":system.security.cryptography.algorithms.dll",
            ":system.security.cryptography.primitives.dll",
            ":system.security.cryptography.csp.dll",
            ":system.security.cryptography.encoding.dll",
            ":system.security.cryptography.x509certificates.dll",
            ":system.security.principal.dll",
            ":system.text.encoding.extensions.dll",
            ":system.threading.dll",
            ":system.threading.overlapped.dll",
            ":system.threading.threadpool.dll",
            ":system.threading.tasks.parallel.dll",
            ":system.threading.timer.dll",
        ],
    )
    core_stdlib_internal(
        name = "netstandard.dll",
        version = "2.1.0.0",
        ref = "@core_sdk//:core/packs/Microsoft.NETCore.App.Ref/3.1.0/ref/netcoreapp3.1/netstandard.dll",
        stdlib_path = "@core_sdk//:core/shared/Microsoft.NETCore.App/3.1.0/netstandard.dll",
        deps = [
            ":system.runtime.dll",
            ":system.io.memorymappedfiles.dll",
            ":system.io.pipes.dll",
            ":system.diagnostics.process.dll",
            ":system.security.cryptography.x509certificates.dll",
            ":system.runtime.extensions.dll",
            ":system.memory.dll",
            ":system.buffers.dll",
            ":system.diagnostics.tools.dll",
            ":system.collections.dll",
            ":system.collections.nongeneric.dll",
            ":system.collections.concurrent.dll",
            ":system.objectmodel.dll",
            ":system.collections.specialized.dll",
            ":system.componentmodel.typeconverter.dll",
            ":system.componentmodel.eventbasedasync.dll",
            ":system.componentmodel.primitives.dll",
            ":system.componentmodel.dll",
            ":microsoft.win32.primitives.dll",
            ":system.console.dll",
            ":system.data.common.dll",
            ":system.runtime.interopservices.dll",
            ":system.diagnostics.tracesource.dll",
            ":system.diagnostics.contracts.dll",
            ":system.diagnostics.debug.dll",
            ":system.diagnostics.textwritertracelistener.dll",
            ":system.diagnostics.fileversioninfo.dll",
            ":system.diagnostics.stacktrace.dll",
            ":system.diagnostics.tracing.dll",
            ":system.drawing.primitives.dll",
            ":system.linq.expressions.dll",
            ":system.io.compression.brotli.dll",
            ":system.io.compression.dll",
            ":system.io.compression.zipfile.dll",
            ":system.io.filesystem.dll",
            ":system.io.filesystem.driveinfo.dll",
            ":system.io.filesystem.watcher.dll",
            ":system.io.isolatedstorage.dll",
            ":system.linq.dll",
            ":system.linq.queryable.dll",
            ":system.linq.parallel.dll",
            ":system.threading.thread.dll",
            ":system.net.requests.dll",
            ":system.net.primitives.dll",
            ":system.net.httplistener.dll",
            ":system.net.servicepoint.dll",
            ":system.net.nameresolution.dll",
            ":system.net.webclient.dll",
            ":system.net.http.dll",
            ":system.net.webheadercollection.dll",
            ":system.net.webproxy.dll",
            ":system.net.mail.dll",
            ":system.net.networkinformation.dll",
            ":system.net.ping.dll",
            ":system.net.security.dll",
            ":system.net.sockets.dll",
            ":system.net.websockets.client.dll",
            ":system.net.websockets.dll",
            ":system.runtime.numerics.dll",
            ":system.numerics.vectors.dll",
            ":system.threading.tasks.dll",
            ":system.reflection.dispatchproxy.dll",
            ":system.reflection.emit.dll",
            ":system.reflection.emit.ilgeneration.dll",
            ":system.reflection.emit.lightweight.dll",
            ":system.reflection.primitives.dll",
            ":system.resources.resourcemanager.dll",
            ":system.resources.writer.dll",
            ":system.runtime.compilerservices.visualc.dll",
            ":system.runtime.interopservices.runtimeinformation.dll",
            ":system.runtime.serialization.primitives.dll",
            ":system.runtime.serialization.xml.dll",
            ":system.runtime.serialization.json.dll",
            ":system.runtime.serialization.formatters.dll",
            ":system.security.claims.dll",
            ":system.security.cryptography.algorithms.dll",
            ":system.security.cryptography.csp.dll",
            ":system.security.cryptography.encoding.dll",
            ":system.security.cryptography.primitives.dll",
            ":system.security.principal.dll",
            ":system.text.encoding.extensions.dll",
            ":system.text.regularexpressions.dll",
            ":system.threading.dll",
            ":system.threading.overlapped.dll",
            ":system.threading.threadpool.dll",
            ":system.threading.tasks.parallel.dll",
            ":system.threading.timer.dll",
            ":system.transactions.local.dll",
            ":system.web.httputility.dll",
            ":system.xml.readerwriter.dll",
            ":system.xml.xdocument.dll",
            ":system.xml.xmlserializer.dll",
            ":system.xml.xpath.xdocument.dll",
            ":system.xml.xpath.dll",
        ],
    )
    core_stdlib_internal(
        name = "system.appcontext.dll",
        version = "4.2.2.0",
        ref = "@core_sdk//:core/packs/Microsoft.NETCore.App.Ref/3.1.0/ref/netcoreapp3.1/System.AppContext.dll",
        stdlib_path = "@core_sdk//:core/shared/Microsoft.NETCore.App/3.1.0/System.AppContext.dll",
        deps = [
            ":system.runtime.dll",
        ],
    )
    core_stdlib_internal(
        name = "system.buffers.dll",
        version = "4.0.2.0",
        ref = "@core_sdk//:core/packs/Microsoft.NETCore.App.Ref/3.1.0/ref/netcoreapp3.1/System.Buffers.dll",
        stdlib_path = "@core_sdk//:core/shared/Microsoft.NETCore.App/3.1.0/System.Buffers.dll",
        deps = [
            ":system.runtime.dll",
        ],
    )
    core_stdlib_internal(
        name = "system.collections.concurrent.dll",
        version = "4.0.15.0",
        ref = "@core_sdk//:core/packs/Microsoft.NETCore.App.Ref/3.1.0/ref/netcoreapp3.1/System.Collections.Concurrent.dll",
        stdlib_path = "@core_sdk//:core/shared/Microsoft.NETCore.App/3.1.0/System.Collections.Concurrent.dll",
        deps = [
            ":system.runtime.dll",
        ],
    )
    core_stdlib_internal(
        name = "system.collections.dll",
        version = "4.1.2.0",
        ref = "@core_sdk//:core/packs/Microsoft.NETCore.App.Ref/3.1.0/ref/netcoreapp3.1/System.Collections.dll",
        stdlib_path = "@core_sdk//:core/shared/Microsoft.NETCore.App/3.1.0/System.Collections.dll",
        deps = [
            ":system.runtime.dll",
        ],
    )
    core_stdlib_internal(
        name = "system.collections.immutable.dll",
        version = "1.2.5.0",
        ref = "@core_sdk//:core/packs/Microsoft.NETCore.App.Ref/3.1.0/ref/netcoreapp3.1/System.Collections.Immutable.dll",
        stdlib_path = "@core_sdk//:core/shared/Microsoft.NETCore.App/3.1.0/System.Collections.Immutable.dll",
        deps = [
            ":system.runtime.dll",
            ":system.runtime.interopservices.dll",
            ":system.collections.dll",
        ],
    )
    core_stdlib_internal(
        name = "system.collections.nongeneric.dll",
        version = "4.1.2.0",
        ref = "@core_sdk//:core/packs/Microsoft.NETCore.App.Ref/3.1.0/ref/netcoreapp3.1/System.Collections.NonGeneric.dll",
        stdlib_path = "@core_sdk//:core/shared/Microsoft.NETCore.App/3.1.0/System.Collections.NonGeneric.dll",
        deps = [
            ":system.runtime.dll",
            ":system.runtime.extensions.dll",
        ],
    )
    core_stdlib_internal(
        name = "system.collections.specialized.dll",
        version = "4.1.2.0",
        ref = "@core_sdk//:core/packs/Microsoft.NETCore.App.Ref/3.1.0/ref/netcoreapp3.1/System.Collections.Specialized.dll",
        stdlib_path = "@core_sdk//:core/shared/Microsoft.NETCore.App/3.1.0/System.Collections.Specialized.dll",
        deps = [
            ":system.runtime.dll",
            ":system.runtime.extensions.dll",
        ],
    )
    core_stdlib_internal(
        name = "system.componentmodel.annotations.dll",
        version = "4.3.1.0",
        ref = "@core_sdk//:core/packs/Microsoft.NETCore.App.Ref/3.1.0/ref/netcoreapp3.1/System.ComponentModel.Annotations.dll",
        stdlib_path = "@core_sdk//:core/shared/Microsoft.NETCore.App/3.1.0/System.ComponentModel.Annotations.dll",
        deps = [
            ":netstandard.dll",
        ],
    )
    core_stdlib_internal(
        name = "system.componentmodel.dataannotations.dll",
        version = "4.0.0.0",
        ref = "@core_sdk//:core/packs/Microsoft.NETCore.App.Ref/3.1.0/ref/netcoreapp3.1/System.ComponentModel.DataAnnotations.dll",
        stdlib_path = "@core_sdk//:core/shared/Microsoft.NETCore.App/3.1.0/System.ComponentModel.DataAnnotations.dll",
        deps = [
            ":system.runtime.dll",
            ":system.componentmodel.annotations.dll",
        ],
    )
    core_stdlib_internal(
        name = "system.componentmodel.dll",
        version = "4.0.4.0",
        ref = "@core_sdk//:core/packs/Microsoft.NETCore.App.Ref/3.1.0/ref/netcoreapp3.1/System.ComponentModel.dll",
        stdlib_path = "@core_sdk//:core/shared/Microsoft.NETCore.App/3.1.0/System.ComponentModel.dll",
        deps = [
            ":system.runtime.dll",
        ],
    )
    core_stdlib_internal(
        name = "system.componentmodel.eventbasedasync.dll",
        version = "4.1.2.0",
        ref = "@core_sdk//:core/packs/Microsoft.NETCore.App.Ref/3.1.0/ref/netcoreapp3.1/System.ComponentModel.EventBasedAsync.dll",
        stdlib_path = "@core_sdk//:core/shared/Microsoft.NETCore.App/3.1.0/System.ComponentModel.EventBasedAsync.dll",
        deps = [
            ":system.runtime.dll",
            ":system.threading.dll",
            ":system.componentmodel.primitives.dll",
            ":system.componentmodel.dll",
        ],
    )
    core_stdlib_internal(
        name = "system.componentmodel.primitives.dll",
        version = "4.2.2.0",
        ref = "@core_sdk//:core/packs/Microsoft.NETCore.App.Ref/3.1.0/ref/netcoreapp3.1/System.ComponentModel.Primitives.dll",
        stdlib_path = "@core_sdk//:core/shared/Microsoft.NETCore.App/3.1.0/System.ComponentModel.Primitives.dll",
        deps = [
            ":system.runtime.dll",
            ":system.collections.nongeneric.dll",
            ":system.componentmodel.dll",
        ],
    )
    core_stdlib_internal(
        name = "system.componentmodel.typeconverter.dll",
        version = "4.2.2.0",
        ref = "@core_sdk//:core/packs/Microsoft.NETCore.App.Ref/3.1.0/ref/netcoreapp3.1/System.ComponentModel.TypeConverter.dll",
        stdlib_path = "@core_sdk//:core/shared/Microsoft.NETCore.App/3.1.0/System.ComponentModel.TypeConverter.dll",
        deps = [
            ":system.runtime.dll",
            ":system.componentmodel.primitives.dll",
            ":system.componentmodel.dll",
            ":system.resources.resourcemanager.dll",
            ":system.objectmodel.dll",
            ":system.runtime.extensions.dll",
            ":system.collections.nongeneric.dll",
            ":system.resources.writer.dll",
        ],
    )
    core_stdlib_internal(
        name = "system.configuration.dll",
        version = "4.0.0.0",
        ref = "@core_sdk//:core/packs/Microsoft.NETCore.App.Ref/3.1.0/ref/netcoreapp3.1/System.Configuration.dll",
        stdlib_path = "@core_sdk//:core/shared/Microsoft.NETCore.App/3.1.0/System.Configuration.dll",
        deps = [
            ":system.runtime.dll",
        ],
    )
    core_stdlib_internal(
        name = "system.console.dll",
        version = "4.1.2.0",
        ref = "@core_sdk//:core/packs/Microsoft.NETCore.App.Ref/3.1.0/ref/netcoreapp3.1/System.Console.dll",
        stdlib_path = "@core_sdk//:core/shared/Microsoft.NETCore.App/3.1.0/System.Console.dll",
        deps = [
            ":system.runtime.dll",
            ":system.runtime.extensions.dll",
        ],
    )
    core_stdlib_internal(
        name = "system.core.dll",
        version = "4.0.0.0",
        ref = "@core_sdk//:core/packs/Microsoft.NETCore.App.Ref/3.1.0/ref/netcoreapp3.1/System.Core.dll",
        stdlib_path = "@core_sdk//:core/shared/Microsoft.NETCore.App/3.1.0/System.Core.dll",
        deps = [
            ":system.runtime.dll",
            ":system.io.memorymappedfiles.dll",
            ":system.io.pipes.dll",
            ":system.collections.dll",
            ":system.linq.expressions.dll",
            ":system.linq.dll",
            ":system.linq.queryable.dll",
            ":system.linq.parallel.dll",
            ":system.runtime.interopservices.dll",
            ":system.security.cryptography.algorithms.dll",
            ":system.security.cryptography.csp.dll",
            ":system.security.cryptography.x509certificates.dll",
            ":system.threading.dll",
            ":system.threading.tasks.dll",
        ],
    )
    core_stdlib_internal(
        name = "system.data.common.dll",
        version = "4.2.2.0",
        ref = "@core_sdk//:core/packs/Microsoft.NETCore.App.Ref/3.1.0/ref/netcoreapp3.1/System.Data.Common.dll",
        stdlib_path = "@core_sdk//:core/shared/Microsoft.NETCore.App/3.1.0/System.Data.Common.dll",
        deps = [
            ":system.runtime.dll",
            ":system.xml.readerwriter.dll",
            ":system.runtime.extensions.dll",
            ":system.componentmodel.typeconverter.dll",
            ":system.objectmodel.dll",
            ":system.componentmodel.primitives.dll",
            ":system.componentmodel.dll",
            ":system.transactions.local.dll",
        ],
    )
    core_stdlib_internal(
        name = "system.data.datasetextensions.dll",
        version = "4.0.1.0",
        ref = "@core_sdk//:core/packs/Microsoft.NETCore.App.Ref/3.1.0/ref/netcoreapp3.1/System.Data.DataSetExtensions.dll",
        stdlib_path = "@core_sdk//:core/shared/Microsoft.NETCore.App/3.1.0/System.Data.DataSetExtensions.dll",
        deps = [
            ":system.runtime.dll",
            ":system.data.common.dll",
        ],
    )
    core_stdlib_internal(
        name = "system.data.dll",
        version = "4.0.0.0",
        ref = "@core_sdk//:core/packs/Microsoft.NETCore.App.Ref/3.1.0/ref/netcoreapp3.1/System.Data.dll",
        stdlib_path = "@core_sdk//:core/shared/Microsoft.NETCore.App/3.1.0/System.Data.dll",
        deps = [
            ":system.runtime.dll",
            ":system.data.common.dll",
        ],
    )
    core_stdlib_internal(
        name = "system.diagnostics.contracts.dll",
        version = "4.0.4.0",
        ref = "@core_sdk//:core/packs/Microsoft.NETCore.App.Ref/3.1.0/ref/netcoreapp3.1/System.Diagnostics.Contracts.dll",
        stdlib_path = "@core_sdk//:core/shared/Microsoft.NETCore.App/3.1.0/System.Diagnostics.Contracts.dll",
        deps = [
            ":system.runtime.dll",
        ],
    )
    core_stdlib_internal(
        name = "system.diagnostics.debug.dll",
        version = "4.1.2.0",
        ref = "@core_sdk//:core/packs/Microsoft.NETCore.App.Ref/3.1.0/ref/netcoreapp3.1/System.Diagnostics.Debug.dll",
        stdlib_path = "@core_sdk//:core/shared/Microsoft.NETCore.App/3.1.0/System.Diagnostics.Debug.dll",
        deps = [
            ":system.runtime.dll",
        ],
    )
    core_stdlib_internal(
        name = "system.diagnostics.diagnosticsource.dll",
        version = "4.0.5.0",
        ref = "@core_sdk//:core/packs/Microsoft.NETCore.App.Ref/3.1.0/ref/netcoreapp3.1/System.Diagnostics.DiagnosticSource.dll",
        stdlib_path = "@core_sdk//:core/shared/Microsoft.NETCore.App/3.1.0/System.Diagnostics.DiagnosticSource.dll",
        deps = [
            ":netstandard.dll",
            ":system.memory.dll",
        ],
    )
    core_stdlib_internal(
        name = "system.diagnostics.fileversioninfo.dll",
        version = "4.0.4.0",
        ref = "@core_sdk//:core/packs/Microsoft.NETCore.App.Ref/3.1.0/ref/netcoreapp3.1/System.Diagnostics.FileVersionInfo.dll",
        stdlib_path = "@core_sdk//:core/shared/Microsoft.NETCore.App/3.1.0/System.Diagnostics.FileVersionInfo.dll",
        deps = [
            ":system.runtime.dll",
        ],
    )
    core_stdlib_internal(
        name = "system.diagnostics.process.dll",
        version = "4.2.2.0",
        ref = "@core_sdk//:core/packs/Microsoft.NETCore.App.Ref/3.1.0/ref/netcoreapp3.1/System.Diagnostics.Process.dll",
        stdlib_path = "@core_sdk//:core/shared/Microsoft.NETCore.App/3.1.0/System.Diagnostics.Process.dll",
        deps = [
            ":system.runtime.dll",
            ":system.runtime.interopservices.dll",
            ":system.componentmodel.primitives.dll",
            ":system.runtime.extensions.dll",
            ":system.diagnostics.fileversioninfo.dll",
            ":system.collections.nongeneric.dll",
            ":system.collections.specialized.dll",
        ],
    )
    core_stdlib_internal(
        name = "system.diagnostics.stacktrace.dll",
        version = "4.1.2.0",
        ref = "@core_sdk//:core/packs/Microsoft.NETCore.App.Ref/3.1.0/ref/netcoreapp3.1/System.Diagnostics.StackTrace.dll",
        stdlib_path = "@core_sdk//:core/shared/Microsoft.NETCore.App/3.1.0/System.Diagnostics.StackTrace.dll",
        deps = [
            ":system.runtime.dll",
        ],
    )
    core_stdlib_internal(
        name = "system.diagnostics.textwritertracelistener.dll",
        version = "4.1.2.0",
        ref = "@core_sdk//:core/packs/Microsoft.NETCore.App.Ref/3.1.0/ref/netcoreapp3.1/System.Diagnostics.TextWriterTraceListener.dll",
        stdlib_path = "@core_sdk//:core/shared/Microsoft.NETCore.App/3.1.0/System.Diagnostics.TextWriterTraceListener.dll",
        deps = [
            ":system.runtime.dll",
            ":system.runtime.extensions.dll",
            ":system.diagnostics.tracesource.dll",
        ],
    )
    core_stdlib_internal(
        name = "system.diagnostics.tools.dll",
        version = "4.1.2.0",
        ref = "@core_sdk//:core/packs/Microsoft.NETCore.App.Ref/3.1.0/ref/netcoreapp3.1/System.Diagnostics.Tools.dll",
        stdlib_path = "@core_sdk//:core/shared/Microsoft.NETCore.App/3.1.0/System.Diagnostics.Tools.dll",
        deps = [
            ":system.runtime.dll",
        ],
    )
    core_stdlib_internal(
        name = "system.diagnostics.tracesource.dll",
        version = "4.1.2.0",
        ref = "@core_sdk//:core/packs/Microsoft.NETCore.App.Ref/3.1.0/ref/netcoreapp3.1/System.Diagnostics.TraceSource.dll",
        stdlib_path = "@core_sdk//:core/shared/Microsoft.NETCore.App/3.1.0/System.Diagnostics.TraceSource.dll",
        deps = [
            ":system.runtime.dll",
            ":system.collections.nongeneric.dll",
            ":system.collections.specialized.dll",
        ],
    )
    core_stdlib_internal(
        name = "system.diagnostics.tracing.dll",
        version = "4.2.2.0",
        ref = "@core_sdk//:core/packs/Microsoft.NETCore.App.Ref/3.1.0/ref/netcoreapp3.1/System.Diagnostics.Tracing.dll",
        stdlib_path = "@core_sdk//:core/shared/Microsoft.NETCore.App/3.1.0/System.Diagnostics.Tracing.dll",
        deps = [
            ":system.runtime.dll",
        ],
    )
    core_stdlib_internal(
        name = "system.dll",
        version = "4.0.0.0",
        ref = "@core_sdk//:core/packs/Microsoft.NETCore.App.Ref/3.1.0/ref/netcoreapp3.1/System.dll",
        stdlib_path = "@core_sdk//:core/shared/Microsoft.NETCore.App/3.1.0/System.dll",
        deps = [
            ":system.runtime.dll",
            ":system.diagnostics.process.dll",
            ":system.security.cryptography.x509certificates.dll",
            ":system.diagnostics.tools.dll",
            ":system.runtime.extensions.dll",
            ":system.collections.concurrent.dll",
            ":system.collections.dll",
            ":system.objectmodel.dll",
            ":system.collections.specialized.dll",
            ":system.collections.nongeneric.dll",
            ":system.componentmodel.typeconverter.dll",
            ":system.componentmodel.eventbasedasync.dll",
            ":system.componentmodel.primitives.dll",
            ":system.componentmodel.dll",
            ":microsoft.win32.primitives.dll",
            ":system.diagnostics.tracesource.dll",
            ":system.diagnostics.textwritertracelistener.dll",
            ":system.diagnostics.debug.dll",
            ":system.diagnostics.fileversioninfo.dll",
            ":system.diagnostics.stacktrace.dll",
            ":system.io.compression.dll",
            ":system.io.filesystem.watcher.dll",
            ":system.net.requests.dll",
            ":system.net.primitives.dll",
            ":system.net.httplistener.dll",
            ":system.net.servicepoint.dll",
            ":system.net.nameresolution.dll",
            ":system.net.webclient.dll",
            ":system.net.webheadercollection.dll",
            ":system.net.webproxy.dll",
            ":system.net.mail.dll",
            ":system.net.networkinformation.dll",
            ":system.net.ping.dll",
            ":system.net.security.dll",
            ":system.net.sockets.dll",
            ":system.net.websockets.client.dll",
            ":system.net.websockets.dll",
            ":system.runtime.interopservices.dll",
            ":system.security.cryptography.encoding.dll",
            ":system.text.regularexpressions.dll",
            ":system.threading.dll",
            ":system.threading.thread.dll",
        ],
    )
    core_stdlib_internal(
        name = "system.drawing.dll",
        version = "4.0.0.0",
        ref = "@core_sdk//:core/packs/Microsoft.NETCore.App.Ref/3.1.0/ref/netcoreapp3.1/System.Drawing.dll",
        stdlib_path = "@core_sdk//:core/shared/Microsoft.NETCore.App/3.1.0/System.Drawing.dll",
        deps = [
            ":system.runtime.dll",
            ":system.drawing.primitives.dll",
            ":system.componentmodel.typeconverter.dll",
        ],
    )
    core_stdlib_internal(
        name = "system.drawing.primitives.dll",
        version = "4.2.1.0",
        ref = "@core_sdk//:core/packs/Microsoft.NETCore.App.Ref/3.1.0/ref/netcoreapp3.1/System.Drawing.Primitives.dll",
        stdlib_path = "@core_sdk//:core/shared/Microsoft.NETCore.App/3.1.0/System.Drawing.Primitives.dll",
        deps = [
            ":system.runtime.dll",
            ":system.componentmodel.primitives.dll",
        ],
    )
    core_stdlib_internal(
        name = "system.dynamic.runtime.dll",
        version = "4.1.2.0",
        ref = "@core_sdk//:core/packs/Microsoft.NETCore.App.Ref/3.1.0/ref/netcoreapp3.1/System.Dynamic.Runtime.dll",
        stdlib_path = "@core_sdk//:core/shared/Microsoft.NETCore.App/3.1.0/System.Dynamic.Runtime.dll",
        deps = [
            ":system.runtime.dll",
            ":system.linq.expressions.dll",
        ],
    )
    core_stdlib_internal(
        name = "system.globalization.calendars.dll",
        version = "4.1.2.0",
        ref = "@core_sdk//:core/packs/Microsoft.NETCore.App.Ref/3.1.0/ref/netcoreapp3.1/System.Globalization.Calendars.dll",
        stdlib_path = "@core_sdk//:core/shared/Microsoft.NETCore.App/3.1.0/System.Globalization.Calendars.dll",
        deps = [
            ":system.runtime.dll",
        ],
    )
    core_stdlib_internal(
        name = "system.globalization.dll",
        version = "4.1.2.0",
        ref = "@core_sdk//:core/packs/Microsoft.NETCore.App.Ref/3.1.0/ref/netcoreapp3.1/System.Globalization.dll",
        stdlib_path = "@core_sdk//:core/shared/Microsoft.NETCore.App/3.1.0/System.Globalization.dll",
        deps = [
            ":system.runtime.dll",
        ],
    )
    core_stdlib_internal(
        name = "system.globalization.extensions.dll",
        version = "4.1.2.0",
        ref = "@core_sdk//:core/packs/Microsoft.NETCore.App.Ref/3.1.0/ref/netcoreapp3.1/System.Globalization.Extensions.dll",
        stdlib_path = "@core_sdk//:core/shared/Microsoft.NETCore.App/3.1.0/System.Globalization.Extensions.dll",
        deps = [
            ":system.runtime.dll",
            ":system.runtime.extensions.dll",
        ],
    )
    core_stdlib_internal(
        name = "system.io.compression.brotli.dll",
        version = "4.2.2.0",
        ref = "@core_sdk//:core/packs/Microsoft.NETCore.App.Ref/3.1.0/ref/netcoreapp3.1/System.IO.Compression.Brotli.dll",
        stdlib_path = "@core_sdk//:core/shared/Microsoft.NETCore.App/3.1.0/System.IO.Compression.Brotli.dll",
        deps = [
            ":system.runtime.dll",
            ":system.io.compression.dll",
        ],
    )
    core_stdlib_internal(
        name = "system.io.compression.dll",
        version = "4.2.2.0",
        ref = "@core_sdk//:core/packs/Microsoft.NETCore.App.Ref/3.1.0/ref/netcoreapp3.1/System.IO.Compression.dll",
        stdlib_path = "@core_sdk//:core/shared/Microsoft.NETCore.App/3.1.0/System.IO.Compression.dll",
        deps = [
            ":system.runtime.dll",
        ],
    )
    core_stdlib_internal(
        name = "system.io.compression.filesystem.dll",
        version = "4.0.0.0",
        ref = "@core_sdk//:core/packs/Microsoft.NETCore.App.Ref/3.1.0/ref/netcoreapp3.1/System.IO.Compression.FileSystem.dll",
        stdlib_path = "@core_sdk//:core/shared/Microsoft.NETCore.App/3.1.0/System.IO.Compression.FileSystem.dll",
        deps = [
            ":system.runtime.dll",
            ":system.io.compression.zipfile.dll",
        ],
    )
    core_stdlib_internal(
        name = "system.io.compression.zipfile.dll",
        version = "4.0.5.0",
        ref = "@core_sdk//:core/packs/Microsoft.NETCore.App.Ref/3.1.0/ref/netcoreapp3.1/System.IO.Compression.ZipFile.dll",
        stdlib_path = "@core_sdk//:core/shared/Microsoft.NETCore.App/3.1.0/System.IO.Compression.ZipFile.dll",
        deps = [
            ":system.runtime.dll",
            ":system.io.compression.dll",
        ],
    )
    core_stdlib_internal(
        name = "system.io.dll",
        version = "4.2.2.0",
        ref = "@core_sdk//:core/packs/Microsoft.NETCore.App.Ref/3.1.0/ref/netcoreapp3.1/System.IO.dll",
        stdlib_path = "@core_sdk//:core/shared/Microsoft.NETCore.App/3.1.0/System.IO.dll",
        deps = [
            ":system.runtime.dll",
            ":system.runtime.extensions.dll",
        ],
    )
    core_stdlib_internal(
        name = "system.io.filesystem.dll",
        version = "4.1.2.0",
        ref = "@core_sdk//:core/packs/Microsoft.NETCore.App.Ref/3.1.0/ref/netcoreapp3.1/System.IO.FileSystem.dll",
        stdlib_path = "@core_sdk//:core/shared/Microsoft.NETCore.App/3.1.0/System.IO.FileSystem.dll",
        deps = [
            ":system.runtime.dll",
            ":system.runtime.extensions.dll",
        ],
    )
    core_stdlib_internal(
        name = "system.io.filesystem.driveinfo.dll",
        version = "4.1.2.0",
        ref = "@core_sdk//:core/packs/Microsoft.NETCore.App.Ref/3.1.0/ref/netcoreapp3.1/System.IO.FileSystem.DriveInfo.dll",
        stdlib_path = "@core_sdk//:core/shared/Microsoft.NETCore.App/3.1.0/System.IO.FileSystem.DriveInfo.dll",
        deps = [
            ":system.runtime.dll",
            ":system.io.filesystem.dll",
        ],
    )
    core_stdlib_internal(
        name = "system.io.filesystem.primitives.dll",
        version = "4.1.2.0",
        ref = "@core_sdk//:core/packs/Microsoft.NETCore.App.Ref/3.1.0/ref/netcoreapp3.1/System.IO.FileSystem.Primitives.dll",
        stdlib_path = "@core_sdk//:core/shared/Microsoft.NETCore.App/3.1.0/System.IO.FileSystem.Primitives.dll",
        deps = [
            ":system.runtime.dll",
        ],
    )
    core_stdlib_internal(
        name = "system.io.filesystem.watcher.dll",
        version = "4.1.2.0",
        ref = "@core_sdk//:core/packs/Microsoft.NETCore.App.Ref/3.1.0/ref/netcoreapp3.1/System.IO.FileSystem.Watcher.dll",
        stdlib_path = "@core_sdk//:core/shared/Microsoft.NETCore.App/3.1.0/System.IO.FileSystem.Watcher.dll",
        deps = [
            ":system.runtime.dll",
            ":system.componentmodel.primitives.dll",
        ],
    )
    core_stdlib_internal(
        name = "system.io.isolatedstorage.dll",
        version = "4.1.2.0",
        ref = "@core_sdk//:core/packs/Microsoft.NETCore.App.Ref/3.1.0/ref/netcoreapp3.1/System.IO.IsolatedStorage.dll",
        stdlib_path = "@core_sdk//:core/shared/Microsoft.NETCore.App/3.1.0/System.IO.IsolatedStorage.dll",
        deps = [
            ":system.runtime.dll",
        ],
    )
    core_stdlib_internal(
        name = "system.io.memorymappedfiles.dll",
        version = "4.1.2.0",
        ref = "@core_sdk//:core/packs/Microsoft.NETCore.App.Ref/3.1.0/ref/netcoreapp3.1/System.IO.MemoryMappedFiles.dll",
        stdlib_path = "@core_sdk//:core/shared/Microsoft.NETCore.App/3.1.0/System.IO.MemoryMappedFiles.dll",
        deps = [
            ":system.runtime.dll",
            ":system.runtime.interopservices.dll",
        ],
    )
    core_stdlib_internal(
        name = "system.io.pipes.dll",
        version = "4.1.2.0",
        ref = "@core_sdk//:core/packs/Microsoft.NETCore.App.Ref/3.1.0/ref/netcoreapp3.1/System.IO.Pipes.dll",
        stdlib_path = "@core_sdk//:core/shared/Microsoft.NETCore.App/3.1.0/System.IO.Pipes.dll",
        deps = [
            ":system.runtime.dll",
            ":system.security.principal.dll",
        ],
    )
    core_stdlib_internal(
        name = "system.io.unmanagedmemorystream.dll",
        version = "4.1.2.0",
        ref = "@core_sdk//:core/packs/Microsoft.NETCore.App.Ref/3.1.0/ref/netcoreapp3.1/System.IO.UnmanagedMemoryStream.dll",
        stdlib_path = "@core_sdk//:core/shared/Microsoft.NETCore.App/3.1.0/System.IO.UnmanagedMemoryStream.dll",
        deps = [
            ":system.runtime.dll",
            ":system.runtime.interopservices.dll",
        ],
    )
    core_stdlib_internal(
        name = "system.linq.dll",
        version = "4.2.2.0",
        ref = "@core_sdk//:core/packs/Microsoft.NETCore.App.Ref/3.1.0/ref/netcoreapp3.1/System.Linq.dll",
        stdlib_path = "@core_sdk//:core/shared/Microsoft.NETCore.App/3.1.0/System.Linq.dll",
        deps = [
            ":system.runtime.dll",
            ":system.collections.dll",
        ],
    )
    core_stdlib_internal(
        name = "system.linq.expressions.dll",
        version = "4.2.2.0",
        ref = "@core_sdk//:core/packs/Microsoft.NETCore.App.Ref/3.1.0/ref/netcoreapp3.1/System.Linq.Expressions.dll",
        stdlib_path = "@core_sdk//:core/shared/Microsoft.NETCore.App/3.1.0/System.Linq.Expressions.dll",
        deps = [
            ":system.runtime.dll",
            ":system.objectmodel.dll",
        ],
    )
    core_stdlib_internal(
        name = "system.linq.parallel.dll",
        version = "4.0.4.0",
        ref = "@core_sdk//:core/packs/Microsoft.NETCore.App.Ref/3.1.0/ref/netcoreapp3.1/System.Linq.Parallel.dll",
        stdlib_path = "@core_sdk//:core/shared/Microsoft.NETCore.App/3.1.0/System.Linq.Parallel.dll",
        deps = [
            ":system.runtime.dll",
            ":system.collections.concurrent.dll",
            ":system.linq.dll",
            ":system.collections.dll",
        ],
    )
    core_stdlib_internal(
        name = "system.linq.queryable.dll",
        version = "4.0.4.0",
        ref = "@core_sdk//:core/packs/Microsoft.NETCore.App.Ref/3.1.0/ref/netcoreapp3.1/System.Linq.Queryable.dll",
        stdlib_path = "@core_sdk//:core/shared/Microsoft.NETCore.App/3.1.0/System.Linq.Queryable.dll",
        deps = [
            ":system.runtime.dll",
            ":system.linq.expressions.dll",
            ":system.linq.dll",
        ],
    )
    core_stdlib_internal(
        name = "system.memory.dll",
        version = "4.2.1.0",
        ref = "@core_sdk//:core/packs/Microsoft.NETCore.App.Ref/3.1.0/ref/netcoreapp3.1/System.Memory.dll",
        stdlib_path = "@core_sdk//:core/shared/Microsoft.NETCore.App/3.1.0/System.Memory.dll",
        deps = [
            ":system.runtime.dll",
            ":system.runtime.interopservices.dll",
        ],
    )
    core_stdlib_internal(
        name = "system.net.dll",
        version = "4.0.0.0",
        ref = "@core_sdk//:core/packs/Microsoft.NETCore.App.Ref/3.1.0/ref/netcoreapp3.1/System.Net.dll",
        stdlib_path = "@core_sdk//:core/shared/Microsoft.NETCore.App/3.1.0/System.Net.dll",
        deps = [
            ":system.runtime.dll",
            ":system.net.primitives.dll",
            ":system.net.webclient.dll",
            ":system.net.webheadercollection.dll",
            ":system.net.requests.dll",
            ":system.net.networkinformation.dll",
            ":system.net.sockets.dll",
        ],
    )
    core_stdlib_internal(
        name = "system.net.http.dll",
        version = "4.2.2.0",
        ref = "@core_sdk//:core/packs/Microsoft.NETCore.App.Ref/3.1.0/ref/netcoreapp3.1/System.Net.Http.dll",
        stdlib_path = "@core_sdk//:core/shared/Microsoft.NETCore.App/3.1.0/System.Net.Http.dll",
        deps = [
            ":system.runtime.dll",
            ":system.net.primitives.dll",
            ":system.security.cryptography.x509certificates.dll",
            ":system.net.security.dll",
        ],
    )
    core_stdlib_internal(
        name = "system.net.httplistener.dll",
        version = "4.0.2.0",
        ref = "@core_sdk//:core/packs/Microsoft.NETCore.App.Ref/3.1.0/ref/netcoreapp3.1/System.Net.HttpListener.dll",
        stdlib_path = "@core_sdk//:core/shared/Microsoft.NETCore.App/3.1.0/System.Net.HttpListener.dll",
        deps = [
            ":system.runtime.dll",
            ":system.net.primitives.dll",
            ":system.net.security.dll",
            ":system.security.claims.dll",
            ":system.security.principal.dll",
            ":microsoft.win32.primitives.dll",
            ":system.collections.specialized.dll",
            ":system.security.cryptography.x509certificates.dll",
            ":system.net.webheadercollection.dll",
            ":system.net.websockets.dll",
        ],
    )
    core_stdlib_internal(
        name = "system.net.mail.dll",
        version = "4.0.2.0",
        ref = "@core_sdk//:core/packs/Microsoft.NETCore.App.Ref/3.1.0/ref/netcoreapp3.1/System.Net.Mail.dll",
        stdlib_path = "@core_sdk//:core/shared/Microsoft.NETCore.App/3.1.0/System.Net.Mail.dll",
        deps = [
            ":system.runtime.dll",
            ":system.collections.specialized.dll",
            ":system.componentmodel.eventbasedasync.dll",
            ":system.security.cryptography.x509certificates.dll",
            ":system.net.primitives.dll",
            ":system.net.servicepoint.dll",
        ],
    )
    core_stdlib_internal(
        name = "system.net.nameresolution.dll",
        version = "4.1.2.0",
        ref = "@core_sdk//:core/packs/Microsoft.NETCore.App.Ref/3.1.0/ref/netcoreapp3.1/System.Net.NameResolution.dll",
        stdlib_path = "@core_sdk//:core/shared/Microsoft.NETCore.App/3.1.0/System.Net.NameResolution.dll",
        deps = [
            ":system.runtime.dll",
            ":system.net.primitives.dll",
        ],
    )
    core_stdlib_internal(
        name = "system.net.networkinformation.dll",
        version = "4.2.2.0",
        ref = "@core_sdk//:core/packs/Microsoft.NETCore.App.Ref/3.1.0/ref/netcoreapp3.1/System.Net.NetworkInformation.dll",
        stdlib_path = "@core_sdk//:core/shared/Microsoft.NETCore.App/3.1.0/System.Net.NetworkInformation.dll",
        deps = [
            ":system.runtime.dll",
            ":system.net.primitives.dll",
            ":microsoft.win32.primitives.dll",
        ],
    )
    core_stdlib_internal(
        name = "system.net.ping.dll",
        version = "4.1.2.0",
        ref = "@core_sdk//:core/packs/Microsoft.NETCore.App.Ref/3.1.0/ref/netcoreapp3.1/System.Net.Ping.dll",
        stdlib_path = "@core_sdk//:core/shared/Microsoft.NETCore.App/3.1.0/System.Net.Ping.dll",
        deps = [
            ":system.runtime.dll",
            ":system.componentmodel.primitives.dll",
            ":system.net.primitives.dll",
            ":system.componentmodel.eventbasedasync.dll",
        ],
    )
    core_stdlib_internal(
        name = "system.net.primitives.dll",
        version = "4.1.2.0",
        ref = "@core_sdk//:core/packs/Microsoft.NETCore.App.Ref/3.1.0/ref/netcoreapp3.1/System.Net.Primitives.dll",
        stdlib_path = "@core_sdk//:core/shared/Microsoft.NETCore.App/3.1.0/System.Net.Primitives.dll",
        deps = [
            ":system.runtime.dll",
            ":system.runtime.interopservices.dll",
            ":microsoft.win32.primitives.dll",
        ],
    )
    core_stdlib_internal(
        name = "system.net.requests.dll",
        version = "4.1.2.0",
        ref = "@core_sdk//:core/packs/Microsoft.NETCore.App.Ref/3.1.0/ref/netcoreapp3.1/System.Net.Requests.dll",
        stdlib_path = "@core_sdk//:core/shared/Microsoft.NETCore.App/3.1.0/System.Net.Requests.dll",
        deps = [
            ":system.runtime.dll",
            ":system.collections.specialized.dll",
            ":system.net.primitives.dll",
            ":system.net.webheadercollection.dll",
            ":system.security.cryptography.x509certificates.dll",
            ":system.net.servicepoint.dll",
            ":system.net.security.dll",
            ":system.security.principal.dll",
        ],
    )
    core_stdlib_internal(
        name = "system.net.security.dll",
        version = "4.1.2.0",
        ref = "@core_sdk//:core/packs/Microsoft.NETCore.App.Ref/3.1.0/ref/netcoreapp3.1/System.Net.Security.dll",
        stdlib_path = "@core_sdk//:core/shared/Microsoft.NETCore.App/3.1.0/System.Net.Security.dll",
        deps = [
            ":system.runtime.dll",
            ":system.net.primitives.dll",
            ":system.collections.nongeneric.dll",
            ":system.security.cryptography.x509certificates.dll",
            ":system.security.principal.dll",
            ":system.collections.dll",
        ],
    )
    core_stdlib_internal(
        name = "system.net.servicepoint.dll",
        version = "4.0.2.0",
        ref = "@core_sdk//:core/packs/Microsoft.NETCore.App.Ref/3.1.0/ref/netcoreapp3.1/System.Net.ServicePoint.dll",
        stdlib_path = "@core_sdk//:core/shared/Microsoft.NETCore.App/3.1.0/System.Net.ServicePoint.dll",
        deps = [
            ":system.runtime.dll",
            ":system.net.primitives.dll",
            ":system.security.cryptography.x509certificates.dll",
            ":system.net.security.dll",
        ],
    )
    core_stdlib_internal(
        name = "system.net.sockets.dll",
        version = "4.2.2.0",
        ref = "@core_sdk//:core/packs/Microsoft.NETCore.App.Ref/3.1.0/ref/netcoreapp3.1/System.Net.Sockets.dll",
        stdlib_path = "@core_sdk//:core/shared/Microsoft.NETCore.App/3.1.0/System.Net.Sockets.dll",
        deps = [
            ":system.runtime.dll",
            ":system.net.primitives.dll",
        ],
    )
    core_stdlib_internal(
        name = "system.net.webclient.dll",
        version = "4.0.2.0",
        ref = "@core_sdk//:core/packs/Microsoft.NETCore.App.Ref/3.1.0/ref/netcoreapp3.1/System.Net.WebClient.dll",
        stdlib_path = "@core_sdk//:core/shared/Microsoft.NETCore.App/3.1.0/System.Net.WebClient.dll",
        deps = [
            ":system.runtime.dll",
            ":system.componentmodel.eventbasedasync.dll",
            ":system.componentmodel.primitives.dll",
            ":system.net.primitives.dll",
            ":system.net.webheadercollection.dll",
            ":system.collections.specialized.dll",
            ":system.net.requests.dll",
        ],
    )
    core_stdlib_internal(
        name = "system.net.webheadercollection.dll",
        version = "4.1.2.0",
        ref = "@core_sdk//:core/packs/Microsoft.NETCore.App.Ref/3.1.0/ref/netcoreapp3.1/System.Net.WebHeaderCollection.dll",
        stdlib_path = "@core_sdk//:core/shared/Microsoft.NETCore.App/3.1.0/System.Net.WebHeaderCollection.dll",
        deps = [
            ":system.runtime.dll",
            ":system.collections.specialized.dll",
        ],
    )
    core_stdlib_internal(
        name = "system.net.webproxy.dll",
        version = "4.0.2.0",
        ref = "@core_sdk//:core/packs/Microsoft.NETCore.App.Ref/3.1.0/ref/netcoreapp3.1/System.Net.WebProxy.dll",
        stdlib_path = "@core_sdk//:core/shared/Microsoft.NETCore.App/3.1.0/System.Net.WebProxy.dll",
        deps = [
            ":system.runtime.dll",
            ":system.net.primitives.dll",
            ":system.runtime.extensions.dll",
        ],
    )
    core_stdlib_internal(
        name = "system.net.websockets.client.dll",
        version = "4.1.2.0",
        ref = "@core_sdk//:core/packs/Microsoft.NETCore.App.Ref/3.1.0/ref/netcoreapp3.1/System.Net.WebSockets.Client.dll",
        stdlib_path = "@core_sdk//:core/shared/Microsoft.NETCore.App/3.1.0/System.Net.WebSockets.Client.dll",
        deps = [
            ":system.runtime.dll",
            ":system.net.websockets.dll",
            ":system.security.cryptography.x509certificates.dll",
            ":system.net.primitives.dll",
            ":system.net.security.dll",
        ],
    )
    core_stdlib_internal(
        name = "system.net.websockets.dll",
        version = "4.1.2.0",
        ref = "@core_sdk//:core/packs/Microsoft.NETCore.App.Ref/3.1.0/ref/netcoreapp3.1/System.Net.WebSockets.dll",
        stdlib_path = "@core_sdk//:core/shared/Microsoft.NETCore.App/3.1.0/System.Net.WebSockets.dll",
        deps = [
            ":system.runtime.dll",
            ":system.net.primitives.dll",
            ":system.collections.specialized.dll",
            ":system.security.principal.dll",
            ":microsoft.win32.primitives.dll",
        ],
    )
    core_stdlib_internal(
        name = "system.numerics.dll",
        version = "4.0.0.0",
        ref = "@core_sdk//:core/packs/Microsoft.NETCore.App.Ref/3.1.0/ref/netcoreapp3.1/System.Numerics.dll",
        stdlib_path = "@core_sdk//:core/shared/Microsoft.NETCore.App/3.1.0/System.Numerics.dll",
        deps = [
            ":system.runtime.dll",
            ":system.runtime.numerics.dll",
            ":system.numerics.vectors.dll",
        ],
    )
    core_stdlib_internal(
        name = "system.numerics.vectors.dll",
        version = "4.1.6.0",
        ref = "@core_sdk//:core/packs/Microsoft.NETCore.App.Ref/3.1.0/ref/netcoreapp3.1/System.Numerics.Vectors.dll",
        stdlib_path = "@core_sdk//:core/shared/Microsoft.NETCore.App/3.1.0/System.Numerics.Vectors.dll",
        deps = [
            ":system.runtime.dll",
        ],
    )
    core_stdlib_internal(
        name = "system.objectmodel.dll",
        version = "4.1.2.0",
        ref = "@core_sdk//:core/packs/Microsoft.NETCore.App.Ref/3.1.0/ref/netcoreapp3.1/System.ObjectModel.dll",
        stdlib_path = "@core_sdk//:core/shared/Microsoft.NETCore.App/3.1.0/System.ObjectModel.dll",
        deps = [
            ":system.runtime.dll",
            ":system.collections.dll",
        ],
    )
    core_stdlib_internal(
        name = "system.reflection.dispatchproxy.dll",
        version = "4.0.6.0",
        ref = "@core_sdk//:core/packs/Microsoft.NETCore.App.Ref/3.1.0/ref/netcoreapp3.1/System.Reflection.DispatchProxy.dll",
        stdlib_path = "@core_sdk//:core/shared/Microsoft.NETCore.App/3.1.0/System.Reflection.DispatchProxy.dll",
        deps = [
            ":system.runtime.dll",
        ],
    )
    core_stdlib_internal(
        name = "system.reflection.dll",
        version = "4.2.2.0",
        ref = "@core_sdk//:core/packs/Microsoft.NETCore.App.Ref/3.1.0/ref/netcoreapp3.1/System.Reflection.dll",
        stdlib_path = "@core_sdk//:core/shared/Microsoft.NETCore.App/3.1.0/System.Reflection.dll",
        deps = [
            ":system.runtime.dll",
        ],
    )
    core_stdlib_internal(
        name = "system.reflection.emit.dll",
        version = "4.1.2.0",
        ref = "@core_sdk//:core/packs/Microsoft.NETCore.App.Ref/3.1.0/ref/netcoreapp3.1/System.Reflection.Emit.dll",
        stdlib_path = "@core_sdk//:core/shared/Microsoft.NETCore.App/3.1.0/System.Reflection.Emit.dll",
        deps = [
            ":system.runtime.dll",
            ":system.runtime.interopservices.dll",
            ":system.reflection.emit.ilgeneration.dll",
            ":system.reflection.primitives.dll",
        ],
    )
    core_stdlib_internal(
        name = "system.reflection.emit.ilgeneration.dll",
        version = "4.1.1.0",
        ref = "@core_sdk//:core/packs/Microsoft.NETCore.App.Ref/3.1.0/ref/netcoreapp3.1/System.Reflection.Emit.ILGeneration.dll",
        stdlib_path = "@core_sdk//:core/shared/Microsoft.NETCore.App/3.1.0/System.Reflection.Emit.ILGeneration.dll",
        deps = [
            ":system.runtime.dll",
            ":system.runtime.interopservices.dll",
            ":system.reflection.primitives.dll",
        ],
    )
    core_stdlib_internal(
        name = "system.reflection.emit.lightweight.dll",
        version = "4.1.1.0",
        ref = "@core_sdk//:core/packs/Microsoft.NETCore.App.Ref/3.1.0/ref/netcoreapp3.1/System.Reflection.Emit.Lightweight.dll",
        stdlib_path = "@core_sdk//:core/shared/Microsoft.NETCore.App/3.1.0/System.Reflection.Emit.Lightweight.dll",
        deps = [
            ":system.runtime.dll",
            ":system.reflection.emit.ilgeneration.dll",
        ],
    )
    core_stdlib_internal(
        name = "system.reflection.extensions.dll",
        version = "4.1.2.0",
        ref = "@core_sdk//:core/packs/Microsoft.NETCore.App.Ref/3.1.0/ref/netcoreapp3.1/System.Reflection.Extensions.dll",
        stdlib_path = "@core_sdk//:core/shared/Microsoft.NETCore.App/3.1.0/System.Reflection.Extensions.dll",
        deps = [
            ":system.runtime.dll",
        ],
    )
    core_stdlib_internal(
        name = "system.reflection.metadata.dll",
        version = "1.4.5.0",
        ref = "@core_sdk//:core/packs/Microsoft.NETCore.App.Ref/3.1.0/ref/netcoreapp3.1/System.Reflection.Metadata.dll",
        stdlib_path = "@core_sdk//:core/shared/Microsoft.NETCore.App/3.1.0/System.Reflection.Metadata.dll",
        deps = [
            ":system.runtime.dll",
            ":system.collections.immutable.dll",
        ],
    )
    core_stdlib_internal(
        name = "system.reflection.primitives.dll",
        version = "4.1.2.0",
        ref = "@core_sdk//:core/packs/Microsoft.NETCore.App.Ref/3.1.0/ref/netcoreapp3.1/System.Reflection.Primitives.dll",
        stdlib_path = "@core_sdk//:core/shared/Microsoft.NETCore.App/3.1.0/System.Reflection.Primitives.dll",
        deps = [
            ":system.runtime.dll",
        ],
    )
    core_stdlib_internal(
        name = "system.reflection.typeextensions.dll",
        version = "4.1.2.0",
        ref = "@core_sdk//:core/packs/Microsoft.NETCore.App.Ref/3.1.0/ref/netcoreapp3.1/System.Reflection.TypeExtensions.dll",
        stdlib_path = "@core_sdk//:core/shared/Microsoft.NETCore.App/3.1.0/System.Reflection.TypeExtensions.dll",
        deps = [
            ":netstandard.dll",
        ],
    )
    core_stdlib_internal(
        name = "system.resources.reader.dll",
        version = "4.1.2.0",
        ref = "@core_sdk//:core/packs/Microsoft.NETCore.App.Ref/3.1.0/ref/netcoreapp3.1/System.Resources.Reader.dll",
        stdlib_path = "@core_sdk//:core/shared/Microsoft.NETCore.App/3.1.0/System.Resources.Reader.dll",
        deps = [
            ":system.runtime.dll",
            ":system.resources.resourcemanager.dll",
        ],
    )
    core_stdlib_internal(
        name = "system.resources.resourcemanager.dll",
        version = "4.1.2.0",
        ref = "@core_sdk//:core/packs/Microsoft.NETCore.App.Ref/3.1.0/ref/netcoreapp3.1/System.Resources.ResourceManager.dll",
        stdlib_path = "@core_sdk//:core/shared/Microsoft.NETCore.App/3.1.0/System.Resources.ResourceManager.dll",
        deps = [
            ":system.runtime.dll",
            ":system.runtime.interopservices.dll",
        ],
    )
    core_stdlib_internal(
        name = "system.resources.writer.dll",
        version = "4.1.2.0",
        ref = "@core_sdk//:core/packs/Microsoft.NETCore.App.Ref/3.1.0/ref/netcoreapp3.1/System.Resources.Writer.dll",
        stdlib_path = "@core_sdk//:core/shared/Microsoft.NETCore.App/3.1.0/System.Resources.Writer.dll",
        deps = [
            ":system.runtime.dll",
        ],
    )
    core_stdlib_internal(
        name = "system.runtime.compilerservices.unsafe.dll",
        version = "4.0.6.0",
        ref = "@core_sdk//:core/packs/Microsoft.NETCore.App.Ref/3.1.0/ref/netcoreapp3.1/System.Runtime.CompilerServices.Unsafe.dll",
        stdlib_path = "@core_sdk//:core/shared/Microsoft.NETCore.App/3.1.0/System.Runtime.CompilerServices.Unsafe.dll",
        deps = [
            ":netstandard.dll",
        ],
    )
    core_stdlib_internal(
        name = "system.runtime.compilerservices.visualc.dll",
        version = "4.1.2.0",
        ref = "@core_sdk//:core/packs/Microsoft.NETCore.App.Ref/3.1.0/ref/netcoreapp3.1/System.Runtime.CompilerServices.VisualC.dll",
        stdlib_path = "@core_sdk//:core/shared/Microsoft.NETCore.App/3.1.0/System.Runtime.CompilerServices.VisualC.dll",
        deps = [
            ":system.runtime.dll",
        ],
    )
    core_stdlib_internal(
        name = "system.runtime.dll",
        version = "4.2.2.0",
        ref = "@core_sdk//:core/packs/Microsoft.NETCore.App.Ref/3.1.0/ref/netcoreapp3.1/System.Runtime.dll",
        stdlib_path = "@core_sdk//:core/shared/Microsoft.NETCore.App/3.1.0/System.Runtime.dll",
        deps = [
        ],
    )
    core_stdlib_internal(
        name = "system.runtime.extensions.dll",
        version = "4.2.2.0",
        ref = "@core_sdk//:core/packs/Microsoft.NETCore.App.Ref/3.1.0/ref/netcoreapp3.1/System.Runtime.Extensions.dll",
        stdlib_path = "@core_sdk//:core/shared/Microsoft.NETCore.App/3.1.0/System.Runtime.Extensions.dll",
        deps = [
            ":system.runtime.dll",
            ":system.security.principal.dll",
        ],
    )
    core_stdlib_internal(
        name = "system.runtime.handles.dll",
        version = "4.1.2.0",
        ref = "@core_sdk//:core/packs/Microsoft.NETCore.App.Ref/3.1.0/ref/netcoreapp3.1/System.Runtime.Handles.dll",
        stdlib_path = "@core_sdk//:core/shared/Microsoft.NETCore.App/3.1.0/System.Runtime.Handles.dll",
        deps = [
            ":system.runtime.dll",
        ],
    )
    core_stdlib_internal(
        name = "system.runtime.interopservices.dll",
        version = "4.2.2.0",
        ref = "@core_sdk//:core/packs/Microsoft.NETCore.App.Ref/3.1.0/ref/netcoreapp3.1/System.Runtime.InteropServices.dll",
        stdlib_path = "@core_sdk//:core/shared/Microsoft.NETCore.App/3.1.0/System.Runtime.InteropServices.dll",
        deps = [
            ":system.runtime.dll",
        ],
    )
    core_stdlib_internal(
        name = "system.runtime.interopservices.runtimeinformation.dll",
        version = "4.0.4.0",
        ref = "@core_sdk//:core/packs/Microsoft.NETCore.App.Ref/3.1.0/ref/netcoreapp3.1/System.Runtime.InteropServices.RuntimeInformation.dll",
        stdlib_path = "@core_sdk//:core/shared/Microsoft.NETCore.App/3.1.0/System.Runtime.InteropServices.RuntimeInformation.dll",
        deps = [
            ":system.runtime.dll",
        ],
    )
    core_stdlib_internal(
        name = "system.runtime.interopservices.windowsruntime.dll",
        version = "4.0.4.0",
        ref = "@core_sdk//:core/packs/Microsoft.NETCore.App.Ref/3.1.0/ref/netcoreapp3.1/System.Runtime.InteropServices.WindowsRuntime.dll",
        stdlib_path = "@core_sdk//:core/shared/Microsoft.NETCore.App/3.1.0/System.Runtime.InteropServices.WindowsRuntime.dll",
        deps = [
            ":system.runtime.dll",
        ],
    )
    core_stdlib_internal(
        name = "system.runtime.intrinsics.dll",
        version = "4.0.1.0",
        ref = "@core_sdk//:core/packs/Microsoft.NETCore.App.Ref/3.1.0/ref/netcoreapp3.1/System.Runtime.Intrinsics.dll",
        stdlib_path = "@core_sdk//:core/shared/Microsoft.NETCore.App/3.1.0/System.Runtime.Intrinsics.dll",
        deps = [
            ":system.runtime.dll",
        ],
    )
    core_stdlib_internal(
        name = "system.runtime.loader.dll",
        version = "4.1.1.0",
        ref = "@core_sdk//:core/packs/Microsoft.NETCore.App.Ref/3.1.0/ref/netcoreapp3.1/System.Runtime.Loader.dll",
        stdlib_path = "@core_sdk//:core/shared/Microsoft.NETCore.App/3.1.0/System.Runtime.Loader.dll",
        deps = [
            ":system.runtime.dll",
        ],
    )
    core_stdlib_internal(
        name = "system.runtime.numerics.dll",
        version = "4.1.2.0",
        ref = "@core_sdk//:core/packs/Microsoft.NETCore.App.Ref/3.1.0/ref/netcoreapp3.1/System.Runtime.Numerics.dll",
        stdlib_path = "@core_sdk//:core/shared/Microsoft.NETCore.App/3.1.0/System.Runtime.Numerics.dll",
        deps = [
            ":system.runtime.dll",
        ],
    )
    core_stdlib_internal(
        name = "system.runtime.serialization.dll",
        version = "4.0.0.0",
        ref = "@core_sdk//:core/packs/Microsoft.NETCore.App.Ref/3.1.0/ref/netcoreapp3.1/System.Runtime.Serialization.dll",
        stdlib_path = "@core_sdk//:core/shared/Microsoft.NETCore.App/3.1.0/System.Runtime.Serialization.dll",
        deps = [
            ":system.runtime.dll",
            ":system.runtime.serialization.primitives.dll",
            ":system.runtime.serialization.xml.dll",
            ":system.runtime.serialization.json.dll",
        ],
    )
    core_stdlib_internal(
        name = "system.runtime.serialization.formatters.dll",
        version = "4.0.4.0",
        ref = "@core_sdk//:core/packs/Microsoft.NETCore.App.Ref/3.1.0/ref/netcoreapp3.1/System.Runtime.Serialization.Formatters.dll",
        stdlib_path = "@core_sdk//:core/shared/Microsoft.NETCore.App/3.1.0/System.Runtime.Serialization.Formatters.dll",
        deps = [
            ":system.runtime.dll",
            ":system.collections.nongeneric.dll",
        ],
    )
    core_stdlib_internal(
        name = "system.runtime.serialization.json.dll",
        version = "4.0.5.0",
        ref = "@core_sdk//:core/packs/Microsoft.NETCore.App.Ref/3.1.0/ref/netcoreapp3.1/System.Runtime.Serialization.Json.dll",
        stdlib_path = "@core_sdk//:core/shared/Microsoft.NETCore.App/3.1.0/System.Runtime.Serialization.Json.dll",
        deps = [
            ":system.runtime.dll",
            ":system.runtime.serialization.xml.dll",
            ":system.xml.readerwriter.dll",
        ],
    )
    core_stdlib_internal(
        name = "system.runtime.serialization.primitives.dll",
        version = "4.2.2.0",
        ref = "@core_sdk//:core/packs/Microsoft.NETCore.App.Ref/3.1.0/ref/netcoreapp3.1/System.Runtime.Serialization.Primitives.dll",
        stdlib_path = "@core_sdk//:core/shared/Microsoft.NETCore.App/3.1.0/System.Runtime.Serialization.Primitives.dll",
        deps = [
            ":system.runtime.dll",
        ],
    )
    core_stdlib_internal(
        name = "system.runtime.serialization.xml.dll",
        version = "4.1.5.0",
        ref = "@core_sdk//:core/packs/Microsoft.NETCore.App.Ref/3.1.0/ref/netcoreapp3.1/System.Runtime.Serialization.Xml.dll",
        stdlib_path = "@core_sdk//:core/shared/Microsoft.NETCore.App/3.1.0/System.Runtime.Serialization.Xml.dll",
        deps = [
            ":system.runtime.dll",
            ":system.xml.readerwriter.dll",
            ":system.runtime.serialization.primitives.dll",
        ],
    )
    core_stdlib_internal(
        name = "system.security.claims.dll",
        version = "4.1.2.0",
        ref = "@core_sdk//:core/packs/Microsoft.NETCore.App.Ref/3.1.0/ref/netcoreapp3.1/System.Security.Claims.dll",
        stdlib_path = "@core_sdk//:core/shared/Microsoft.NETCore.App/3.1.0/System.Security.Claims.dll",
        deps = [
            ":system.runtime.dll",
            ":system.security.principal.dll",
            ":system.runtime.extensions.dll",
        ],
    )
    core_stdlib_internal(
        name = "system.security.cryptography.algorithms.dll",
        version = "4.3.2.0",
        ref = "@core_sdk//:core/packs/Microsoft.NETCore.App.Ref/3.1.0/ref/netcoreapp3.1/System.Security.Cryptography.Algorithms.dll",
        stdlib_path = "@core_sdk//:core/shared/Microsoft.NETCore.App/3.1.0/System.Security.Cryptography.Algorithms.dll",
        deps = [
            ":system.runtime.dll",
            ":system.security.cryptography.primitives.dll",
            ":system.security.cryptography.encoding.dll",
            ":system.runtime.extensions.dll",
        ],
    )
    core_stdlib_internal(
        name = "system.security.cryptography.csp.dll",
        version = "4.1.2.0",
        ref = "@core_sdk//:core/packs/Microsoft.NETCore.App.Ref/3.1.0/ref/netcoreapp3.1/System.Security.Cryptography.Csp.dll",
        stdlib_path = "@core_sdk//:core/shared/Microsoft.NETCore.App/3.1.0/System.Security.Cryptography.Csp.dll",
        deps = [
            ":system.runtime.dll",
            ":system.runtime.interopservices.dll",
            ":system.security.cryptography.algorithms.dll",
            ":system.security.cryptography.primitives.dll",
        ],
    )
    core_stdlib_internal(
        name = "system.security.cryptography.encoding.dll",
        version = "4.1.2.0",
        ref = "@core_sdk//:core/packs/Microsoft.NETCore.App.Ref/3.1.0/ref/netcoreapp3.1/System.Security.Cryptography.Encoding.dll",
        stdlib_path = "@core_sdk//:core/shared/Microsoft.NETCore.App/3.1.0/System.Security.Cryptography.Encoding.dll",
        deps = [
            ":system.runtime.dll",
            ":system.security.cryptography.primitives.dll",
        ],
    )
    core_stdlib_internal(
        name = "system.security.cryptography.primitives.dll",
        version = "4.1.2.0",
        ref = "@core_sdk//:core/packs/Microsoft.NETCore.App.Ref/3.1.0/ref/netcoreapp3.1/System.Security.Cryptography.Primitives.dll",
        stdlib_path = "@core_sdk//:core/shared/Microsoft.NETCore.App/3.1.0/System.Security.Cryptography.Primitives.dll",
        deps = [
            ":system.runtime.dll",
        ],
    )
    core_stdlib_internal(
        name = "system.security.cryptography.x509certificates.dll",
        version = "4.2.2.0",
        ref = "@core_sdk//:core/packs/Microsoft.NETCore.App.Ref/3.1.0/ref/netcoreapp3.1/System.Security.Cryptography.X509Certificates.dll",
        stdlib_path = "@core_sdk//:core/shared/Microsoft.NETCore.App/3.1.0/System.Security.Cryptography.X509Certificates.dll",
        deps = [
            ":system.runtime.dll",
            ":system.runtime.interopservices.dll",
            ":system.security.cryptography.algorithms.dll",
            ":system.security.cryptography.primitives.dll",
            ":system.security.cryptography.encoding.dll",
            ":system.net.primitives.dll",
            ":system.collections.nongeneric.dll",
        ],
    )
    core_stdlib_internal(
        name = "system.security.dll",
        version = "4.0.0.0",
        ref = "@core_sdk//:core/packs/Microsoft.NETCore.App.Ref/3.1.0/ref/netcoreapp3.1/System.Security.dll",
        stdlib_path = "@core_sdk//:core/shared/Microsoft.NETCore.App/3.1.0/System.Security.dll",
        deps = [
            ":system.runtime.dll",
        ],
    )
    core_stdlib_internal(
        name = "system.security.principal.dll",
        version = "4.1.2.0",
        ref = "@core_sdk//:core/packs/Microsoft.NETCore.App.Ref/3.1.0/ref/netcoreapp3.1/System.Security.Principal.dll",
        stdlib_path = "@core_sdk//:core/shared/Microsoft.NETCore.App/3.1.0/System.Security.Principal.dll",
        deps = [
            ":system.runtime.dll",
        ],
    )
    core_stdlib_internal(
        name = "system.security.securestring.dll",
        version = "4.1.2.0",
        ref = "@core_sdk//:core/packs/Microsoft.NETCore.App.Ref/3.1.0/ref/netcoreapp3.1/System.Security.SecureString.dll",
        stdlib_path = "@core_sdk//:core/shared/Microsoft.NETCore.App/3.1.0/System.Security.SecureString.dll",
        deps = [
            ":system.runtime.dll",
            ":system.runtime.interopservices.dll",
        ],
    )
    core_stdlib_internal(
        name = "system.servicemodel.web.dll",
        version = "4.0.0.0",
        ref = "@core_sdk//:core/packs/Microsoft.NETCore.App.Ref/3.1.0/ref/netcoreapp3.1/System.ServiceModel.Web.dll",
        stdlib_path = "@core_sdk//:core/shared/Microsoft.NETCore.App/3.1.0/System.ServiceModel.Web.dll",
        deps = [
            ":system.runtime.dll",
            ":system.runtime.serialization.json.dll",
        ],
    )
    core_stdlib_internal(
        name = "system.serviceprocess.dll",
        version = "4.0.0.0",
        ref = "@core_sdk//:core/packs/Microsoft.NETCore.App.Ref/3.1.0/ref/netcoreapp3.1/System.ServiceProcess.dll",
        stdlib_path = "@core_sdk//:core/shared/Microsoft.NETCore.App/3.1.0/System.ServiceProcess.dll",
        deps = [
            ":system.runtime.dll",
        ],
    )
    core_stdlib_internal(
        name = "system.text.encoding.codepages.dll",
        version = "4.1.3.0",
        ref = "@core_sdk//:core/packs/Microsoft.NETCore.App.Ref/3.1.0/ref/netcoreapp3.1/System.Text.Encoding.CodePages.dll",
        stdlib_path = "@core_sdk//:core/shared/Microsoft.NETCore.App/3.1.0/System.Text.Encoding.CodePages.dll",
        deps = [
            ":netstandard.dll",
        ],
    )
    core_stdlib_internal(
        name = "system.text.encoding.dll",
        version = "4.1.2.0",
        ref = "@core_sdk//:core/packs/Microsoft.NETCore.App.Ref/3.1.0/ref/netcoreapp3.1/System.Text.Encoding.dll",
        stdlib_path = "@core_sdk//:core/shared/Microsoft.NETCore.App/3.1.0/System.Text.Encoding.dll",
        deps = [
            ":system.runtime.dll",
        ],
    )
    core_stdlib_internal(
        name = "system.text.encoding.extensions.dll",
        version = "4.1.2.0",
        ref = "@core_sdk//:core/packs/Microsoft.NETCore.App.Ref/3.1.0/ref/netcoreapp3.1/System.Text.Encoding.Extensions.dll",
        stdlib_path = "@core_sdk//:core/shared/Microsoft.NETCore.App/3.1.0/System.Text.Encoding.Extensions.dll",
        deps = [
            ":system.runtime.dll",
        ],
    )
    core_stdlib_internal(
        name = "system.text.encodings.web.dll",
        version = "4.0.5.0",
        ref = "@core_sdk//:core/packs/Microsoft.NETCore.App.Ref/3.1.0/ref/netcoreapp3.1/System.Text.Encodings.Web.dll",
        stdlib_path = "@core_sdk//:core/shared/Microsoft.NETCore.App/3.1.0/System.Text.Encodings.Web.dll",
        deps = [
            ":system.runtime.dll",
            ":system.runtime.extensions.dll",
        ],
    )
    core_stdlib_internal(
        name = "system.text.json.dll",
        version = "4.0.1.0",
        ref = "@core_sdk//:core/packs/Microsoft.NETCore.App.Ref/3.1.0/ref/netcoreapp3.1/System.Text.Json.dll",
        stdlib_path = "@core_sdk//:core/shared/Microsoft.NETCore.App/3.1.0/System.Text.Json.dll",
        deps = [
            ":system.runtime.dll",
            ":system.memory.dll",
            ":system.text.encodings.web.dll",
        ],
    )
    core_stdlib_internal(
        name = "system.text.regularexpressions.dll",
        version = "4.2.2.0",
        ref = "@core_sdk//:core/packs/Microsoft.NETCore.App.Ref/3.1.0/ref/netcoreapp3.1/System.Text.RegularExpressions.dll",
        stdlib_path = "@core_sdk//:core/shared/Microsoft.NETCore.App/3.1.0/System.Text.RegularExpressions.dll",
        deps = [
            ":system.runtime.dll",
            ":system.runtime.extensions.dll",
            ":system.reflection.emit.ilgeneration.dll",
        ],
    )
    core_stdlib_internal(
        name = "system.threading.channels.dll",
        version = "4.0.2.0",
        ref = "@core_sdk//:core/packs/Microsoft.NETCore.App.Ref/3.1.0/ref/netcoreapp3.1/System.Threading.Channels.dll",
        stdlib_path = "@core_sdk//:core/shared/Microsoft.NETCore.App/3.1.0/System.Threading.Channels.dll",
        deps = [
            ":system.runtime.dll",
        ],
    )
    core_stdlib_internal(
        name = "system.threading.dll",
        version = "4.1.2.0",
        ref = "@core_sdk//:core/packs/Microsoft.NETCore.App.Ref/3.1.0/ref/netcoreapp3.1/System.Threading.dll",
        stdlib_path = "@core_sdk//:core/shared/Microsoft.NETCore.App/3.1.0/System.Threading.dll",
        deps = [
            ":system.runtime.dll",
        ],
    )
    core_stdlib_internal(
        name = "system.threading.overlapped.dll",
        version = "4.1.2.0",
        ref = "@core_sdk//:core/packs/Microsoft.NETCore.App.Ref/3.1.0/ref/netcoreapp3.1/System.Threading.Overlapped.dll",
        stdlib_path = "@core_sdk//:core/shared/Microsoft.NETCore.App/3.1.0/System.Threading.Overlapped.dll",
        deps = [
            ":system.runtime.dll",
        ],
    )
    core_stdlib_internal(
        name = "system.threading.tasks.dataflow.dll",
        version = "4.6.5.0",
        ref = "@core_sdk//:core/packs/Microsoft.NETCore.App.Ref/3.1.0/ref/netcoreapp3.1/System.Threading.Tasks.Dataflow.dll",
        stdlib_path = "@core_sdk//:core/shared/Microsoft.NETCore.App/3.1.0/System.Threading.Tasks.Dataflow.dll",
        deps = [
            ":netstandard.dll",
        ],
    )
    core_stdlib_internal(
        name = "system.threading.tasks.dll",
        version = "4.1.2.0",
        ref = "@core_sdk//:core/packs/Microsoft.NETCore.App.Ref/3.1.0/ref/netcoreapp3.1/System.Threading.Tasks.dll",
        stdlib_path = "@core_sdk//:core/shared/Microsoft.NETCore.App/3.1.0/System.Threading.Tasks.dll",
        deps = [
            ":system.runtime.dll",
        ],
    )
    core_stdlib_internal(
        name = "system.threading.tasks.extensions.dll",
        version = "4.3.1.0",
        ref = "@core_sdk//:core/packs/Microsoft.NETCore.App.Ref/3.1.0/ref/netcoreapp3.1/System.Threading.Tasks.Extensions.dll",
        stdlib_path = "@core_sdk//:core/shared/Microsoft.NETCore.App/3.1.0/System.Threading.Tasks.Extensions.dll",
        deps = [
            ":system.runtime.dll",
        ],
    )
    core_stdlib_internal(
        name = "system.threading.tasks.parallel.dll",
        version = "4.0.4.0",
        ref = "@core_sdk//:core/packs/Microsoft.NETCore.App.Ref/3.1.0/ref/netcoreapp3.1/System.Threading.Tasks.Parallel.dll",
        stdlib_path = "@core_sdk//:core/shared/Microsoft.NETCore.App/3.1.0/System.Threading.Tasks.Parallel.dll",
        deps = [
            ":system.runtime.dll",
            ":system.collections.concurrent.dll",
        ],
    )
    core_stdlib_internal(
        name = "system.threading.thread.dll",
        version = "4.1.2.0",
        ref = "@core_sdk//:core/packs/Microsoft.NETCore.App.Ref/3.1.0/ref/netcoreapp3.1/System.Threading.Thread.dll",
        stdlib_path = "@core_sdk//:core/shared/Microsoft.NETCore.App/3.1.0/System.Threading.Thread.dll",
        deps = [
            ":system.runtime.dll",
            ":system.threading.dll",
            ":system.security.principal.dll",
            ":system.runtime.extensions.dll",
        ],
    )
    core_stdlib_internal(
        name = "system.threading.threadpool.dll",
        version = "4.1.2.0",
        ref = "@core_sdk//:core/packs/Microsoft.NETCore.App.Ref/3.1.0/ref/netcoreapp3.1/System.Threading.ThreadPool.dll",
        stdlib_path = "@core_sdk//:core/shared/Microsoft.NETCore.App/3.1.0/System.Threading.ThreadPool.dll",
        deps = [
            ":system.runtime.dll",
            ":system.threading.overlapped.dll",
        ],
    )
    core_stdlib_internal(
        name = "system.threading.timer.dll",
        version = "4.1.2.0",
        ref = "@core_sdk//:core/packs/Microsoft.NETCore.App.Ref/3.1.0/ref/netcoreapp3.1/System.Threading.Timer.dll",
        stdlib_path = "@core_sdk//:core/shared/Microsoft.NETCore.App/3.1.0/System.Threading.Timer.dll",
        deps = [
            ":system.runtime.dll",
        ],
    )
    core_stdlib_internal(
        name = "system.transactions.dll",
        version = "4.0.0.0",
        ref = "@core_sdk//:core/packs/Microsoft.NETCore.App.Ref/3.1.0/ref/netcoreapp3.1/System.Transactions.dll",
        stdlib_path = "@core_sdk//:core/shared/Microsoft.NETCore.App/3.1.0/System.Transactions.dll",
        deps = [
            ":system.runtime.dll",
            ":system.transactions.local.dll",
        ],
    )
    core_stdlib_internal(
        name = "system.transactions.local.dll",
        version = "4.0.2.0",
        ref = "@core_sdk//:core/packs/Microsoft.NETCore.App.Ref/3.1.0/ref/netcoreapp3.1/System.Transactions.Local.dll",
        stdlib_path = "@core_sdk//:core/shared/Microsoft.NETCore.App/3.1.0/System.Transactions.Local.dll",
        deps = [
            ":system.runtime.dll",
            ":system.runtime.interopservices.dll",
        ],
    )
    core_stdlib_internal(
        name = "system.valuetuple.dll",
        version = "4.0.3.0",
        ref = "@core_sdk//:core/packs/Microsoft.NETCore.App.Ref/3.1.0/ref/netcoreapp3.1/System.ValueTuple.dll",
        stdlib_path = "@core_sdk//:core/shared/Microsoft.NETCore.App/3.1.0/System.ValueTuple.dll",
        deps = [
            ":system.runtime.dll",
        ],
    )
    core_stdlib_internal(
        name = "system.web.dll",
        version = "4.0.0.0",
        ref = "@core_sdk//:core/packs/Microsoft.NETCore.App.Ref/3.1.0/ref/netcoreapp3.1/System.Web.dll",
        stdlib_path = "@core_sdk//:core/shared/Microsoft.NETCore.App/3.1.0/System.Web.dll",
        deps = [
            ":system.runtime.dll",
            ":system.web.httputility.dll",
        ],
    )
    core_stdlib_internal(
        name = "system.web.httputility.dll",
        version = "4.0.2.0",
        ref = "@core_sdk//:core/packs/Microsoft.NETCore.App.Ref/3.1.0/ref/netcoreapp3.1/System.Web.HttpUtility.dll",
        stdlib_path = "@core_sdk//:core/shared/Microsoft.NETCore.App/3.1.0/System.Web.HttpUtility.dll",
        deps = [
            ":system.runtime.dll",
            ":system.runtime.extensions.dll",
            ":system.collections.specialized.dll",
        ],
    )
    core_stdlib_internal(
        name = "system.windows.dll",
        version = "4.0.0.0",
        ref = "@core_sdk//:core/packs/Microsoft.NETCore.App.Ref/3.1.0/ref/netcoreapp3.1/System.Windows.dll",
        stdlib_path = "@core_sdk//:core/shared/Microsoft.NETCore.App/3.1.0/System.Windows.dll",
        deps = [
            ":system.runtime.dll",
            ":system.objectmodel.dll",
        ],
    )
    core_stdlib_internal(
        name = "system.xml.dll",
        version = "4.0.0.0",
        ref = "@core_sdk//:core/packs/Microsoft.NETCore.App.Ref/3.1.0/ref/netcoreapp3.1/System.Xml.dll",
        stdlib_path = "@core_sdk//:core/shared/Microsoft.NETCore.App/3.1.0/System.Xml.dll",
        deps = [
            ":system.runtime.dll",
            ":system.xml.readerwriter.dll",
            ":system.xml.xmlserializer.dll",
            ":system.xml.xpath.dll",
        ],
    )
    core_stdlib_internal(
        name = "system.xml.linq.dll",
        version = "4.0.0.0",
        ref = "@core_sdk//:core/packs/Microsoft.NETCore.App.Ref/3.1.0/ref/netcoreapp3.1/System.Xml.Linq.dll",
        stdlib_path = "@core_sdk//:core/shared/Microsoft.NETCore.App/3.1.0/System.Xml.Linq.dll",
        deps = [
            ":system.runtime.dll",
            ":system.xml.xdocument.dll",
            ":system.xml.xpath.xdocument.dll",
        ],
    )
    core_stdlib_internal(
        name = "system.xml.readerwriter.dll",
        version = "4.2.2.0",
        ref = "@core_sdk//:core/packs/Microsoft.NETCore.App.Ref/3.1.0/ref/netcoreapp3.1/System.Xml.ReaderWriter.dll",
        stdlib_path = "@core_sdk//:core/shared/Microsoft.NETCore.App/3.1.0/System.Xml.ReaderWriter.dll",
        deps = [
            ":system.runtime.dll",
            ":system.runtime.extensions.dll",
            ":system.diagnostics.debug.dll",
            ":system.net.primitives.dll",
            ":system.collections.nongeneric.dll",
        ],
    )
    core_stdlib_internal(
        name = "system.xml.serialization.dll",
        version = "4.0.0.0",
        ref = "@core_sdk//:core/packs/Microsoft.NETCore.App.Ref/3.1.0/ref/netcoreapp3.1/System.Xml.Serialization.dll",
        stdlib_path = "@core_sdk//:core/shared/Microsoft.NETCore.App/3.1.0/System.Xml.Serialization.dll",
        deps = [
            ":system.runtime.dll",
            ":system.xml.readerwriter.dll",
            ":system.xml.xmlserializer.dll",
        ],
    )
    core_stdlib_internal(
        name = "system.xml.xdocument.dll",
        version = "4.1.2.0",
        ref = "@core_sdk//:core/packs/Microsoft.NETCore.App.Ref/3.1.0/ref/netcoreapp3.1/System.Xml.XDocument.dll",
        stdlib_path = "@core_sdk//:core/shared/Microsoft.NETCore.App/3.1.0/System.Xml.XDocument.dll",
        deps = [
            ":system.runtime.dll",
            ":system.xml.readerwriter.dll",
            ":system.runtime.extensions.dll",
        ],
    )
    core_stdlib_internal(
        name = "system.xml.xmldocument.dll",
        version = "4.1.2.0",
        ref = "@core_sdk//:core/packs/Microsoft.NETCore.App.Ref/3.1.0/ref/netcoreapp3.1/System.Xml.XmlDocument.dll",
        stdlib_path = "@core_sdk//:core/shared/Microsoft.NETCore.App/3.1.0/System.Xml.XmlDocument.dll",
        deps = [
            ":system.runtime.dll",
            ":system.xml.readerwriter.dll",
        ],
    )
    core_stdlib_internal(
        name = "system.xml.xmlserializer.dll",
        version = "4.1.2.0",
        ref = "@core_sdk//:core/packs/Microsoft.NETCore.App.Ref/3.1.0/ref/netcoreapp3.1/System.Xml.XmlSerializer.dll",
        stdlib_path = "@core_sdk//:core/shared/Microsoft.NETCore.App/3.1.0/System.Xml.XmlSerializer.dll",
        deps = [
            ":system.runtime.dll",
            ":system.collections.specialized.dll",
            ":system.xml.readerwriter.dll",
            ":system.collections.nongeneric.dll",
            ":system.runtime.extensions.dll",
        ],
    )
    core_stdlib_internal(
        name = "system.xml.xpath.dll",
        version = "4.1.2.0",
        ref = "@core_sdk//:core/packs/Microsoft.NETCore.App.Ref/3.1.0/ref/netcoreapp3.1/System.Xml.XPath.dll",
        stdlib_path = "@core_sdk//:core/shared/Microsoft.NETCore.App/3.1.0/System.Xml.XPath.dll",
        deps = [
            ":system.runtime.dll",
            ":system.xml.readerwriter.dll",
            ":system.runtime.extensions.dll",
        ],
    )
    core_stdlib_internal(
        name = "system.xml.xpath.xdocument.dll",
        version = "4.1.2.0",
        ref = "@core_sdk//:core/packs/Microsoft.NETCore.App.Ref/3.1.0/ref/netcoreapp3.1/System.Xml.XPath.XDocument.dll",
        stdlib_path = "@core_sdk//:core/shared/Microsoft.NETCore.App/3.1.0/System.Xml.XPath.XDocument.dll",
        deps = [
            ":system.runtime.dll",
            ":system.xml.readerwriter.dll",
            ":system.xml.xdocument.dll",
        ],
    )
    core_stdlib_internal(
        name = "windowsbase.dll",
        version = "4.0.0.0",
        ref = "@core_sdk//:core/packs/Microsoft.NETCore.App.Ref/3.1.0/ref/netcoreapp3.1/WindowsBase.dll",
        stdlib_path = "@core_sdk//:core/shared/Microsoft.NETCore.App/3.1.0/WindowsBase.dll",
        deps = [
            ":system.runtime.dll",
            ":system.objectmodel.dll",
        ],
    )
    core_libraryset(
        name = "Microsoft.AspNetCore.App",
        deps = [
            ":p1_microsoft.aspnetcore.antiforgery.dll",
            ":p1_microsoft.aspnetcore.authentication.abstractions.dll",
            ":p1_microsoft.aspnetcore.authentication.cookies.dll",
            ":p1_microsoft.aspnetcore.authentication.core.dll",
            ":p1_microsoft.aspnetcore.authentication.dll",
            ":p1_microsoft.aspnetcore.authentication.oauth.dll",
            ":p1_microsoft.aspnetcore.authorization.dll",
            ":p1_microsoft.aspnetcore.authorization.policy.dll",
            ":p1_microsoft.aspnetcore.components.authorization.dll",
            ":p1_microsoft.aspnetcore.components.dll",
            ":p1_microsoft.aspnetcore.components.forms.dll",
            ":p1_microsoft.aspnetcore.components.server.dll",
            ":p1_microsoft.aspnetcore.components.web.dll",
            ":p1_microsoft.aspnetcore.connections.abstractions.dll",
            ":p1_microsoft.aspnetcore.cookiepolicy.dll",
            ":p1_microsoft.aspnetcore.cors.dll",
            ":p1_microsoft.aspnetcore.cryptography.internal.dll",
            ":p1_microsoft.aspnetcore.cryptography.keyderivation.dll",
            ":p1_microsoft.aspnetcore.dataprotection.abstractions.dll",
            ":p1_microsoft.aspnetcore.dataprotection.dll",
            ":p1_microsoft.aspnetcore.dataprotection.extensions.dll",
            ":p1_microsoft.aspnetcore.diagnostics.abstractions.dll",
            ":p1_microsoft.aspnetcore.diagnostics.dll",
            ":p1_microsoft.aspnetcore.diagnostics.healthchecks.dll",
            ":p1_microsoft.aspnetcore.dll",
            ":p1_microsoft.aspnetcore.hostfiltering.dll",
            ":p1_microsoft.aspnetcore.hosting.abstractions.dll",
            ":p1_microsoft.aspnetcore.hosting.dll",
            ":p1_microsoft.aspnetcore.hosting.server.abstractions.dll",
            ":p1_microsoft.aspnetcore.html.abstractions.dll",
            ":p1_microsoft.aspnetcore.http.abstractions.dll",
            ":p1_microsoft.aspnetcore.http.connections.common.dll",
            ":p1_microsoft.aspnetcore.http.connections.dll",
            ":p1_microsoft.aspnetcore.http.dll",
            ":p1_microsoft.aspnetcore.http.extensions.dll",
            ":p1_microsoft.aspnetcore.http.features.dll",
            ":p1_microsoft.aspnetcore.httpoverrides.dll",
            ":p1_microsoft.aspnetcore.httpspolicy.dll",
            ":p1_microsoft.aspnetcore.identity.dll",
            ":p1_microsoft.aspnetcore.localization.dll",
            ":p1_microsoft.aspnetcore.localization.routing.dll",
            ":p1_microsoft.aspnetcore.metadata.dll",
            ":p1_microsoft.aspnetcore.mvc.abstractions.dll",
            ":p1_microsoft.aspnetcore.mvc.apiexplorer.dll",
            ":p1_microsoft.aspnetcore.mvc.core.dll",
            ":p1_microsoft.aspnetcore.mvc.cors.dll",
            ":p1_microsoft.aspnetcore.mvc.dataannotations.dll",
            ":p1_microsoft.aspnetcore.mvc.dll",
            ":p1_microsoft.aspnetcore.mvc.formatters.json.dll",
            ":p1_microsoft.aspnetcore.mvc.formatters.xml.dll",
            ":p1_microsoft.aspnetcore.mvc.localization.dll",
            ":p1_microsoft.aspnetcore.mvc.razor.dll",
            ":p1_microsoft.aspnetcore.mvc.razorpages.dll",
            ":p1_microsoft.aspnetcore.mvc.taghelpers.dll",
            ":p1_microsoft.aspnetcore.mvc.viewfeatures.dll",
            ":p1_microsoft.aspnetcore.razor.dll",
            ":p1_microsoft.aspnetcore.razor.runtime.dll",
            ":p1_microsoft.aspnetcore.responsecaching.abstractions.dll",
            ":p1_microsoft.aspnetcore.responsecaching.dll",
            ":p1_microsoft.aspnetcore.responsecompression.dll",
            ":p1_microsoft.aspnetcore.rewrite.dll",
            ":p1_microsoft.aspnetcore.routing.abstractions.dll",
            ":p1_microsoft.aspnetcore.routing.dll",
            ":p1_microsoft.aspnetcore.server.httpsys.dll",
            ":p1_microsoft.aspnetcore.server.iis.dll",
            ":p1_microsoft.aspnetcore.server.iisintegration.dll",
            ":p1_microsoft.aspnetcore.server.kestrel.core.dll",
            ":p1_microsoft.aspnetcore.server.kestrel.dll",
            ":p1_microsoft.aspnetcore.server.kestrel.transport.sockets.dll",
            ":p1_microsoft.aspnetcore.session.dll",
            ":p1_microsoft.aspnetcore.signalr.common.dll",
            ":p1_microsoft.aspnetcore.signalr.core.dll",
            ":p1_microsoft.aspnetcore.signalr.dll",
            ":p1_microsoft.aspnetcore.signalr.protocols.json.dll",
            ":p1_microsoft.aspnetcore.staticfiles.dll",
            ":p1_microsoft.aspnetcore.websockets.dll",
            ":p1_microsoft.aspnetcore.webutilities.dll",
            ":p1_microsoft.extensions.caching.abstractions.dll",
            ":p1_microsoft.extensions.caching.memory.dll",
            ":p1_microsoft.extensions.configuration.abstractions.dll",
            ":p1_microsoft.extensions.configuration.binder.dll",
            ":p1_microsoft.extensions.configuration.commandline.dll",
            ":p1_microsoft.extensions.configuration.dll",
            ":p1_microsoft.extensions.configuration.environmentvariables.dll",
            ":p1_microsoft.extensions.configuration.fileextensions.dll",
            ":p1_microsoft.extensions.configuration.ini.dll",
            ":p1_microsoft.extensions.configuration.json.dll",
            ":p1_microsoft.extensions.configuration.keyperfile.dll",
            ":p1_microsoft.extensions.configuration.usersecrets.dll",
            ":p1_microsoft.extensions.configuration.xml.dll",
            ":p1_microsoft.extensions.dependencyinjection.abstractions.dll",
            ":p1_microsoft.extensions.dependencyinjection.dll",
            ":p1_microsoft.extensions.diagnostics.healthchecks.abstractions.dll",
            ":p1_microsoft.extensions.diagnostics.healthchecks.dll",
            ":p1_microsoft.extensions.fileproviders.abstractions.dll",
            ":p1_microsoft.extensions.fileproviders.composite.dll",
            ":p1_microsoft.extensions.fileproviders.embedded.dll",
            ":p1_microsoft.extensions.fileproviders.physical.dll",
            ":p1_microsoft.extensions.filesystemglobbing.dll",
            ":p1_microsoft.extensions.hosting.abstractions.dll",
            ":p1_microsoft.extensions.hosting.dll",
            ":p1_microsoft.extensions.http.dll",
            ":p1_microsoft.extensions.identity.core.dll",
            ":p1_microsoft.extensions.identity.stores.dll",
            ":p1_microsoft.extensions.localization.abstractions.dll",
            ":p1_microsoft.extensions.localization.dll",
            ":p1_microsoft.extensions.logging.abstractions.dll",
            ":p1_microsoft.extensions.logging.configuration.dll",
            ":p1_microsoft.extensions.logging.console.dll",
            ":p1_microsoft.extensions.logging.debug.dll",
            ":p1_microsoft.extensions.logging.dll",
            ":p1_microsoft.extensions.logging.eventlog.dll",
            ":p1_microsoft.extensions.logging.eventsource.dll",
            ":p1_microsoft.extensions.logging.tracesource.dll",
            ":p1_microsoft.extensions.objectpool.dll",
            ":p1_microsoft.extensions.options.configurationextensions.dll",
            ":p1_microsoft.extensions.options.dataannotations.dll",
            ":p1_microsoft.extensions.options.dll",
            ":p1_microsoft.extensions.primitives.dll",
            ":p1_microsoft.extensions.webencoders.dll",
            ":p1_microsoft.jsinterop.dll",
            ":p1_microsoft.net.http.headers.dll",
            ":p1_microsoft.win32.registry.dll",
            ":p1_system.diagnostics.eventlog.dll",
            ":p1_system.io.pipelines.dll",
            ":p1_system.security.accesscontrol.dll",
            ":p1_system.security.cryptography.cng.dll",
            ":p1_system.security.cryptography.xml.dll",
            ":p1_system.security.permissions.dll",
            ":p1_system.security.principal.windows.dll",
            ":p1_system.windows.extensions.dll",
        ],
    )
    core_stdlib_internal(
        name = "p1_microsoft.aspnetcore.antiforgery.dll",
        version = "3.1.0.0",
        ref = "@core_sdk//:core/packs/Microsoft.AspNetCore.App.Ref/3.1.0/ref/netcoreapp3.1/Microsoft.AspNetCore.Antiforgery.dll",
        stdlib_path = "@core_sdk//:core/shared/Microsoft.AspNetCore.App/3.1.0/Microsoft.AspNetCore.Antiforgery.dll",
        deps = [
            ":p1_microsoft.extensions.dependencyinjection.abstractions.dll",
            ":p1_microsoft.aspnetcore.http.abstractions.dll",
        ],
    )
    core_stdlib_internal(
        name = "p1_microsoft.aspnetcore.authentication.abstractions.dll",
        version = "3.1.0.0",
        ref = "@core_sdk//:core/packs/Microsoft.AspNetCore.App.Ref/3.1.0/ref/netcoreapp3.1/Microsoft.AspNetCore.Authentication.Abstractions.dll",
        stdlib_path = "@core_sdk//:core/shared/Microsoft.AspNetCore.App/3.1.0/Microsoft.AspNetCore.Authentication.Abstractions.dll",
        deps = [
            ":p1_microsoft.aspnetcore.http.abstractions.dll",
        ],
    )
    core_stdlib_internal(
        name = "p1_microsoft.aspnetcore.authentication.cookies.dll",
        version = "3.1.0.0",
        ref = "@core_sdk//:core/packs/Microsoft.AspNetCore.App.Ref/3.1.0/ref/netcoreapp3.1/Microsoft.AspNetCore.Authentication.Cookies.dll",
        stdlib_path = "@core_sdk//:core/shared/Microsoft.AspNetCore.App/3.1.0/Microsoft.AspNetCore.Authentication.Cookies.dll",
        deps = [
            ":p1_microsoft.aspnetcore.authentication.dll",
            ":p1_microsoft.aspnetcore.http.abstractions.dll",
            ":p1_microsoft.aspnetcore.http.features.dll",
            ":p1_microsoft.extensions.options.dll",
            ":p1_microsoft.extensions.logging.abstractions.dll",
            ":p1_microsoft.aspnetcore.authentication.abstractions.dll",
            ":p1_microsoft.aspnetcore.dataprotection.abstractions.dll",
        ],
    )
    core_stdlib_internal(
        name = "p1_microsoft.aspnetcore.authentication.core.dll",
        version = "3.1.0.0",
        ref = "@core_sdk//:core/packs/Microsoft.AspNetCore.App.Ref/3.1.0/ref/netcoreapp3.1/Microsoft.AspNetCore.Authentication.Core.dll",
        stdlib_path = "@core_sdk//:core/shared/Microsoft.AspNetCore.App/3.1.0/Microsoft.AspNetCore.Authentication.Core.dll",
        deps = [
            ":p1_microsoft.extensions.dependencyinjection.abstractions.dll",
            ":p1_microsoft.aspnetcore.authentication.abstractions.dll",
            ":p1_microsoft.aspnetcore.http.abstractions.dll",
            ":p1_microsoft.extensions.options.dll",
        ],
    )
    core_stdlib_internal(
        name = "p1_microsoft.aspnetcore.authentication.dll",
        version = "3.1.0.0",
        ref = "@core_sdk//:core/packs/Microsoft.AspNetCore.App.Ref/3.1.0/ref/netcoreapp3.1/Microsoft.AspNetCore.Authentication.dll",
        stdlib_path = "@core_sdk//:core/shared/Microsoft.AspNetCore.App/3.1.0/Microsoft.AspNetCore.Authentication.dll",
        deps = [
            ":p1_microsoft.extensions.dependencyinjection.abstractions.dll",
            ":p1_microsoft.aspnetcore.authentication.abstractions.dll",
            ":p1_microsoft.aspnetcore.http.abstractions.dll",
            ":p1_microsoft.extensions.options.dll",
            ":p1_microsoft.extensions.logging.abstractions.dll",
            ":p1_microsoft.aspnetcore.dataprotection.abstractions.dll",
            ":p1_microsoft.aspnetcore.http.features.dll",
        ],
    )
    core_stdlib_internal(
        name = "p1_microsoft.aspnetcore.authentication.oauth.dll",
        version = "3.1.0.0",
        ref = "@core_sdk//:core/packs/Microsoft.AspNetCore.App.Ref/3.1.0/ref/netcoreapp3.1/Microsoft.AspNetCore.Authentication.OAuth.dll",
        stdlib_path = "@core_sdk//:core/shared/Microsoft.AspNetCore.App/3.1.0/Microsoft.AspNetCore.Authentication.OAuth.dll",
        deps = [
            ":p1_microsoft.aspnetcore.authentication.dll",
            ":p1_microsoft.extensions.options.dll",
            ":p1_microsoft.aspnetcore.dataprotection.abstractions.dll",
            ":p1_microsoft.aspnetcore.authentication.abstractions.dll",
            ":p1_microsoft.aspnetcore.http.abstractions.dll",
            ":p1_microsoft.extensions.logging.abstractions.dll",
        ],
    )
    core_stdlib_internal(
        name = "p1_microsoft.aspnetcore.authorization.dll",
        version = "3.1.0.0",
        ref = "@core_sdk//:core/packs/Microsoft.AspNetCore.App.Ref/3.1.0/ref/netcoreapp3.1/Microsoft.AspNetCore.Authorization.dll",
        stdlib_path = "@core_sdk//:core/shared/Microsoft.AspNetCore.App/3.1.0/Microsoft.AspNetCore.Authorization.dll",
        deps = [
            ":p1_microsoft.extensions.dependencyinjection.abstractions.dll",
            ":p1_microsoft.aspnetcore.metadata.dll",
            ":p1_microsoft.extensions.options.dll",
            ":p1_microsoft.extensions.logging.abstractions.dll",
        ],
    )
    core_stdlib_internal(
        name = "p1_microsoft.aspnetcore.authorization.policy.dll",
        version = "3.1.0.0",
        ref = "@core_sdk//:core/packs/Microsoft.AspNetCore.App.Ref/3.1.0/ref/netcoreapp3.1/Microsoft.AspNetCore.Authorization.Policy.dll",
        stdlib_path = "@core_sdk//:core/shared/Microsoft.AspNetCore.App/3.1.0/Microsoft.AspNetCore.Authorization.Policy.dll",
        deps = [
            ":p1_microsoft.extensions.dependencyinjection.abstractions.dll",
            ":p1_microsoft.aspnetcore.authorization.dll",
            ":p1_microsoft.aspnetcore.http.abstractions.dll",
            ":p1_microsoft.aspnetcore.metadata.dll",
            ":p1_microsoft.aspnetcore.authentication.abstractions.dll",
        ],
    )
    core_stdlib_internal(
        name = "p1_microsoft.aspnetcore.components.authorization.dll",
        version = "3.1.0.0",
        ref = "@core_sdk//:core/packs/Microsoft.AspNetCore.App.Ref/3.1.0/ref/netcoreapp3.1/Microsoft.AspNetCore.Components.Authorization.dll",
        stdlib_path = "@core_sdk//:core/shared/Microsoft.AspNetCore.App/3.1.0/Microsoft.AspNetCore.Components.Authorization.dll",
        deps = [
            ":p1_microsoft.aspnetcore.components.dll",
            ":p1_microsoft.aspnetcore.metadata.dll",
        ],
    )
    core_stdlib_internal(
        name = "p1_microsoft.aspnetcore.components.dll",
        version = "3.1.0.0",
        ref = "@core_sdk//:core/packs/Microsoft.AspNetCore.App.Ref/3.1.0/ref/netcoreapp3.1/Microsoft.AspNetCore.Components.dll",
        stdlib_path = "@core_sdk//:core/shared/Microsoft.AspNetCore.App/3.1.0/Microsoft.AspNetCore.Components.dll",
        deps = [
            ":p1_microsoft.extensions.logging.abstractions.dll",
        ],
    )
    core_stdlib_internal(
        name = "p1_microsoft.aspnetcore.components.forms.dll",
        version = "3.1.0.0",
        ref = "@core_sdk//:core/packs/Microsoft.AspNetCore.App.Ref/3.1.0/ref/netcoreapp3.1/Microsoft.AspNetCore.Components.Forms.dll",
        stdlib_path = "@core_sdk//:core/shared/Microsoft.AspNetCore.App/3.1.0/Microsoft.AspNetCore.Components.Forms.dll",
        deps = [
            ":p1_microsoft.aspnetcore.components.dll",
        ],
    )
    core_stdlib_internal(
        name = "p1_microsoft.aspnetcore.components.server.dll",
        version = "3.1.0.0",
        ref = "@core_sdk//:core/packs/Microsoft.AspNetCore.App.Ref/3.1.0/ref/netcoreapp3.1/Microsoft.AspNetCore.Components.Server.dll",
        stdlib_path = "@core_sdk//:core/shared/Microsoft.AspNetCore.App/3.1.0/Microsoft.AspNetCore.Components.Server.dll",
        deps = [
            ":p1_microsoft.extensions.dependencyinjection.abstractions.dll",
            ":p1_microsoft.aspnetcore.signalr.core.dll",
            ":p1_microsoft.extensions.logging.abstractions.dll",
            ":p1_microsoft.aspnetcore.components.authorization.dll",
            ":p1_microsoft.aspnetcore.http.abstractions.dll",
            ":p1_microsoft.aspnetcore.signalr.dll",
            ":p1_microsoft.aspnetcore.routing.dll",
            ":p1_microsoft.aspnetcore.http.connections.dll",
        ],
    )
    core_stdlib_internal(
        name = "p1_microsoft.aspnetcore.components.web.dll",
        version = "3.1.0.0",
        ref = "@core_sdk//:core/packs/Microsoft.AspNetCore.App.Ref/3.1.0/ref/netcoreapp3.1/Microsoft.AspNetCore.Components.Web.dll",
        stdlib_path = "@core_sdk//:core/shared/Microsoft.AspNetCore.App/3.1.0/Microsoft.AspNetCore.Components.Web.dll",
        deps = [
            ":p1_microsoft.aspnetcore.components.dll",
            ":p1_microsoft.aspnetcore.components.forms.dll",
        ],
    )
    core_stdlib_internal(
        name = "p1_microsoft.aspnetcore.connections.abstractions.dll",
        version = "3.1.0.0",
        ref = "@core_sdk//:core/packs/Microsoft.AspNetCore.App.Ref/3.1.0/ref/netcoreapp3.1/Microsoft.AspNetCore.Connections.Abstractions.dll",
        stdlib_path = "@core_sdk//:core/shared/Microsoft.AspNetCore.App/3.1.0/Microsoft.AspNetCore.Connections.Abstractions.dll",
        deps = [
            ":p1_microsoft.aspnetcore.http.features.dll",
            ":p1_system.io.pipelines.dll",
        ],
    )
    core_stdlib_internal(
        name = "p1_microsoft.aspnetcore.cookiepolicy.dll",
        version = "3.1.0.0",
        ref = "@core_sdk//:core/packs/Microsoft.AspNetCore.App.Ref/3.1.0/ref/netcoreapp3.1/Microsoft.AspNetCore.CookiePolicy.dll",
        stdlib_path = "@core_sdk//:core/shared/Microsoft.AspNetCore.App/3.1.0/Microsoft.AspNetCore.CookiePolicy.dll",
        deps = [
            ":p1_microsoft.aspnetcore.http.abstractions.dll",
            ":p1_microsoft.aspnetcore.http.features.dll",
            ":p1_microsoft.extensions.options.dll",
            ":p1_microsoft.extensions.logging.abstractions.dll",
        ],
    )
    core_stdlib_internal(
        name = "p1_microsoft.aspnetcore.cors.dll",
        version = "3.1.0.0",
        ref = "@core_sdk//:core/packs/Microsoft.AspNetCore.App.Ref/3.1.0/ref/netcoreapp3.1/Microsoft.AspNetCore.Cors.dll",
        stdlib_path = "@core_sdk//:core/shared/Microsoft.AspNetCore.App/3.1.0/Microsoft.AspNetCore.Cors.dll",
        deps = [
            ":p1_microsoft.extensions.dependencyinjection.abstractions.dll",
            ":p1_microsoft.aspnetcore.http.abstractions.dll",
            ":p1_microsoft.extensions.logging.abstractions.dll",
            ":p1_microsoft.extensions.options.dll",
        ],
    )
    core_stdlib_internal(
        name = "p1_microsoft.aspnetcore.cryptography.internal.dll",
        version = "3.1.0.0",
        ref = "@core_sdk//:core/packs/Microsoft.AspNetCore.App.Ref/3.1.0/ref/netcoreapp3.1/Microsoft.AspNetCore.Cryptography.Internal.dll",
        stdlib_path = "@core_sdk//:core/shared/Microsoft.AspNetCore.App/3.1.0/Microsoft.AspNetCore.Cryptography.Internal.dll",
        deps = [
        ],
    )
    core_stdlib_internal(
        name = "p1_microsoft.aspnetcore.cryptography.keyderivation.dll",
        version = "3.1.0.0",
        ref = "@core_sdk//:core/packs/Microsoft.AspNetCore.App.Ref/3.1.0/ref/netcoreapp3.1/Microsoft.AspNetCore.Cryptography.KeyDerivation.dll",
        stdlib_path = "@core_sdk//:core/shared/Microsoft.AspNetCore.App/3.1.0/Microsoft.AspNetCore.Cryptography.KeyDerivation.dll",
        deps = [
        ],
    )
    core_stdlib_internal(
        name = "p1_microsoft.aspnetcore.dataprotection.abstractions.dll",
        version = "3.1.0.0",
        ref = "@core_sdk//:core/packs/Microsoft.AspNetCore.App.Ref/3.1.0/ref/netcoreapp3.1/Microsoft.AspNetCore.DataProtection.Abstractions.dll",
        stdlib_path = "@core_sdk//:core/shared/Microsoft.AspNetCore.App/3.1.0/Microsoft.AspNetCore.DataProtection.Abstractions.dll",
        deps = [
        ],
    )
    core_stdlib_internal(
        name = "p1_microsoft.aspnetcore.dataprotection.dll",
        version = "3.1.0.0",
        ref = "@core_sdk//:core/packs/Microsoft.AspNetCore.App.Ref/3.1.0/ref/netcoreapp3.1/Microsoft.AspNetCore.DataProtection.dll",
        stdlib_path = "@core_sdk//:core/shared/Microsoft.AspNetCore.App/3.1.0/Microsoft.AspNetCore.DataProtection.dll",
        deps = [
            ":p1_microsoft.extensions.dependencyinjection.abstractions.dll",
            ":p1_microsoft.win32.registry.dll",
            ":p1_microsoft.aspnetcore.dataprotection.abstractions.dll",
            ":p1_microsoft.extensions.logging.abstractions.dll",
            ":p1_microsoft.extensions.options.dll",
        ],
    )
    core_stdlib_internal(
        name = "p1_microsoft.aspnetcore.dataprotection.extensions.dll",
        version = "3.1.0.0",
        ref = "@core_sdk//:core/packs/Microsoft.AspNetCore.App.Ref/3.1.0/ref/netcoreapp3.1/Microsoft.AspNetCore.DataProtection.Extensions.dll",
        stdlib_path = "@core_sdk//:core/shared/Microsoft.AspNetCore.App/3.1.0/Microsoft.AspNetCore.DataProtection.Extensions.dll",
        deps = [
            ":p1_microsoft.aspnetcore.dataprotection.abstractions.dll",
            ":p1_microsoft.aspnetcore.dataprotection.dll",
        ],
    )
    core_stdlib_internal(
        name = "p1_microsoft.aspnetcore.diagnostics.abstractions.dll",
        version = "3.1.0.0",
        ref = "@core_sdk//:core/packs/Microsoft.AspNetCore.App.Ref/3.1.0/ref/netcoreapp3.1/Microsoft.AspNetCore.Diagnostics.Abstractions.dll",
        stdlib_path = "@core_sdk//:core/shared/Microsoft.AspNetCore.App/3.1.0/Microsoft.AspNetCore.Diagnostics.Abstractions.dll",
        deps = [
            ":p1_microsoft.aspnetcore.http.abstractions.dll",
        ],
    )
    core_stdlib_internal(
        name = "p1_microsoft.aspnetcore.diagnostics.dll",
        version = "3.1.0.0",
        ref = "@core_sdk//:core/packs/Microsoft.AspNetCore.App.Ref/3.1.0/ref/netcoreapp3.1/Microsoft.AspNetCore.Diagnostics.dll",
        stdlib_path = "@core_sdk//:core/shared/Microsoft.AspNetCore.App/3.1.0/Microsoft.AspNetCore.Diagnostics.dll",
        deps = [
            ":p1_microsoft.aspnetcore.http.abstractions.dll",
            ":p1_microsoft.extensions.options.dll",
            ":p1_microsoft.extensions.logging.abstractions.dll",
            ":p1_microsoft.aspnetcore.hosting.abstractions.dll",
            ":p1_microsoft.aspnetcore.diagnostics.abstractions.dll",
            ":p1_microsoft.extensions.fileproviders.abstractions.dll",
        ],
    )
    core_stdlib_internal(
        name = "p1_microsoft.aspnetcore.diagnostics.healthchecks.dll",
        version = "3.1.0.0",
        ref = "@core_sdk//:core/packs/Microsoft.AspNetCore.App.Ref/3.1.0/ref/netcoreapp3.1/Microsoft.AspNetCore.Diagnostics.HealthChecks.dll",
        stdlib_path = "@core_sdk//:core/shared/Microsoft.AspNetCore.App/3.1.0/Microsoft.AspNetCore.Diagnostics.HealthChecks.dll",
        deps = [
            ":p1_microsoft.aspnetcore.http.abstractions.dll",
            ":p1_microsoft.extensions.options.dll",
            ":p1_microsoft.extensions.diagnostics.healthchecks.dll",
            ":p1_microsoft.extensions.diagnostics.healthchecks.abstractions.dll",
            ":p1_microsoft.aspnetcore.routing.dll",
        ],
    )
    core_stdlib_internal(
        name = "p1_microsoft.aspnetcore.dll",
        version = "3.1.0.0",
        ref = "@core_sdk//:core/packs/Microsoft.AspNetCore.App.Ref/3.1.0/ref/netcoreapp3.1/Microsoft.AspNetCore.dll",
        stdlib_path = "@core_sdk//:core/shared/Microsoft.AspNetCore.App/3.1.0/Microsoft.AspNetCore.dll",
        deps = [
            ":p1_microsoft.extensions.hosting.abstractions.dll",
            ":p1_microsoft.aspnetcore.hosting.abstractions.dll",
            ":p1_microsoft.aspnetcore.http.abstractions.dll",
            ":p1_microsoft.aspnetcore.routing.dll",
        ],
    )
    core_stdlib_internal(
        name = "p1_microsoft.aspnetcore.hostfiltering.dll",
        version = "3.1.0.0",
        ref = "@core_sdk//:core/packs/Microsoft.AspNetCore.App.Ref/3.1.0/ref/netcoreapp3.1/Microsoft.AspNetCore.HostFiltering.dll",
        stdlib_path = "@core_sdk//:core/shared/Microsoft.AspNetCore.App/3.1.0/Microsoft.AspNetCore.HostFiltering.dll",
        deps = [
            ":p1_microsoft.aspnetcore.http.abstractions.dll",
            ":p1_microsoft.extensions.logging.abstractions.dll",
            ":p1_microsoft.extensions.options.dll",
            ":p1_microsoft.extensions.dependencyinjection.abstractions.dll",
        ],
    )
    core_stdlib_internal(
        name = "p1_microsoft.aspnetcore.hosting.abstractions.dll",
        version = "3.1.0.0",
        ref = "@core_sdk//:core/packs/Microsoft.AspNetCore.App.Ref/3.1.0/ref/netcoreapp3.1/Microsoft.AspNetCore.Hosting.Abstractions.dll",
        stdlib_path = "@core_sdk//:core/shared/Microsoft.AspNetCore.App/3.1.0/Microsoft.AspNetCore.Hosting.Abstractions.dll",
        deps = [
            ":p1_microsoft.extensions.configuration.abstractions.dll",
            ":p1_microsoft.aspnetcore.hosting.server.abstractions.dll",
            ":p1_microsoft.extensions.fileproviders.abstractions.dll",
            ":p1_microsoft.aspnetcore.http.abstractions.dll",
            ":p1_microsoft.extensions.dependencyinjection.abstractions.dll",
            ":p1_microsoft.aspnetcore.http.features.dll",
            ":p1_microsoft.extensions.hosting.abstractions.dll",
        ],
    )
    core_stdlib_internal(
        name = "p1_microsoft.aspnetcore.hosting.dll",
        version = "3.1.0.0",
        ref = "@core_sdk//:core/packs/Microsoft.AspNetCore.App.Ref/3.1.0/ref/netcoreapp3.1/Microsoft.AspNetCore.Hosting.dll",
        stdlib_path = "@core_sdk//:core/shared/Microsoft.AspNetCore.App/3.1.0/Microsoft.AspNetCore.Hosting.dll",
        deps = [
            ":p1_microsoft.aspnetcore.http.abstractions.dll",
            ":p1_microsoft.aspnetcore.http.features.dll",
            ":p1_microsoft.extensions.dependencyinjection.abstractions.dll",
            ":p1_microsoft.aspnetcore.hosting.abstractions.dll",
            ":p1_microsoft.extensions.configuration.abstractions.dll",
            ":p1_microsoft.extensions.logging.dll",
            ":p1_microsoft.extensions.dependencyinjection.dll",
            ":p1_microsoft.aspnetcore.hosting.server.abstractions.dll",
            ":p1_microsoft.extensions.hosting.abstractions.dll",
        ],
    )
    core_stdlib_internal(
        name = "p1_microsoft.aspnetcore.hosting.server.abstractions.dll",
        version = "3.1.0.0",
        ref = "@core_sdk//:core/packs/Microsoft.AspNetCore.App.Ref/3.1.0/ref/netcoreapp3.1/Microsoft.AspNetCore.Hosting.Server.Abstractions.dll",
        stdlib_path = "@core_sdk//:core/shared/Microsoft.AspNetCore.App/3.1.0/Microsoft.AspNetCore.Hosting.Server.Abstractions.dll",
        deps = [
            ":p1_microsoft.aspnetcore.http.features.dll",
        ],
    )
    core_stdlib_internal(
        name = "p1_microsoft.aspnetcore.html.abstractions.dll",
        version = "3.1.0.0",
        ref = "@core_sdk//:core/packs/Microsoft.AspNetCore.App.Ref/3.1.0/ref/netcoreapp3.1/Microsoft.AspNetCore.Html.Abstractions.dll",
        stdlib_path = "@core_sdk//:core/shared/Microsoft.AspNetCore.App/3.1.0/Microsoft.AspNetCore.Html.Abstractions.dll",
        deps = [
        ],
    )
    core_stdlib_internal(
        name = "p1_microsoft.aspnetcore.http.abstractions.dll",
        version = "3.1.0.0",
        ref = "@core_sdk//:core/packs/Microsoft.AspNetCore.App.Ref/3.1.0/ref/netcoreapp3.1/Microsoft.AspNetCore.Http.Abstractions.dll",
        stdlib_path = "@core_sdk//:core/shared/Microsoft.AspNetCore.App/3.1.0/Microsoft.AspNetCore.Http.Abstractions.dll",
        deps = [
            ":p1_microsoft.aspnetcore.http.features.dll",
            ":p1_microsoft.extensions.primitives.dll",
            ":p1_system.io.pipelines.dll",
        ],
    )
    core_stdlib_internal(
        name = "p1_microsoft.aspnetcore.http.connections.common.dll",
        version = "3.1.0.0",
        ref = "@core_sdk//:core/packs/Microsoft.AspNetCore.App.Ref/3.1.0/ref/netcoreapp3.1/Microsoft.AspNetCore.Http.Connections.Common.dll",
        stdlib_path = "@core_sdk//:core/shared/Microsoft.AspNetCore.App/3.1.0/Microsoft.AspNetCore.Http.Connections.Common.dll",
        deps = [
        ],
    )
    core_stdlib_internal(
        name = "p1_microsoft.aspnetcore.http.connections.dll",
        version = "3.1.0.0",
        ref = "@core_sdk//:core/packs/Microsoft.AspNetCore.App.Ref/3.1.0/ref/netcoreapp3.1/Microsoft.AspNetCore.Http.Connections.dll",
        stdlib_path = "@core_sdk//:core/shared/Microsoft.AspNetCore.App/3.1.0/Microsoft.AspNetCore.Http.Connections.dll",
        deps = [
            ":p1_microsoft.extensions.options.dll",
            ":p1_microsoft.aspnetcore.connections.abstractions.dll",
            ":p1_microsoft.aspnetcore.http.abstractions.dll",
            ":p1_microsoft.aspnetcore.metadata.dll",
            ":p1_microsoft.aspnetcore.http.connections.common.dll",
            ":p1_microsoft.aspnetcore.routing.dll",
            ":p1_microsoft.extensions.dependencyinjection.abstractions.dll",
        ],
    )
    core_stdlib_internal(
        name = "p1_microsoft.aspnetcore.http.dll",
        version = "3.1.0.0",
        ref = "@core_sdk//:core/packs/Microsoft.AspNetCore.App.Ref/3.1.0/ref/netcoreapp3.1/Microsoft.AspNetCore.Http.dll",
        stdlib_path = "@core_sdk//:core/shared/Microsoft.AspNetCore.App/3.1.0/Microsoft.AspNetCore.Http.dll",
        deps = [
            ":p1_microsoft.extensions.dependencyinjection.abstractions.dll",
            ":p1_microsoft.aspnetcore.http.abstractions.dll",
            ":p1_microsoft.aspnetcore.http.features.dll",
            ":p1_microsoft.extensions.primitives.dll",
            ":p1_microsoft.extensions.options.dll",
            ":p1_system.io.pipelines.dll",
            ":p1_microsoft.extensions.objectpool.dll",
        ],
    )
    core_stdlib_internal(
        name = "p1_microsoft.aspnetcore.http.extensions.dll",
        version = "3.1.0.0",
        ref = "@core_sdk//:core/packs/Microsoft.AspNetCore.App.Ref/3.1.0/ref/netcoreapp3.1/Microsoft.AspNetCore.Http.Extensions.dll",
        stdlib_path = "@core_sdk//:core/shared/Microsoft.AspNetCore.App/3.1.0/Microsoft.AspNetCore.Http.Extensions.dll",
        deps = [
            ":p1_microsoft.aspnetcore.http.features.dll",
            ":p1_microsoft.aspnetcore.http.abstractions.dll",
            ":p1_microsoft.extensions.fileproviders.abstractions.dll",
            ":p1_microsoft.net.http.headers.dll",
        ],
    )
    core_stdlib_internal(
        name = "p1_microsoft.aspnetcore.http.features.dll",
        version = "3.1.0.0",
        ref = "@core_sdk//:core/packs/Microsoft.AspNetCore.App.Ref/3.1.0/ref/netcoreapp3.1/Microsoft.AspNetCore.Http.Features.dll",
        stdlib_path = "@core_sdk//:core/shared/Microsoft.AspNetCore.App/3.1.0/Microsoft.AspNetCore.Http.Features.dll",
        deps = [
            ":p1_microsoft.extensions.primitives.dll",
            ":p1_system.io.pipelines.dll",
        ],
    )
    core_stdlib_internal(
        name = "p1_microsoft.aspnetcore.httpoverrides.dll",
        version = "3.1.0.0",
        ref = "@core_sdk//:core/packs/Microsoft.AspNetCore.App.Ref/3.1.0/ref/netcoreapp3.1/Microsoft.AspNetCore.HttpOverrides.dll",
        stdlib_path = "@core_sdk//:core/shared/Microsoft.AspNetCore.App/3.1.0/Microsoft.AspNetCore.HttpOverrides.dll",
        deps = [
            ":p1_microsoft.extensions.dependencyinjection.abstractions.dll",
            ":p1_microsoft.aspnetcore.http.abstractions.dll",
            ":p1_microsoft.extensions.logging.abstractions.dll",
            ":p1_microsoft.extensions.options.dll",
        ],
    )
    core_stdlib_internal(
        name = "p1_microsoft.aspnetcore.httpspolicy.dll",
        version = "3.1.0.0",
        ref = "@core_sdk//:core/packs/Microsoft.AspNetCore.App.Ref/3.1.0/ref/netcoreapp3.1/Microsoft.AspNetCore.HttpsPolicy.dll",
        stdlib_path = "@core_sdk//:core/shared/Microsoft.AspNetCore.App/3.1.0/Microsoft.AspNetCore.HttpsPolicy.dll",
        deps = [
            ":p1_microsoft.aspnetcore.http.abstractions.dll",
            ":p1_microsoft.extensions.options.dll",
            ":p1_microsoft.extensions.logging.abstractions.dll",
            ":p1_microsoft.extensions.configuration.abstractions.dll",
            ":p1_microsoft.aspnetcore.hosting.server.abstractions.dll",
            ":p1_microsoft.extensions.dependencyinjection.abstractions.dll",
        ],
    )
    core_stdlib_internal(
        name = "p1_microsoft.aspnetcore.identity.dll",
        version = "3.1.0.0",
        ref = "@core_sdk//:core/packs/Microsoft.AspNetCore.App.Ref/3.1.0/ref/netcoreapp3.1/Microsoft.AspNetCore.Identity.dll",
        stdlib_path = "@core_sdk//:core/shared/Microsoft.AspNetCore.App/3.1.0/Microsoft.AspNetCore.Identity.dll",
        deps = [
            ":p1_microsoft.extensions.identity.core.dll",
            ":p1_microsoft.extensions.dependencyinjection.abstractions.dll",
            ":p1_microsoft.aspnetcore.authentication.cookies.dll",
            ":p1_microsoft.extensions.logging.abstractions.dll",
            ":p1_microsoft.aspnetcore.http.abstractions.dll",
            ":p1_microsoft.extensions.options.dll",
            ":p1_microsoft.aspnetcore.dataprotection.abstractions.dll",
            ":p1_microsoft.aspnetcore.authentication.abstractions.dll",
            ":p1_microsoft.aspnetcore.authentication.dll",
        ],
    )
    core_stdlib_internal(
        name = "p1_microsoft.aspnetcore.localization.dll",
        version = "3.1.0.0",
        ref = "@core_sdk//:core/packs/Microsoft.AspNetCore.App.Ref/3.1.0/ref/netcoreapp3.1/Microsoft.AspNetCore.Localization.dll",
        stdlib_path = "@core_sdk//:core/shared/Microsoft.AspNetCore.App/3.1.0/Microsoft.AspNetCore.Localization.dll",
        deps = [
            ":p1_microsoft.aspnetcore.http.abstractions.dll",
            ":p1_microsoft.extensions.primitives.dll",
            ":p1_microsoft.extensions.options.dll",
            ":p1_microsoft.extensions.dependencyinjection.abstractions.dll",
            ":p1_microsoft.extensions.logging.abstractions.dll",
        ],
    )
    core_stdlib_internal(
        name = "p1_microsoft.aspnetcore.localization.routing.dll",
        version = "3.1.0.0",
        ref = "@core_sdk//:core/packs/Microsoft.AspNetCore.App.Ref/3.1.0/ref/netcoreapp3.1/Microsoft.AspNetCore.Localization.Routing.dll",
        stdlib_path = "@core_sdk//:core/shared/Microsoft.AspNetCore.App/3.1.0/Microsoft.AspNetCore.Localization.Routing.dll",
        deps = [
            ":p1_microsoft.aspnetcore.localization.dll",
            ":p1_microsoft.aspnetcore.http.abstractions.dll",
        ],
    )
    core_stdlib_internal(
        name = "p1_microsoft.aspnetcore.metadata.dll",
        version = "3.1.0.0",
        ref = "@core_sdk//:core/packs/Microsoft.AspNetCore.App.Ref/3.1.0/ref/netcoreapp3.1/Microsoft.AspNetCore.Metadata.dll",
        stdlib_path = "@core_sdk//:core/shared/Microsoft.AspNetCore.App/3.1.0/Microsoft.AspNetCore.Metadata.dll",
        deps = [
        ],
    )
    core_stdlib_internal(
        name = "p1_microsoft.aspnetcore.mvc.abstractions.dll",
        version = "3.1.0.0",
        ref = "@core_sdk//:core/packs/Microsoft.AspNetCore.App.Ref/3.1.0/ref/netcoreapp3.1/Microsoft.AspNetCore.Mvc.Abstractions.dll",
        stdlib_path = "@core_sdk//:core/shared/Microsoft.AspNetCore.App/3.1.0/Microsoft.AspNetCore.Mvc.Abstractions.dll",
        deps = [
            ":p1_microsoft.aspnetcore.http.abstractions.dll",
            ":p1_microsoft.aspnetcore.routing.abstractions.dll",
            ":p1_microsoft.extensions.primitives.dll",
        ],
    )
    core_stdlib_internal(
        name = "p1_microsoft.aspnetcore.mvc.apiexplorer.dll",
        version = "3.1.0.0",
        ref = "@core_sdk//:core/packs/Microsoft.AspNetCore.App.Ref/3.1.0/ref/netcoreapp3.1/Microsoft.AspNetCore.Mvc.ApiExplorer.dll",
        stdlib_path = "@core_sdk//:core/shared/Microsoft.AspNetCore.App/3.1.0/Microsoft.AspNetCore.Mvc.ApiExplorer.dll",
        deps = [
            ":p1_microsoft.aspnetcore.mvc.core.dll",
            ":p1_microsoft.aspnetcore.mvc.abstractions.dll",
            ":p1_microsoft.extensions.options.dll",
            ":p1_microsoft.aspnetcore.routing.dll",
        ],
    )
    core_stdlib_internal(
        name = "p1_microsoft.aspnetcore.mvc.core.dll",
        version = "3.1.0.0",
        ref = "@core_sdk//:core/packs/Microsoft.AspNetCore.App.Ref/3.1.0/ref/netcoreapp3.1/Microsoft.AspNetCore.Mvc.Core.dll",
        stdlib_path = "@core_sdk//:core/shared/Microsoft.AspNetCore.App/3.1.0/Microsoft.AspNetCore.Mvc.Core.dll",
        deps = [
            ":p1_microsoft.aspnetcore.routing.abstractions.dll",
            ":p1_microsoft.aspnetcore.http.abstractions.dll",
            ":p1_microsoft.aspnetcore.mvc.abstractions.dll",
            ":p1_microsoft.aspnetcore.authentication.abstractions.dll",
            ":p1_microsoft.net.http.headers.dll",
            ":p1_microsoft.extensions.fileproviders.abstractions.dll",
            ":p1_microsoft.aspnetcore.http.features.dll",
            ":p1_microsoft.extensions.primitives.dll",
            ":p1_microsoft.extensions.options.dll",
            ":p1_microsoft.extensions.logging.abstractions.dll",
            ":p1_microsoft.aspnetcore.hosting.abstractions.dll",
            ":p1_microsoft.aspnetcore.authorization.dll",
            ":p1_microsoft.aspnetcore.metadata.dll",
            ":p1_microsoft.aspnetcore.routing.dll",
            ":p1_microsoft.extensions.dependencyinjection.abstractions.dll",
        ],
    )
    core_stdlib_internal(
        name = "p1_microsoft.aspnetcore.mvc.cors.dll",
        version = "3.1.0.0",
        ref = "@core_sdk//:core/packs/Microsoft.AspNetCore.App.Ref/3.1.0/ref/netcoreapp3.1/Microsoft.AspNetCore.Mvc.Cors.dll",
        stdlib_path = "@core_sdk//:core/shared/Microsoft.AspNetCore.App/3.1.0/Microsoft.AspNetCore.Mvc.Cors.dll",
        deps = [
            ":p1_microsoft.aspnetcore.mvc.core.dll",
            ":p1_microsoft.aspnetcore.cors.dll",
            ":p1_microsoft.aspnetcore.mvc.abstractions.dll",
            ":p1_microsoft.extensions.logging.abstractions.dll",
        ],
    )
    core_stdlib_internal(
        name = "p1_microsoft.aspnetcore.mvc.dataannotations.dll",
        version = "3.1.0.0",
        ref = "@core_sdk//:core/packs/Microsoft.AspNetCore.App.Ref/3.1.0/ref/netcoreapp3.1/Microsoft.AspNetCore.Mvc.DataAnnotations.dll",
        stdlib_path = "@core_sdk//:core/shared/Microsoft.AspNetCore.App/3.1.0/Microsoft.AspNetCore.Mvc.DataAnnotations.dll",
        deps = [
            ":p1_microsoft.aspnetcore.mvc.core.dll",
            ":p1_microsoft.aspnetcore.mvc.abstractions.dll",
            ":p1_microsoft.extensions.localization.abstractions.dll",
        ],
    )
    core_stdlib_internal(
        name = "p1_microsoft.aspnetcore.mvc.dll",
        version = "3.1.0.0",
        ref = "@core_sdk//:core/packs/Microsoft.AspNetCore.App.Ref/3.1.0/ref/netcoreapp3.1/Microsoft.AspNetCore.Mvc.dll",
        stdlib_path = "@core_sdk//:core/shared/Microsoft.AspNetCore.App/3.1.0/Microsoft.AspNetCore.Mvc.dll",
        deps = [
            ":p1_microsoft.aspnetcore.mvc.core.dll",
            ":p1_microsoft.extensions.dependencyinjection.abstractions.dll",
            ":p1_microsoft.aspnetcore.mvc.razorpages.dll",
        ],
    )
    core_stdlib_internal(
        name = "p1_microsoft.aspnetcore.mvc.formatters.json.dll",
        version = "3.1.0.0",
        ref = "@core_sdk//:core/packs/Microsoft.AspNetCore.App.Ref/3.1.0/ref/netcoreapp3.1/Microsoft.AspNetCore.Mvc.Formatters.Json.dll",
        stdlib_path = "@core_sdk//:core/shared/Microsoft.AspNetCore.App/3.1.0/Microsoft.AspNetCore.Mvc.Formatters.Json.dll",
        deps = [
            ":p1_microsoft.aspnetcore.mvc.core.dll",
        ],
    )
    core_stdlib_internal(
        name = "p1_microsoft.aspnetcore.mvc.formatters.xml.dll",
        version = "3.1.0.0",
        ref = "@core_sdk//:core/packs/Microsoft.AspNetCore.App.Ref/3.1.0/ref/netcoreapp3.1/Microsoft.AspNetCore.Mvc.Formatters.Xml.dll",
        stdlib_path = "@core_sdk//:core/shared/Microsoft.AspNetCore.App/3.1.0/Microsoft.AspNetCore.Mvc.Formatters.Xml.dll",
        deps = [
            ":p1_microsoft.aspnetcore.mvc.core.dll",
            ":p1_microsoft.aspnetcore.mvc.abstractions.dll",
            ":p1_microsoft.extensions.logging.abstractions.dll",
        ],
    )
    core_stdlib_internal(
        name = "p1_microsoft.aspnetcore.mvc.localization.dll",
        version = "3.1.0.0",
        ref = "@core_sdk//:core/packs/Microsoft.AspNetCore.App.Ref/3.1.0/ref/netcoreapp3.1/Microsoft.AspNetCore.Mvc.Localization.dll",
        stdlib_path = "@core_sdk//:core/shared/Microsoft.AspNetCore.App/3.1.0/Microsoft.AspNetCore.Mvc.Localization.dll",
        deps = [
            ":p1_microsoft.aspnetcore.mvc.core.dll",
            ":p1_microsoft.aspnetcore.mvc.razor.dll",
            ":p1_microsoft.aspnetcore.mvc.dataannotations.dll",
            ":p1_microsoft.extensions.localization.dll",
            ":p1_microsoft.extensions.localization.abstractions.dll",
            ":p1_microsoft.aspnetcore.html.abstractions.dll",
            ":p1_microsoft.aspnetcore.mvc.viewfeatures.dll",
            ":p1_microsoft.aspnetcore.hosting.abstractions.dll",
        ],
    )
    core_stdlib_internal(
        name = "p1_microsoft.aspnetcore.mvc.razor.dll",
        version = "3.1.0.0",
        ref = "@core_sdk//:core/packs/Microsoft.AspNetCore.App.Ref/3.1.0/ref/netcoreapp3.1/Microsoft.AspNetCore.Mvc.Razor.dll",
        stdlib_path = "@core_sdk//:core/shared/Microsoft.AspNetCore.App/3.1.0/Microsoft.AspNetCore.Mvc.Razor.dll",
        deps = [
            ":p1_microsoft.aspnetcore.mvc.core.dll",
            ":p1_microsoft.aspnetcore.razor.dll",
            ":p1_microsoft.aspnetcore.mvc.viewfeatures.dll",
            ":p1_microsoft.aspnetcore.html.abstractions.dll",
            ":p1_microsoft.aspnetcore.mvc.abstractions.dll",
            ":p1_microsoft.aspnetcore.http.abstractions.dll",
            ":p1_microsoft.aspnetcore.razor.runtime.dll",
            ":p1_microsoft.extensions.options.dll",
            ":p1_microsoft.extensions.logging.abstractions.dll",
            ":p1_microsoft.extensions.caching.abstractions.dll",
            ":p1_microsoft.extensions.primitives.dll",
        ],
    )
    core_stdlib_internal(
        name = "p1_microsoft.aspnetcore.mvc.razorpages.dll",
        version = "3.1.0.0",
        ref = "@core_sdk//:core/packs/Microsoft.AspNetCore.App.Ref/3.1.0/ref/netcoreapp3.1/Microsoft.AspNetCore.Mvc.RazorPages.dll",
        stdlib_path = "@core_sdk//:core/shared/Microsoft.AspNetCore.App/3.1.0/Microsoft.AspNetCore.Mvc.RazorPages.dll",
        deps = [
            ":p1_microsoft.aspnetcore.mvc.core.dll",
            ":p1_microsoft.aspnetcore.mvc.abstractions.dll",
            ":p1_microsoft.aspnetcore.http.abstractions.dll",
            ":p1_microsoft.aspnetcore.routing.dll",
            ":p1_microsoft.aspnetcore.mvc.viewfeatures.dll",
            ":p1_microsoft.aspnetcore.mvc.razor.dll",
            ":p1_microsoft.aspnetcore.routing.abstractions.dll",
            ":p1_microsoft.aspnetcore.authentication.abstractions.dll",
            ":p1_microsoft.net.http.headers.dll",
            ":p1_microsoft.extensions.options.dll",
            ":p1_microsoft.aspnetcore.html.abstractions.dll",
        ],
    )
    core_stdlib_internal(
        name = "p1_microsoft.aspnetcore.mvc.taghelpers.dll",
        version = "3.1.0.0",
        ref = "@core_sdk//:core/packs/Microsoft.AspNetCore.App.Ref/3.1.0/ref/netcoreapp3.1/Microsoft.AspNetCore.Mvc.TagHelpers.dll",
        stdlib_path = "@core_sdk//:core/shared/Microsoft.AspNetCore.App/3.1.0/Microsoft.AspNetCore.Mvc.TagHelpers.dll",
        deps = [
            ":p1_microsoft.aspnetcore.mvc.core.dll",
            ":p1_microsoft.aspnetcore.razor.dll",
            ":p1_microsoft.aspnetcore.mvc.viewfeatures.dll",
            ":p1_microsoft.extensions.caching.abstractions.dll",
            ":p1_microsoft.extensions.options.dll",
            ":p1_microsoft.aspnetcore.hosting.abstractions.dll",
            ":p1_microsoft.extensions.fileproviders.abstractions.dll",
            ":p1_microsoft.aspnetcore.http.abstractions.dll",
            ":p1_microsoft.aspnetcore.mvc.razor.dll",
            ":p1_microsoft.extensions.dependencyinjection.abstractions.dll",
            ":p1_microsoft.aspnetcore.html.abstractions.dll",
            ":p1_microsoft.extensions.logging.abstractions.dll",
        ],
    )
    core_stdlib_internal(
        name = "p1_microsoft.aspnetcore.mvc.viewfeatures.dll",
        version = "3.1.0.0",
        ref = "@core_sdk//:core/packs/Microsoft.AspNetCore.App.Ref/3.1.0/ref/netcoreapp3.1/Microsoft.AspNetCore.Mvc.ViewFeatures.dll",
        stdlib_path = "@core_sdk//:core/shared/Microsoft.AspNetCore.App/3.1.0/Microsoft.AspNetCore.Mvc.ViewFeatures.dll",
        deps = [
            ":p1_microsoft.aspnetcore.mvc.core.dll",
            ":p1_microsoft.aspnetcore.mvc.abstractions.dll",
            ":p1_microsoft.aspnetcore.http.abstractions.dll",
            ":p1_microsoft.aspnetcore.html.abstractions.dll",
            ":p1_microsoft.aspnetcore.routing.abstractions.dll",
            ":p1_microsoft.aspnetcore.antiforgery.dll",
            ":p1_microsoft.aspnetcore.dataprotection.abstractions.dll",
            ":p1_microsoft.extensions.logging.abstractions.dll",
            ":p1_microsoft.extensions.options.dll",
            ":p1_microsoft.aspnetcore.components.dll",
        ],
    )
    core_stdlib_internal(
        name = "p1_microsoft.aspnetcore.razor.dll",
        version = "3.1.0.0",
        ref = "@core_sdk//:core/packs/Microsoft.AspNetCore.App.Ref/3.1.0/ref/netcoreapp3.1/Microsoft.AspNetCore.Razor.dll",
        stdlib_path = "@core_sdk//:core/shared/Microsoft.AspNetCore.App/3.1.0/Microsoft.AspNetCore.Razor.dll",
        deps = [
            ":p1_microsoft.aspnetcore.html.abstractions.dll",
        ],
    )
    core_stdlib_internal(
        name = "p1_microsoft.aspnetcore.razor.runtime.dll",
        version = "3.1.0.0",
        ref = "@core_sdk//:core/packs/Microsoft.AspNetCore.App.Ref/3.1.0/ref/netcoreapp3.1/Microsoft.AspNetCore.Razor.Runtime.dll",
        stdlib_path = "@core_sdk//:core/shared/Microsoft.AspNetCore.App/3.1.0/Microsoft.AspNetCore.Razor.Runtime.dll",
        deps = [
            ":p1_microsoft.aspnetcore.razor.dll",
        ],
    )
    core_stdlib_internal(
        name = "p1_microsoft.aspnetcore.responsecaching.abstractions.dll",
        version = "3.1.0.0",
        ref = "@core_sdk//:core/packs/Microsoft.AspNetCore.App.Ref/3.1.0/ref/netcoreapp3.1/Microsoft.AspNetCore.ResponseCaching.Abstractions.dll",
        stdlib_path = "@core_sdk//:core/shared/Microsoft.AspNetCore.App/3.1.0/Microsoft.AspNetCore.ResponseCaching.Abstractions.dll",
        deps = [
        ],
    )
    core_stdlib_internal(
        name = "p1_microsoft.aspnetcore.responsecaching.dll",
        version = "3.1.0.0",
        ref = "@core_sdk//:core/packs/Microsoft.AspNetCore.App.Ref/3.1.0/ref/netcoreapp3.1/Microsoft.AspNetCore.ResponseCaching.dll",
        stdlib_path = "@core_sdk//:core/shared/Microsoft.AspNetCore.App/3.1.0/Microsoft.AspNetCore.ResponseCaching.dll",
        deps = [
            ":p1_microsoft.extensions.dependencyinjection.abstractions.dll",
            ":p1_microsoft.aspnetcore.responsecaching.abstractions.dll",
            ":p1_microsoft.aspnetcore.http.abstractions.dll",
            ":p1_microsoft.extensions.options.dll",
            ":p1_microsoft.extensions.logging.abstractions.dll",
            ":p1_microsoft.extensions.objectpool.dll",
        ],
    )
    core_stdlib_internal(
        name = "p1_microsoft.aspnetcore.responsecompression.dll",
        version = "3.1.0.0",
        ref = "@core_sdk//:core/packs/Microsoft.AspNetCore.App.Ref/3.1.0/ref/netcoreapp3.1/Microsoft.AspNetCore.ResponseCompression.dll",
        stdlib_path = "@core_sdk//:core/shared/Microsoft.AspNetCore.App/3.1.0/Microsoft.AspNetCore.ResponseCompression.dll",
        deps = [
            ":p1_microsoft.extensions.options.dll",
            ":p1_microsoft.aspnetcore.http.abstractions.dll",
            ":p1_microsoft.extensions.dependencyinjection.abstractions.dll",
        ],
    )
    core_stdlib_internal(
        name = "p1_microsoft.aspnetcore.rewrite.dll",
        version = "3.1.0.0",
        ref = "@core_sdk//:core/packs/Microsoft.AspNetCore.App.Ref/3.1.0/ref/netcoreapp3.1/Microsoft.AspNetCore.Rewrite.dll",
        stdlib_path = "@core_sdk//:core/shared/Microsoft.AspNetCore.App/3.1.0/Microsoft.AspNetCore.Rewrite.dll",
        deps = [
            ":p1_microsoft.extensions.fileproviders.abstractions.dll",
            ":p1_microsoft.aspnetcore.http.abstractions.dll",
            ":p1_microsoft.extensions.logging.abstractions.dll",
            ":p1_microsoft.aspnetcore.hosting.abstractions.dll",
            ":p1_microsoft.extensions.options.dll",
        ],
    )
    core_stdlib_internal(
        name = "p1_microsoft.aspnetcore.routing.abstractions.dll",
        version = "3.1.0.0",
        ref = "@core_sdk//:core/packs/Microsoft.AspNetCore.App.Ref/3.1.0/ref/netcoreapp3.1/Microsoft.AspNetCore.Routing.Abstractions.dll",
        stdlib_path = "@core_sdk//:core/shared/Microsoft.AspNetCore.App/3.1.0/Microsoft.AspNetCore.Routing.Abstractions.dll",
        deps = [
            ":p1_microsoft.aspnetcore.http.abstractions.dll",
        ],
    )
    core_stdlib_internal(
        name = "p1_microsoft.aspnetcore.routing.dll",
        version = "3.1.0.0",
        ref = "@core_sdk//:core/packs/Microsoft.AspNetCore.App.Ref/3.1.0/ref/netcoreapp3.1/Microsoft.AspNetCore.Routing.dll",
        stdlib_path = "@core_sdk//:core/shared/Microsoft.AspNetCore.App/3.1.0/Microsoft.AspNetCore.Routing.dll",
        deps = [
            ":p1_microsoft.aspnetcore.http.abstractions.dll",
            ":p1_microsoft.extensions.primitives.dll",
            ":p1_microsoft.extensions.options.dll",
            ":p1_microsoft.aspnetcore.routing.abstractions.dll",
            ":p1_microsoft.extensions.logging.abstractions.dll",
            ":p1_microsoft.extensions.dependencyinjection.abstractions.dll",
        ],
    )
    core_stdlib_internal(
        name = "p1_microsoft.aspnetcore.server.httpsys.dll",
        version = "3.1.0.0",
        ref = "@core_sdk//:core/packs/Microsoft.AspNetCore.App.Ref/3.1.0/ref/netcoreapp3.1/Microsoft.AspNetCore.Server.HttpSys.dll",
        stdlib_path = "@core_sdk//:core/shared/Microsoft.AspNetCore.App/3.1.0/Microsoft.AspNetCore.Server.HttpSys.dll",
        deps = [
            ":p1_microsoft.aspnetcore.hosting.abstractions.dll",
        ],
    )
    core_stdlib_internal(
        name = "p1_microsoft.aspnetcore.server.iis.dll",
        version = "3.1.0.0",
        ref = "@core_sdk//:core/packs/Microsoft.AspNetCore.App.Ref/3.1.0/ref/netcoreapp3.1/Microsoft.AspNetCore.Server.IIS.dll",
        stdlib_path = "@core_sdk//:core/shared/Microsoft.AspNetCore.App/3.1.0/Microsoft.AspNetCore.Server.IIS.dll",
        deps = [
            ":p1_microsoft.aspnetcore.http.abstractions.dll",
            ":p1_microsoft.aspnetcore.authentication.abstractions.dll",
            ":p1_microsoft.aspnetcore.hosting.abstractions.dll",
            ":p1_microsoft.aspnetcore.http.features.dll",
        ],
    )
    core_stdlib_internal(
        name = "p1_microsoft.aspnetcore.server.iisintegration.dll",
        version = "3.1.0.0",
        ref = "@core_sdk//:core/packs/Microsoft.AspNetCore.App.Ref/3.1.0/ref/netcoreapp3.1/Microsoft.AspNetCore.Server.IISIntegration.dll",
        stdlib_path = "@core_sdk//:core/shared/Microsoft.AspNetCore.App/3.1.0/Microsoft.AspNetCore.Server.IISIntegration.dll",
        deps = [
            ":p1_microsoft.aspnetcore.hosting.abstractions.dll",
            ":p1_microsoft.aspnetcore.http.abstractions.dll",
            ":p1_microsoft.extensions.logging.abstractions.dll",
            ":p1_microsoft.extensions.options.dll",
            ":p1_microsoft.aspnetcore.authentication.abstractions.dll",
            ":p1_microsoft.extensions.hosting.abstractions.dll",
        ],
    )
    core_stdlib_internal(
        name = "p1_microsoft.aspnetcore.server.kestrel.core.dll",
        version = "3.1.0.0",
        ref = "@core_sdk//:core/packs/Microsoft.AspNetCore.App.Ref/3.1.0/ref/netcoreapp3.1/Microsoft.AspNetCore.Server.Kestrel.Core.dll",
        stdlib_path = "@core_sdk//:core/shared/Microsoft.AspNetCore.App/3.1.0/Microsoft.AspNetCore.Server.Kestrel.Core.dll",
        deps = [
            ":p1_microsoft.extensions.configuration.abstractions.dll",
            ":p1_microsoft.aspnetcore.connections.abstractions.dll",
            ":p1_microsoft.aspnetcore.hosting.server.abstractions.dll",
            ":p1_microsoft.extensions.options.dll",
            ":p1_microsoft.extensions.logging.abstractions.dll",
            ":p1_microsoft.aspnetcore.http.features.dll",
        ],
    )
    core_stdlib_internal(
        name = "p1_microsoft.aspnetcore.server.kestrel.dll",
        version = "3.1.0.0",
        ref = "@core_sdk//:core/packs/Microsoft.AspNetCore.App.Ref/3.1.0/ref/netcoreapp3.1/Microsoft.AspNetCore.Server.Kestrel.dll",
        stdlib_path = "@core_sdk//:core/shared/Microsoft.AspNetCore.App/3.1.0/Microsoft.AspNetCore.Server.Kestrel.dll",
        deps = [
            ":p1_microsoft.aspnetcore.hosting.abstractions.dll",
            ":p1_microsoft.aspnetcore.server.kestrel.core.dll",
        ],
    )
    core_stdlib_internal(
        name = "p1_microsoft.aspnetcore.server.kestrel.transport.sockets.dll",
        version = "3.1.0.0",
        ref = "@core_sdk//:core/packs/Microsoft.AspNetCore.App.Ref/3.1.0/ref/netcoreapp3.1/Microsoft.AspNetCore.Server.Kestrel.Transport.Sockets.dll",
        stdlib_path = "@core_sdk//:core/shared/Microsoft.AspNetCore.App/3.1.0/Microsoft.AspNetCore.Server.Kestrel.Transport.Sockets.dll",
        deps = [
            ":p1_microsoft.aspnetcore.connections.abstractions.dll",
            ":p1_microsoft.extensions.options.dll",
            ":p1_microsoft.extensions.logging.abstractions.dll",
            ":p1_microsoft.aspnetcore.hosting.abstractions.dll",
        ],
    )
    core_stdlib_internal(
        name = "p1_microsoft.aspnetcore.session.dll",
        version = "3.1.0.0",
        ref = "@core_sdk//:core/packs/Microsoft.AspNetCore.App.Ref/3.1.0/ref/netcoreapp3.1/Microsoft.AspNetCore.Session.dll",
        stdlib_path = "@core_sdk//:core/shared/Microsoft.AspNetCore.App/3.1.0/Microsoft.AspNetCore.Session.dll",
        deps = [
            ":p1_microsoft.extensions.dependencyinjection.abstractions.dll",
            ":p1_microsoft.aspnetcore.http.features.dll",
            ":p1_microsoft.extensions.caching.abstractions.dll",
            ":p1_microsoft.extensions.logging.abstractions.dll",
            ":p1_microsoft.aspnetcore.http.abstractions.dll",
            ":p1_microsoft.aspnetcore.dataprotection.abstractions.dll",
            ":p1_microsoft.extensions.options.dll",
        ],
    )
    core_stdlib_internal(
        name = "p1_microsoft.aspnetcore.signalr.common.dll",
        version = "3.1.0.0",
        ref = "@core_sdk//:core/packs/Microsoft.AspNetCore.App.Ref/3.1.0/ref/netcoreapp3.1/Microsoft.AspNetCore.SignalR.Common.dll",
        stdlib_path = "@core_sdk//:core/shared/Microsoft.AspNetCore.App/3.1.0/Microsoft.AspNetCore.SignalR.Common.dll",
        deps = [
            ":p1_microsoft.extensions.dependencyinjection.abstractions.dll",
            ":p1_microsoft.aspnetcore.connections.abstractions.dll",
        ],
    )
    core_stdlib_internal(
        name = "p1_microsoft.aspnetcore.signalr.core.dll",
        version = "3.1.0.0",
        ref = "@core_sdk//:core/packs/Microsoft.AspNetCore.App.Ref/3.1.0/ref/netcoreapp3.1/Microsoft.AspNetCore.SignalR.Core.dll",
        stdlib_path = "@core_sdk//:core/shared/Microsoft.AspNetCore.App/3.1.0/Microsoft.AspNetCore.SignalR.Core.dll",
        deps = [
            ":p1_microsoft.extensions.dependencyinjection.abstractions.dll",
            ":p1_microsoft.extensions.logging.abstractions.dll",
            ":p1_microsoft.aspnetcore.http.features.dll",
            ":p1_microsoft.aspnetcore.connections.abstractions.dll",
            ":p1_microsoft.aspnetcore.signalr.common.dll",
            ":p1_microsoft.extensions.options.dll",
        ],
    )
    core_stdlib_internal(
        name = "p1_microsoft.aspnetcore.signalr.dll",
        version = "3.1.0.0",
        ref = "@core_sdk//:core/packs/Microsoft.AspNetCore.App.Ref/3.1.0/ref/netcoreapp3.1/Microsoft.AspNetCore.SignalR.dll",
        stdlib_path = "@core_sdk//:core/shared/Microsoft.AspNetCore.App/3.1.0/Microsoft.AspNetCore.SignalR.dll",
        deps = [
            ":p1_microsoft.aspnetcore.signalr.core.dll",
            ":p1_microsoft.extensions.dependencyinjection.abstractions.dll",
            ":p1_microsoft.aspnetcore.http.abstractions.dll",
            ":p1_microsoft.aspnetcore.http.connections.dll",
            ":p1_microsoft.aspnetcore.routing.dll",
        ],
    )
    core_stdlib_internal(
        name = "p1_microsoft.aspnetcore.signalr.protocols.json.dll",
        version = "3.1.0.0",
        ref = "@core_sdk//:core/packs/Microsoft.AspNetCore.App.Ref/3.1.0/ref/netcoreapp3.1/Microsoft.AspNetCore.SignalR.Protocols.Json.dll",
        stdlib_path = "@core_sdk//:core/shared/Microsoft.AspNetCore.App/3.1.0/Microsoft.AspNetCore.SignalR.Protocols.Json.dll",
        deps = [
            ":p1_microsoft.aspnetcore.signalr.common.dll",
            ":p1_microsoft.extensions.options.dll",
            ":p1_microsoft.aspnetcore.connections.abstractions.dll",
        ],
    )
    core_stdlib_internal(
        name = "p1_microsoft.aspnetcore.staticfiles.dll",
        version = "3.1.0.0",
        ref = "@core_sdk//:core/packs/Microsoft.AspNetCore.App.Ref/3.1.0/ref/netcoreapp3.1/Microsoft.AspNetCore.StaticFiles.dll",
        stdlib_path = "@core_sdk//:core/shared/Microsoft.AspNetCore.App/3.1.0/Microsoft.AspNetCore.StaticFiles.dll",
        deps = [
            ":p1_microsoft.extensions.dependencyinjection.abstractions.dll",
            ":p1_microsoft.aspnetcore.http.abstractions.dll",
            ":p1_microsoft.aspnetcore.hosting.abstractions.dll",
            ":p1_microsoft.extensions.options.dll",
            ":p1_microsoft.extensions.fileproviders.abstractions.dll",
            ":p1_microsoft.extensions.logging.abstractions.dll",
            ":p1_microsoft.aspnetcore.http.features.dll",
            ":p1_microsoft.aspnetcore.routing.dll",
        ],
    )
    core_stdlib_internal(
        name = "p1_microsoft.aspnetcore.websockets.dll",
        version = "3.1.0.0",
        ref = "@core_sdk//:core/packs/Microsoft.AspNetCore.App.Ref/3.1.0/ref/netcoreapp3.1/Microsoft.AspNetCore.WebSockets.dll",
        stdlib_path = "@core_sdk//:core/shared/Microsoft.AspNetCore.App/3.1.0/Microsoft.AspNetCore.WebSockets.dll",
        deps = [
            ":p1_microsoft.aspnetcore.http.features.dll",
            ":p1_microsoft.aspnetcore.http.abstractions.dll",
            ":p1_microsoft.extensions.options.dll",
            ":p1_microsoft.extensions.logging.abstractions.dll",
            ":p1_microsoft.extensions.dependencyinjection.abstractions.dll",
        ],
    )
    core_stdlib_internal(
        name = "p1_microsoft.aspnetcore.webutilities.dll",
        version = "3.1.0.0",
        ref = "@core_sdk//:core/packs/Microsoft.AspNetCore.App.Ref/3.1.0/ref/netcoreapp3.1/Microsoft.AspNetCore.WebUtilities.dll",
        stdlib_path = "@core_sdk//:core/shared/Microsoft.AspNetCore.App/3.1.0/Microsoft.AspNetCore.WebUtilities.dll",
        deps = [
            ":p1_microsoft.net.http.headers.dll",
            ":p1_system.io.pipelines.dll",
            ":p1_microsoft.extensions.primitives.dll",
        ],
    )
    core_stdlib_internal(
        name = "p1_microsoft.extensions.caching.abstractions.dll",
        version = "3.1.0.0",
        ref = "@core_sdk//:core/packs/Microsoft.AspNetCore.App.Ref/3.1.0/ref/netcoreapp3.1/Microsoft.Extensions.Caching.Abstractions.dll",
        stdlib_path = "@core_sdk//:core/shared/Microsoft.AspNetCore.App/3.1.0/Microsoft.Extensions.Caching.Abstractions.dll",
        deps = [
            ":p1_microsoft.extensions.primitives.dll",
        ],
    )
    core_stdlib_internal(
        name = "p1_microsoft.extensions.caching.memory.dll",
        version = "3.1.0.0",
        ref = "@core_sdk//:core/packs/Microsoft.AspNetCore.App.Ref/3.1.0/ref/netcoreapp3.1/Microsoft.Extensions.Caching.Memory.dll",
        stdlib_path = "@core_sdk//:core/shared/Microsoft.AspNetCore.App/3.1.0/Microsoft.Extensions.Caching.Memory.dll",
        deps = [
            ":p1_microsoft.extensions.dependencyinjection.abstractions.dll",
            ":p1_microsoft.extensions.caching.abstractions.dll",
            ":p1_microsoft.extensions.options.dll",
            ":p1_microsoft.extensions.logging.abstractions.dll",
        ],
    )
    core_stdlib_internal(
        name = "p1_microsoft.extensions.configuration.abstractions.dll",
        version = "3.1.0.0",
        ref = "@core_sdk//:core/packs/Microsoft.AspNetCore.App.Ref/3.1.0/ref/netcoreapp3.1/Microsoft.Extensions.Configuration.Abstractions.dll",
        stdlib_path = "@core_sdk//:core/shared/Microsoft.AspNetCore.App/3.1.0/Microsoft.Extensions.Configuration.Abstractions.dll",
        deps = [
            ":p1_microsoft.extensions.primitives.dll",
        ],
    )
    core_stdlib_internal(
        name = "p1_microsoft.extensions.configuration.binder.dll",
        version = "3.1.0.0",
        ref = "@core_sdk//:core/packs/Microsoft.AspNetCore.App.Ref/3.1.0/ref/netcoreapp3.1/Microsoft.Extensions.Configuration.Binder.dll",
        stdlib_path = "@core_sdk//:core/shared/Microsoft.AspNetCore.App/3.1.0/Microsoft.Extensions.Configuration.Binder.dll",
        deps = [
            ":p1_microsoft.extensions.configuration.abstractions.dll",
        ],
    )
    core_stdlib_internal(
        name = "p1_microsoft.extensions.configuration.commandline.dll",
        version = "3.1.0.0",
        ref = "@core_sdk//:core/packs/Microsoft.AspNetCore.App.Ref/3.1.0/ref/netcoreapp3.1/Microsoft.Extensions.Configuration.CommandLine.dll",
        stdlib_path = "@core_sdk//:core/shared/Microsoft.AspNetCore.App/3.1.0/Microsoft.Extensions.Configuration.CommandLine.dll",
        deps = [
            ":p1_microsoft.extensions.configuration.abstractions.dll",
            ":p1_microsoft.extensions.configuration.dll",
        ],
    )
    core_stdlib_internal(
        name = "p1_microsoft.extensions.configuration.dll",
        version = "3.1.0.0",
        ref = "@core_sdk//:core/packs/Microsoft.AspNetCore.App.Ref/3.1.0/ref/netcoreapp3.1/Microsoft.Extensions.Configuration.dll",
        stdlib_path = "@core_sdk//:core/shared/Microsoft.AspNetCore.App/3.1.0/Microsoft.Extensions.Configuration.dll",
        deps = [
            ":p1_microsoft.extensions.configuration.abstractions.dll",
            ":p1_microsoft.extensions.primitives.dll",
        ],
    )
    core_stdlib_internal(
        name = "p1_microsoft.extensions.configuration.environmentvariables.dll",
        version = "3.1.0.0",
        ref = "@core_sdk//:core/packs/Microsoft.AspNetCore.App.Ref/3.1.0/ref/netcoreapp3.1/Microsoft.Extensions.Configuration.EnvironmentVariables.dll",
        stdlib_path = "@core_sdk//:core/shared/Microsoft.AspNetCore.App/3.1.0/Microsoft.Extensions.Configuration.EnvironmentVariables.dll",
        deps = [
            ":p1_microsoft.extensions.configuration.abstractions.dll",
            ":p1_microsoft.extensions.configuration.dll",
        ],
    )
    core_stdlib_internal(
        name = "p1_microsoft.extensions.configuration.fileextensions.dll",
        version = "3.1.0.0",
        ref = "@core_sdk//:core/packs/Microsoft.AspNetCore.App.Ref/3.1.0/ref/netcoreapp3.1/Microsoft.Extensions.Configuration.FileExtensions.dll",
        stdlib_path = "@core_sdk//:core/shared/Microsoft.AspNetCore.App/3.1.0/Microsoft.Extensions.Configuration.FileExtensions.dll",
        deps = [
            ":p1_microsoft.extensions.configuration.abstractions.dll",
            ":p1_microsoft.extensions.fileproviders.abstractions.dll",
            ":p1_microsoft.extensions.configuration.dll",
        ],
    )
    core_stdlib_internal(
        name = "p1_microsoft.extensions.configuration.ini.dll",
        version = "3.1.0.0",
        ref = "@core_sdk//:core/packs/Microsoft.AspNetCore.App.Ref/3.1.0/ref/netcoreapp3.1/Microsoft.Extensions.Configuration.Ini.dll",
        stdlib_path = "@core_sdk//:core/shared/Microsoft.AspNetCore.App/3.1.0/Microsoft.Extensions.Configuration.Ini.dll",
        deps = [
            ":p1_microsoft.extensions.configuration.abstractions.dll",
            ":p1_microsoft.extensions.fileproviders.abstractions.dll",
            ":p1_microsoft.extensions.configuration.fileextensions.dll",
            ":p1_microsoft.extensions.configuration.dll",
        ],
    )
    core_stdlib_internal(
        name = "p1_microsoft.extensions.configuration.json.dll",
        version = "3.1.0.0",
        ref = "@core_sdk//:core/packs/Microsoft.AspNetCore.App.Ref/3.1.0/ref/netcoreapp3.1/Microsoft.Extensions.Configuration.Json.dll",
        stdlib_path = "@core_sdk//:core/shared/Microsoft.AspNetCore.App/3.1.0/Microsoft.Extensions.Configuration.Json.dll",
        deps = [
            ":p1_microsoft.extensions.configuration.abstractions.dll",
            ":p1_microsoft.extensions.fileproviders.abstractions.dll",
            ":p1_microsoft.extensions.configuration.fileextensions.dll",
            ":p1_microsoft.extensions.configuration.dll",
        ],
    )
    core_stdlib_internal(
        name = "p1_microsoft.extensions.configuration.keyperfile.dll",
        version = "3.1.0.0",
        ref = "@core_sdk//:core/packs/Microsoft.AspNetCore.App.Ref/3.1.0/ref/netcoreapp3.1/Microsoft.Extensions.Configuration.KeyPerFile.dll",
        stdlib_path = "@core_sdk//:core/shared/Microsoft.AspNetCore.App/3.1.0/Microsoft.Extensions.Configuration.KeyPerFile.dll",
        deps = [
            ":p1_microsoft.extensions.configuration.abstractions.dll",
            ":p1_microsoft.extensions.configuration.dll",
            ":p1_microsoft.extensions.fileproviders.abstractions.dll",
        ],
    )
    core_stdlib_internal(
        name = "p1_microsoft.extensions.configuration.usersecrets.dll",
        version = "3.1.0.0",
        ref = "@core_sdk//:core/packs/Microsoft.AspNetCore.App.Ref/3.1.0/ref/netcoreapp3.1/Microsoft.Extensions.Configuration.UserSecrets.dll",
        stdlib_path = "@core_sdk//:core/shared/Microsoft.AspNetCore.App/3.1.0/Microsoft.Extensions.Configuration.UserSecrets.dll",
        deps = [
            ":p1_microsoft.extensions.configuration.abstractions.dll",
        ],
    )
    core_stdlib_internal(
        name = "p1_microsoft.extensions.configuration.xml.dll",
        version = "3.1.0.0",
        ref = "@core_sdk//:core/packs/Microsoft.AspNetCore.App.Ref/3.1.0/ref/netcoreapp3.1/Microsoft.Extensions.Configuration.Xml.dll",
        stdlib_path = "@core_sdk//:core/shared/Microsoft.AspNetCore.App/3.1.0/Microsoft.Extensions.Configuration.Xml.dll",
        deps = [
            ":p1_microsoft.extensions.configuration.abstractions.dll",
            ":p1_microsoft.extensions.fileproviders.abstractions.dll",
            ":p1_microsoft.extensions.configuration.fileextensions.dll",
            ":p1_microsoft.extensions.configuration.dll",
        ],
    )
    core_stdlib_internal(
        name = "p1_microsoft.extensions.dependencyinjection.abstractions.dll",
        version = "3.1.0.0",
        ref = "@core_sdk//:core/packs/Microsoft.AspNetCore.App.Ref/3.1.0/ref/netcoreapp3.1/Microsoft.Extensions.DependencyInjection.Abstractions.dll",
        stdlib_path = "@core_sdk//:core/shared/Microsoft.AspNetCore.App/3.1.0/Microsoft.Extensions.DependencyInjection.Abstractions.dll",
        deps = [
        ],
    )
    core_stdlib_internal(
        name = "p1_microsoft.extensions.dependencyinjection.dll",
        version = "3.1.0.0",
        ref = "@core_sdk//:core/packs/Microsoft.AspNetCore.App.Ref/3.1.0/ref/netcoreapp3.1/Microsoft.Extensions.DependencyInjection.dll",
        stdlib_path = "@core_sdk//:core/shared/Microsoft.AspNetCore.App/3.1.0/Microsoft.Extensions.DependencyInjection.dll",
        deps = [
            ":p1_microsoft.extensions.dependencyinjection.abstractions.dll",
        ],
    )
    core_stdlib_internal(
        name = "p1_microsoft.extensions.diagnostics.healthchecks.abstractions.dll",
        version = "3.1.0.0",
        ref = "@core_sdk//:core/packs/Microsoft.AspNetCore.App.Ref/3.1.0/ref/netcoreapp3.1/Microsoft.Extensions.Diagnostics.HealthChecks.Abstractions.dll",
        stdlib_path = "@core_sdk//:core/shared/Microsoft.AspNetCore.App/3.1.0/Microsoft.Extensions.Diagnostics.HealthChecks.Abstractions.dll",
        deps = [
        ],
    )
    core_stdlib_internal(
        name = "p1_microsoft.extensions.diagnostics.healthchecks.dll",
        version = "3.1.0.0",
        ref = "@core_sdk//:core/packs/Microsoft.AspNetCore.App.Ref/3.1.0/ref/netcoreapp3.1/Microsoft.Extensions.Diagnostics.HealthChecks.dll",
        stdlib_path = "@core_sdk//:core/shared/Microsoft.AspNetCore.App/3.1.0/Microsoft.Extensions.Diagnostics.HealthChecks.dll",
        deps = [
            ":p1_microsoft.extensions.diagnostics.healthchecks.abstractions.dll",
            ":p1_microsoft.extensions.dependencyinjection.abstractions.dll",
        ],
    )
    core_stdlib_internal(
        name = "p1_microsoft.extensions.fileproviders.abstractions.dll",
        version = "3.1.0.0",
        ref = "@core_sdk//:core/packs/Microsoft.AspNetCore.App.Ref/3.1.0/ref/netcoreapp3.1/Microsoft.Extensions.FileProviders.Abstractions.dll",
        stdlib_path = "@core_sdk//:core/shared/Microsoft.AspNetCore.App/3.1.0/Microsoft.Extensions.FileProviders.Abstractions.dll",
        deps = [
            ":p1_microsoft.extensions.primitives.dll",
        ],
    )
    core_stdlib_internal(
        name = "p1_microsoft.extensions.fileproviders.composite.dll",
        version = "3.1.0.0",
        ref = "@core_sdk//:core/packs/Microsoft.AspNetCore.App.Ref/3.1.0/ref/netcoreapp3.1/Microsoft.Extensions.FileProviders.Composite.dll",
        stdlib_path = "@core_sdk//:core/shared/Microsoft.AspNetCore.App/3.1.0/Microsoft.Extensions.FileProviders.Composite.dll",
        deps = [
            ":p1_microsoft.extensions.fileproviders.abstractions.dll",
            ":p1_microsoft.extensions.primitives.dll",
        ],
    )
    core_stdlib_internal(
        name = "p1_microsoft.extensions.fileproviders.embedded.dll",
        version = "3.1.0.0",
        ref = "@core_sdk//:core/packs/Microsoft.AspNetCore.App.Ref/3.1.0/ref/netcoreapp3.1/Microsoft.Extensions.FileProviders.Embedded.dll",
        stdlib_path = "@core_sdk//:core/shared/Microsoft.AspNetCore.App/3.1.0/Microsoft.Extensions.FileProviders.Embedded.dll",
        deps = [
            ":p1_microsoft.extensions.fileproviders.abstractions.dll",
            ":p1_microsoft.extensions.primitives.dll",
        ],
    )
    core_stdlib_internal(
        name = "p1_microsoft.extensions.fileproviders.physical.dll",
        version = "3.1.0.0",
        ref = "@core_sdk//:core/packs/Microsoft.AspNetCore.App.Ref/3.1.0/ref/netcoreapp3.1/Microsoft.Extensions.FileProviders.Physical.dll",
        stdlib_path = "@core_sdk//:core/shared/Microsoft.AspNetCore.App/3.1.0/Microsoft.Extensions.FileProviders.Physical.dll",
        deps = [
            ":p1_microsoft.extensions.fileproviders.abstractions.dll",
            ":p1_microsoft.extensions.primitives.dll",
        ],
    )
    core_stdlib_internal(
        name = "p1_microsoft.extensions.filesystemglobbing.dll",
        version = "3.1.0.0",
        ref = "@core_sdk//:core/packs/Microsoft.AspNetCore.App.Ref/3.1.0/ref/netcoreapp3.1/Microsoft.Extensions.FileSystemGlobbing.dll",
        stdlib_path = "@core_sdk//:core/shared/Microsoft.AspNetCore.App/3.1.0/Microsoft.Extensions.FileSystemGlobbing.dll",
        deps = [
        ],
    )
    core_stdlib_internal(
        name = "p1_microsoft.extensions.hosting.abstractions.dll",
        version = "3.1.0.0",
        ref = "@core_sdk//:core/packs/Microsoft.AspNetCore.App.Ref/3.1.0/ref/netcoreapp3.1/Microsoft.Extensions.Hosting.Abstractions.dll",
        stdlib_path = "@core_sdk//:core/shared/Microsoft.AspNetCore.App/3.1.0/Microsoft.Extensions.Hosting.Abstractions.dll",
        deps = [
            ":p1_microsoft.extensions.configuration.abstractions.dll",
            ":p1_microsoft.extensions.dependencyinjection.abstractions.dll",
            ":p1_microsoft.extensions.fileproviders.abstractions.dll",
        ],
    )
    core_stdlib_internal(
        name = "p1_microsoft.extensions.hosting.dll",
        version = "3.1.0.0",
        ref = "@core_sdk//:core/packs/Microsoft.AspNetCore.App.Ref/3.1.0/ref/netcoreapp3.1/Microsoft.Extensions.Hosting.dll",
        stdlib_path = "@core_sdk//:core/shared/Microsoft.AspNetCore.App/3.1.0/Microsoft.Extensions.Hosting.dll",
        deps = [
            ":p1_microsoft.extensions.hosting.abstractions.dll",
            ":p1_microsoft.extensions.configuration.abstractions.dll",
            ":p1_microsoft.extensions.dependencyinjection.abstractions.dll",
            ":p1_microsoft.extensions.logging.dll",
            ":p1_microsoft.extensions.dependencyinjection.dll",
            ":p1_microsoft.extensions.logging.abstractions.dll",
            ":p1_microsoft.extensions.options.dll",
            ":p1_microsoft.extensions.fileproviders.abstractions.dll",
        ],
    )
    core_stdlib_internal(
        name = "p1_microsoft.extensions.http.dll",
        version = "3.1.0.0",
        ref = "@core_sdk//:core/packs/Microsoft.AspNetCore.App.Ref/3.1.0/ref/netcoreapp3.1/Microsoft.Extensions.Http.dll",
        stdlib_path = "@core_sdk//:core/shared/Microsoft.AspNetCore.App/3.1.0/Microsoft.Extensions.Http.dll",
        deps = [
            ":p1_microsoft.extensions.logging.abstractions.dll",
            ":p1_microsoft.extensions.dependencyinjection.abstractions.dll",
        ],
    )
    core_stdlib_internal(
        name = "p1_microsoft.extensions.identity.core.dll",
        version = "3.1.0.0",
        ref = "@core_sdk//:core/packs/Microsoft.AspNetCore.App.Ref/3.1.0/ref/netcoreapp3.1/Microsoft.Extensions.Identity.Core.dll",
        stdlib_path = "@core_sdk//:core/shared/Microsoft.AspNetCore.App/3.1.0/Microsoft.Extensions.Identity.Core.dll",
        deps = [
            ":p1_microsoft.extensions.dependencyinjection.abstractions.dll",
            ":p1_microsoft.extensions.options.dll",
            ":p1_microsoft.extensions.logging.abstractions.dll",
        ],
    )
    core_stdlib_internal(
        name = "p1_microsoft.extensions.identity.stores.dll",
        version = "3.1.0.0",
        ref = "@core_sdk//:core/packs/Microsoft.AspNetCore.App.Ref/3.1.0/ref/netcoreapp3.1/Microsoft.Extensions.Identity.Stores.dll",
        stdlib_path = "@core_sdk//:core/shared/Microsoft.AspNetCore.App/3.1.0/Microsoft.Extensions.Identity.Stores.dll",
        deps = [
            ":p1_microsoft.extensions.identity.core.dll",
        ],
    )
    core_stdlib_internal(
        name = "p1_microsoft.extensions.localization.abstractions.dll",
        version = "3.1.0.0",
        ref = "@core_sdk//:core/packs/Microsoft.AspNetCore.App.Ref/3.1.0/ref/netcoreapp3.1/Microsoft.Extensions.Localization.Abstractions.dll",
        stdlib_path = "@core_sdk//:core/shared/Microsoft.AspNetCore.App/3.1.0/Microsoft.Extensions.Localization.Abstractions.dll",
        deps = [
        ],
    )
    core_stdlib_internal(
        name = "p1_microsoft.extensions.localization.dll",
        version = "3.1.0.0",
        ref = "@core_sdk//:core/packs/Microsoft.AspNetCore.App.Ref/3.1.0/ref/netcoreapp3.1/Microsoft.Extensions.Localization.dll",
        stdlib_path = "@core_sdk//:core/shared/Microsoft.AspNetCore.App/3.1.0/Microsoft.Extensions.Localization.dll",
        deps = [
            ":p1_microsoft.extensions.localization.abstractions.dll",
            ":p1_microsoft.extensions.logging.abstractions.dll",
            ":p1_microsoft.extensions.options.dll",
            ":p1_microsoft.extensions.dependencyinjection.abstractions.dll",
        ],
    )
    core_stdlib_internal(
        name = "p1_microsoft.extensions.logging.abstractions.dll",
        version = "3.1.0.0",
        ref = "@core_sdk//:core/packs/Microsoft.AspNetCore.App.Ref/3.1.0/ref/netcoreapp3.1/Microsoft.Extensions.Logging.Abstractions.dll",
        stdlib_path = "@core_sdk//:core/shared/Microsoft.AspNetCore.App/3.1.0/Microsoft.Extensions.Logging.Abstractions.dll",
        deps = [
        ],
    )
    core_stdlib_internal(
        name = "p1_microsoft.extensions.logging.configuration.dll",
        version = "3.1.0.0",
        ref = "@core_sdk//:core/packs/Microsoft.AspNetCore.App.Ref/3.1.0/ref/netcoreapp3.1/Microsoft.Extensions.Logging.Configuration.dll",
        stdlib_path = "@core_sdk//:core/shared/Microsoft.AspNetCore.App/3.1.0/Microsoft.Extensions.Logging.Configuration.dll",
        deps = [
            ":p1_microsoft.extensions.logging.dll",
            ":p1_microsoft.extensions.configuration.abstractions.dll",
            ":p1_microsoft.extensions.dependencyinjection.abstractions.dll",
            ":p1_microsoft.extensions.options.configurationextensions.dll",
        ],
    )
    core_stdlib_internal(
        name = "p1_microsoft.extensions.logging.console.dll",
        version = "3.1.0.0",
        ref = "@core_sdk//:core/packs/Microsoft.AspNetCore.App.Ref/3.1.0/ref/netcoreapp3.1/Microsoft.Extensions.Logging.Console.dll",
        stdlib_path = "@core_sdk//:core/shared/Microsoft.AspNetCore.App/3.1.0/Microsoft.Extensions.Logging.Console.dll",
        deps = [
            ":p1_microsoft.extensions.logging.dll",
            ":p1_microsoft.extensions.logging.abstractions.dll",
            ":p1_microsoft.extensions.options.dll",
        ],
    )
    core_stdlib_internal(
        name = "p1_microsoft.extensions.logging.debug.dll",
        version = "3.1.0.0",
        ref = "@core_sdk//:core/packs/Microsoft.AspNetCore.App.Ref/3.1.0/ref/netcoreapp3.1/Microsoft.Extensions.Logging.Debug.dll",
        stdlib_path = "@core_sdk//:core/shared/Microsoft.AspNetCore.App/3.1.0/Microsoft.Extensions.Logging.Debug.dll",
        deps = [
            ":p1_microsoft.extensions.logging.dll",
            ":p1_microsoft.extensions.logging.abstractions.dll",
        ],
    )
    core_stdlib_internal(
        name = "p1_microsoft.extensions.logging.dll",
        version = "3.1.0.0",
        ref = "@core_sdk//:core/packs/Microsoft.AspNetCore.App.Ref/3.1.0/ref/netcoreapp3.1/Microsoft.Extensions.Logging.dll",
        stdlib_path = "@core_sdk//:core/shared/Microsoft.AspNetCore.App/3.1.0/Microsoft.Extensions.Logging.dll",
        deps = [
            ":p1_microsoft.extensions.logging.abstractions.dll",
            ":p1_microsoft.extensions.dependencyinjection.abstractions.dll",
            ":p1_microsoft.extensions.options.dll",
        ],
    )
    core_stdlib_internal(
        name = "p1_microsoft.extensions.logging.eventlog.dll",
        version = "3.1.0.0",
        ref = "@core_sdk//:core/packs/Microsoft.AspNetCore.App.Ref/3.1.0/ref/netcoreapp3.1/Microsoft.Extensions.Logging.EventLog.dll",
        stdlib_path = "@core_sdk//:core/shared/Microsoft.AspNetCore.App/3.1.0/Microsoft.Extensions.Logging.EventLog.dll",
        deps = [
            ":p1_microsoft.extensions.logging.dll",
            ":p1_microsoft.extensions.logging.abstractions.dll",
            ":p1_microsoft.extensions.options.dll",
        ],
    )
    core_stdlib_internal(
        name = "p1_microsoft.extensions.logging.eventsource.dll",
        version = "3.1.0.0",
        ref = "@core_sdk//:core/packs/Microsoft.AspNetCore.App.Ref/3.1.0/ref/netcoreapp3.1/Microsoft.Extensions.Logging.EventSource.dll",
        stdlib_path = "@core_sdk//:core/shared/Microsoft.AspNetCore.App/3.1.0/Microsoft.Extensions.Logging.EventSource.dll",
        deps = [
            ":p1_microsoft.extensions.logging.dll",
            ":p1_microsoft.extensions.logging.abstractions.dll",
        ],
    )
    core_stdlib_internal(
        name = "p1_microsoft.extensions.logging.tracesource.dll",
        version = "3.1.0.0",
        ref = "@core_sdk//:core/packs/Microsoft.AspNetCore.App.Ref/3.1.0/ref/netcoreapp3.1/Microsoft.Extensions.Logging.TraceSource.dll",
        stdlib_path = "@core_sdk//:core/shared/Microsoft.AspNetCore.App/3.1.0/Microsoft.Extensions.Logging.TraceSource.dll",
        deps = [
            ":p1_microsoft.extensions.logging.dll",
            ":p1_microsoft.extensions.logging.abstractions.dll",
        ],
    )
    core_stdlib_internal(
        name = "p1_microsoft.extensions.objectpool.dll",
        version = "3.1.0.0",
        ref = "@core_sdk//:core/packs/Microsoft.AspNetCore.App.Ref/3.1.0/ref/netcoreapp3.1/Microsoft.Extensions.ObjectPool.dll",
        stdlib_path = "@core_sdk//:core/shared/Microsoft.AspNetCore.App/3.1.0/Microsoft.Extensions.ObjectPool.dll",
        deps = [
        ],
    )
    core_stdlib_internal(
        name = "p1_microsoft.extensions.options.configurationextensions.dll",
        version = "3.1.0.0",
        ref = "@core_sdk//:core/packs/Microsoft.AspNetCore.App.Ref/3.1.0/ref/netcoreapp3.1/Microsoft.Extensions.Options.ConfigurationExtensions.dll",
        stdlib_path = "@core_sdk//:core/shared/Microsoft.AspNetCore.App/3.1.0/Microsoft.Extensions.Options.ConfigurationExtensions.dll",
        deps = [
            ":p1_microsoft.extensions.options.dll",
            ":p1_microsoft.extensions.configuration.abstractions.dll",
            ":p1_microsoft.extensions.primitives.dll",
            ":p1_microsoft.extensions.configuration.binder.dll",
            ":p1_microsoft.extensions.dependencyinjection.abstractions.dll",
        ],
    )
    core_stdlib_internal(
        name = "p1_microsoft.extensions.options.dataannotations.dll",
        version = "3.1.0.0",
        ref = "@core_sdk//:core/packs/Microsoft.AspNetCore.App.Ref/3.1.0/ref/netcoreapp3.1/Microsoft.Extensions.Options.DataAnnotations.dll",
        stdlib_path = "@core_sdk//:core/shared/Microsoft.AspNetCore.App/3.1.0/Microsoft.Extensions.Options.DataAnnotations.dll",
        deps = [
            ":p1_microsoft.extensions.options.dll",
        ],
    )
    core_stdlib_internal(
        name = "p1_microsoft.extensions.options.dll",
        version = "3.1.0.0",
        ref = "@core_sdk//:core/packs/Microsoft.AspNetCore.App.Ref/3.1.0/ref/netcoreapp3.1/Microsoft.Extensions.Options.dll",
        stdlib_path = "@core_sdk//:core/shared/Microsoft.AspNetCore.App/3.1.0/Microsoft.Extensions.Options.dll",
        deps = [
            ":p1_microsoft.extensions.primitives.dll",
            ":p1_microsoft.extensions.dependencyinjection.abstractions.dll",
        ],
    )
    core_stdlib_internal(
        name = "p1_microsoft.extensions.primitives.dll",
        version = "3.1.0.0",
        ref = "@core_sdk//:core/packs/Microsoft.AspNetCore.App.Ref/3.1.0/ref/netcoreapp3.1/Microsoft.Extensions.Primitives.dll",
        stdlib_path = "@core_sdk//:core/shared/Microsoft.AspNetCore.App/3.1.0/Microsoft.Extensions.Primitives.dll",
        deps = [
        ],
    )
    core_stdlib_internal(
        name = "p1_microsoft.extensions.webencoders.dll",
        version = "3.1.0.0",
        ref = "@core_sdk//:core/packs/Microsoft.AspNetCore.App.Ref/3.1.0/ref/netcoreapp3.1/Microsoft.Extensions.WebEncoders.dll",
        stdlib_path = "@core_sdk//:core/shared/Microsoft.AspNetCore.App/3.1.0/Microsoft.Extensions.WebEncoders.dll",
        deps = [
            ":p1_microsoft.extensions.dependencyinjection.abstractions.dll",
        ],
    )
    core_stdlib_internal(
        name = "p1_microsoft.jsinterop.dll",
        version = "3.1.0.0",
        ref = "@core_sdk//:core/packs/Microsoft.AspNetCore.App.Ref/3.1.0/ref/netcoreapp3.1/Microsoft.JSInterop.dll",
        stdlib_path = "@core_sdk//:core/shared/Microsoft.AspNetCore.App/3.1.0/Microsoft.JSInterop.dll",
        deps = [
        ],
    )
    core_stdlib_internal(
        name = "p1_microsoft.net.http.headers.dll",
        version = "3.1.0.0",
        ref = "@core_sdk//:core/packs/Microsoft.AspNetCore.App.Ref/3.1.0/ref/netcoreapp3.1/Microsoft.Net.Http.Headers.dll",
        stdlib_path = "@core_sdk//:core/shared/Microsoft.AspNetCore.App/3.1.0/Microsoft.Net.Http.Headers.dll",
        deps = [
            ":p1_microsoft.extensions.primitives.dll",
        ],
    )
    core_stdlib_internal(
        name = "p1_microsoft.win32.registry.dll",
        version = "4.1.3.0",
        ref = "@core_sdk//:core/packs/Microsoft.AspNetCore.App.Ref/3.1.0/ref/netcoreapp3.1/Microsoft.Win32.Registry.dll",
        stdlib_path = "@core_sdk//:core/shared/Microsoft.NETCore.App/3.1.0/Microsoft.Win32.Registry.dll",
        deps = [
            ":p1_system.security.accesscontrol.dll",
            ":p1_system.security.principal.windows.dll",
        ],
    )
    core_stdlib_internal(
        name = "p1_system.diagnostics.eventlog.dll",
        version = "4.0.2.0",
        ref = "@core_sdk//:core/packs/Microsoft.AspNetCore.App.Ref/3.1.0/ref/netcoreapp3.1/System.Diagnostics.EventLog.dll",
        stdlib_path = "@core_sdk//:core/shared/Microsoft.AspNetCore.App/3.1.0/System.Diagnostics.EventLog.dll",
        deps = [
            ":p1_system.security.principal.windows.dll",
        ],
    )
    core_stdlib_internal(
        name = "p1_system.io.pipelines.dll",
        version = "4.0.2.0",
        ref = "@core_sdk//:core/packs/Microsoft.AspNetCore.App.Ref/3.1.0/ref/netcoreapp3.1/System.IO.Pipelines.dll",
        stdlib_path = "@core_sdk//:core/shared/Microsoft.AspNetCore.App/3.1.0/System.IO.Pipelines.dll",
        deps = [
        ],
    )
    core_stdlib_internal(
        name = "p1_system.security.accesscontrol.dll",
        version = "4.1.1.0",
        ref = "@core_sdk//:core/packs/Microsoft.AspNetCore.App.Ref/3.1.0/ref/netcoreapp3.1/System.Security.AccessControl.dll",
        stdlib_path = "@core_sdk//:core/shared/Microsoft.NETCore.App/3.1.0/System.Security.AccessControl.dll",
        deps = [
            ":p1_system.security.principal.windows.dll",
        ],
    )
    core_stdlib_internal(
        name = "p1_system.security.cryptography.cng.dll",
        version = "4.3.3.0",
        ref = "@core_sdk//:core/packs/Microsoft.AspNetCore.App.Ref/3.1.0/ref/netcoreapp3.1/System.Security.Cryptography.Cng.dll",
        stdlib_path = "@core_sdk//:core/shared/Microsoft.NETCore.App/3.1.0/System.Security.Cryptography.Cng.dll",
        deps = [
        ],
    )
    core_stdlib_internal(
        name = "p1_system.security.cryptography.xml.dll",
        version = "4.0.3.0",
        ref = "@core_sdk//:core/packs/Microsoft.AspNetCore.App.Ref/3.1.0/ref/netcoreapp3.1/System.Security.Cryptography.Xml.dll",
        stdlib_path = "@core_sdk//:core/shared/Microsoft.AspNetCore.App/3.1.0/System.Security.Cryptography.Xml.dll",
        deps = [
            ":p1_system.security.permissions.dll",
        ],
    )
    core_stdlib_internal(
        name = "p1_system.security.permissions.dll",
        version = "4.0.3.0",
        ref = "@core_sdk//:core/packs/Microsoft.AspNetCore.App.Ref/3.1.0/ref/netcoreapp3.1/System.Security.Permissions.dll",
        stdlib_path = "@core_sdk//:core/shared/Microsoft.AspNetCore.App/3.1.0/System.Security.Permissions.dll",
        deps = [
            ":p1_system.windows.extensions.dll",
            ":p1_system.security.accesscontrol.dll",
        ],
    )
    core_stdlib_internal(
        name = "p1_system.security.principal.windows.dll",
        version = "4.1.1.0",
        ref = "@core_sdk//:core/packs/Microsoft.AspNetCore.App.Ref/3.1.0/ref/netcoreapp3.1/System.Security.Principal.Windows.dll",
        stdlib_path = "@core_sdk//:core/shared/Microsoft.NETCore.App/3.1.0/System.Security.Principal.Windows.dll",
        deps = [
        ],
    )
    core_stdlib_internal(
        name = "p1_system.windows.extensions.dll",
        version = "4.0.1.0",
        ref = "@core_sdk//:core/packs/Microsoft.AspNetCore.App.Ref/3.1.0/ref/netcoreapp3.1/System.Windows.Extensions.dll",
        stdlib_path = "@core_sdk//:core/shared/Microsoft.AspNetCore.App/3.1.0/System.Windows.Extensions.dll",
        deps = [
        ],
    )
    core_libraryset(
        name = "NETStandard.Library",
        deps = [
            ":p2_microsoft.win32.primitives.dll",
            ":p2_mscorlib.dll",
            ":p2_netstandard.dll",
            ":p2_system.appcontext.dll",
            ":p2_system.buffers.dll",
            ":p2_system.collections.concurrent.dll",
            ":p2_system.collections.dll",
            ":p2_system.collections.nongeneric.dll",
            ":p2_system.collections.specialized.dll",
            ":p2_system.componentmodel.dll",
            ":p2_system.componentmodel.eventbasedasync.dll",
            ":p2_system.componentmodel.primitives.dll",
            ":p2_system.componentmodel.typeconverter.dll",
            ":p2_system.console.dll",
            ":p2_system.core.dll",
            ":p2_system.data.common.dll",
            ":p2_system.data.dll",
            ":p2_system.diagnostics.contracts.dll",
            ":p2_system.diagnostics.debug.dll",
            ":p2_system.diagnostics.fileversioninfo.dll",
            ":p2_system.diagnostics.process.dll",
            ":p2_system.diagnostics.stacktrace.dll",
            ":p2_system.diagnostics.textwritertracelistener.dll",
            ":p2_system.diagnostics.tools.dll",
            ":p2_system.diagnostics.tracesource.dll",
            ":p2_system.diagnostics.tracing.dll",
            ":p2_system.dll",
            ":p2_system.drawing.dll",
            ":p2_system.drawing.primitives.dll",
            ":p2_system.dynamic.runtime.dll",
            ":p2_system.globalization.calendars.dll",
            ":p2_system.globalization.dll",
            ":p2_system.globalization.extensions.dll",
            ":p2_system.io.compression.dll",
            ":p2_system.io.compression.filesystem.dll",
            ":p2_system.io.compression.zipfile.dll",
            ":p2_system.io.dll",
            ":p2_system.io.filesystem.dll",
            ":p2_system.io.filesystem.driveinfo.dll",
            ":p2_system.io.filesystem.primitives.dll",
            ":p2_system.io.filesystem.watcher.dll",
            ":p2_system.io.isolatedstorage.dll",
            ":p2_system.io.memorymappedfiles.dll",
            ":p2_system.io.pipes.dll",
            ":p2_system.io.unmanagedmemorystream.dll",
            ":p2_system.linq.dll",
            ":p2_system.linq.expressions.dll",
            ":p2_system.linq.parallel.dll",
            ":p2_system.linq.queryable.dll",
            ":p2_system.memory.dll",
            ":p2_system.net.dll",
            ":p2_system.net.http.dll",
            ":p2_system.net.nameresolution.dll",
            ":p2_system.net.networkinformation.dll",
            ":p2_system.net.ping.dll",
            ":p2_system.net.primitives.dll",
            ":p2_system.net.requests.dll",
            ":p2_system.net.security.dll",
            ":p2_system.net.sockets.dll",
            ":p2_system.net.webheadercollection.dll",
            ":p2_system.net.websockets.client.dll",
            ":p2_system.net.websockets.dll",
            ":p2_system.numerics.dll",
            ":p2_system.numerics.vectors.dll",
            ":p2_system.objectmodel.dll",
            ":p2_system.reflection.dispatchproxy.dll",
            ":p2_system.reflection.dll",
            ":p2_system.reflection.emit.dll",
            ":p2_system.reflection.emit.ilgeneration.dll",
            ":p2_system.reflection.emit.lightweight.dll",
            ":p2_system.reflection.extensions.dll",
            ":p2_system.reflection.primitives.dll",
            ":p2_system.resources.reader.dll",
            ":p2_system.resources.resourcemanager.dll",
            ":p2_system.resources.writer.dll",
            ":p2_system.runtime.compilerservices.visualc.dll",
            ":p2_system.runtime.dll",
            ":p2_system.runtime.extensions.dll",
            ":p2_system.runtime.handles.dll",
            ":p2_system.runtime.interopservices.dll",
            ":p2_system.runtime.interopservices.runtimeinformation.dll",
            ":p2_system.runtime.numerics.dll",
            ":p2_system.runtime.serialization.dll",
            ":p2_system.runtime.serialization.formatters.dll",
            ":p2_system.runtime.serialization.json.dll",
            ":p2_system.runtime.serialization.primitives.dll",
            ":p2_system.runtime.serialization.xml.dll",
            ":p2_system.security.claims.dll",
            ":p2_system.security.cryptography.algorithms.dll",
            ":p2_system.security.cryptography.csp.dll",
            ":p2_system.security.cryptography.encoding.dll",
            ":p2_system.security.cryptography.primitives.dll",
            ":p2_system.security.cryptography.x509certificates.dll",
            ":p2_system.security.principal.dll",
            ":p2_system.security.securestring.dll",
            ":p2_system.servicemodel.web.dll",
            ":p2_system.text.encoding.dll",
            ":p2_system.text.encoding.extensions.dll",
            ":p2_system.text.regularexpressions.dll",
            ":p2_system.threading.dll",
            ":p2_system.threading.overlapped.dll",
            ":p2_system.threading.tasks.dll",
            ":p2_system.threading.tasks.extensions.dll",
            ":p2_system.threading.tasks.parallel.dll",
            ":p2_system.threading.thread.dll",
            ":p2_system.threading.threadpool.dll",
            ":p2_system.threading.timer.dll",
            ":p2_system.transactions.dll",
            ":p2_system.valuetuple.dll",
            ":p2_system.web.dll",
            ":p2_system.windows.dll",
            ":p2_system.xml.dll",
            ":p2_system.xml.linq.dll",
            ":p2_system.xml.readerwriter.dll",
            ":p2_system.xml.serialization.dll",
            ":p2_system.xml.xdocument.dll",
            ":p2_system.xml.xmldocument.dll",
            ":p2_system.xml.xmlserializer.dll",
            ":p2_system.xml.xpath.dll",
            ":p2_system.xml.xpath.xdocument.dll",
        ],
    )
    core_stdlib_internal(
        name = "p2_microsoft.win32.primitives.dll",
        version = "4.0.3.0",
        ref = "@core_sdk//:core/packs/NETStandard.Library.Ref/2.1.0/ref/netstandard2.1/Microsoft.Win32.Primitives.dll",
        stdlib_path = "@core_sdk//:core/shared/Microsoft.NETCore.App/3.1.0/Microsoft.Win32.Primitives.dll",
        deps = [
            ":p2_netstandard.dll",
        ],
    )
    core_stdlib_internal(
        name = "p2_mscorlib.dll",
        version = "4.0.0.0",
        ref = "@core_sdk//:core/packs/NETStandard.Library.Ref/2.1.0/ref/netstandard2.1/mscorlib.dll",
        stdlib_path = "@core_sdk//:core/shared/Microsoft.NETCore.App/3.1.0/mscorlib.dll",
        deps = [
            ":p2_netstandard.dll",
        ],
    )
    core_stdlib_internal(
        name = "p2_netstandard.dll",
        version = "2.1.0.0",
        ref = "@core_sdk//:core/packs/NETStandard.Library.Ref/2.1.0/ref/netstandard2.1/netstandard.dll",
        stdlib_path = "@core_sdk//:core/shared/Microsoft.NETCore.App/3.1.0/netstandard.dll",
        deps = [
        ],
    )
    core_stdlib_internal(
        name = "p2_system.appcontext.dll",
        version = "4.1.2.0",
        ref = "@core_sdk//:core/packs/NETStandard.Library.Ref/2.1.0/ref/netstandard2.1/System.AppContext.dll",
        stdlib_path = "@core_sdk//:core/shared/Microsoft.NETCore.App/3.1.0/System.AppContext.dll",
        deps = [
            ":p2_netstandard.dll",
        ],
    )
    core_stdlib_internal(
        name = "p2_system.buffers.dll",
        version = "4.0.3.0",
        ref = "@core_sdk//:core/packs/NETStandard.Library.Ref/2.1.0/ref/netstandard2.1/System.Buffers.dll",
        stdlib_path = "@core_sdk//:core/shared/Microsoft.NETCore.App/3.1.0/System.Buffers.dll",
        deps = [
            ":p2_netstandard.dll",
        ],
    )
    core_stdlib_internal(
        name = "p2_system.collections.concurrent.dll",
        version = "4.0.11.0",
        ref = "@core_sdk//:core/packs/NETStandard.Library.Ref/2.1.0/ref/netstandard2.1/System.Collections.Concurrent.dll",
        stdlib_path = "@core_sdk//:core/shared/Microsoft.NETCore.App/3.1.0/System.Collections.Concurrent.dll",
        deps = [
            ":p2_netstandard.dll",
        ],
    )
    core_stdlib_internal(
        name = "p2_system.collections.dll",
        version = "4.0.11.0",
        ref = "@core_sdk//:core/packs/NETStandard.Library.Ref/2.1.0/ref/netstandard2.1/System.Collections.dll",
        stdlib_path = "@core_sdk//:core/shared/Microsoft.NETCore.App/3.1.0/System.Collections.dll",
        deps = [
            ":p2_netstandard.dll",
        ],
    )
    core_stdlib_internal(
        name = "p2_system.collections.nongeneric.dll",
        version = "4.0.3.0",
        ref = "@core_sdk//:core/packs/NETStandard.Library.Ref/2.1.0/ref/netstandard2.1/System.Collections.NonGeneric.dll",
        stdlib_path = "@core_sdk//:core/shared/Microsoft.NETCore.App/3.1.0/System.Collections.NonGeneric.dll",
        deps = [
            ":p2_netstandard.dll",
        ],
    )
    core_stdlib_internal(
        name = "p2_system.collections.specialized.dll",
        version = "4.0.3.0",
        ref = "@core_sdk//:core/packs/NETStandard.Library.Ref/2.1.0/ref/netstandard2.1/System.Collections.Specialized.dll",
        stdlib_path = "@core_sdk//:core/shared/Microsoft.NETCore.App/3.1.0/System.Collections.Specialized.dll",
        deps = [
            ":p2_netstandard.dll",
        ],
    )
    core_stdlib_internal(
        name = "p2_system.componentmodel.dll",
        version = "4.0.1.0",
        ref = "@core_sdk//:core/packs/NETStandard.Library.Ref/2.1.0/ref/netstandard2.1/System.ComponentModel.dll",
        stdlib_path = "@core_sdk//:core/shared/Microsoft.NETCore.App/3.1.0/System.ComponentModel.dll",
        deps = [
            ":p2_netstandard.dll",
        ],
    )
    core_stdlib_internal(
        name = "p2_system.componentmodel.eventbasedasync.dll",
        version = "4.0.11.0",
        ref = "@core_sdk//:core/packs/NETStandard.Library.Ref/2.1.0/ref/netstandard2.1/System.ComponentModel.EventBasedAsync.dll",
        stdlib_path = "@core_sdk//:core/shared/Microsoft.NETCore.App/3.1.0/System.ComponentModel.EventBasedAsync.dll",
        deps = [
            ":p2_netstandard.dll",
        ],
    )
    core_stdlib_internal(
        name = "p2_system.componentmodel.primitives.dll",
        version = "4.1.2.0",
        ref = "@core_sdk//:core/packs/NETStandard.Library.Ref/2.1.0/ref/netstandard2.1/System.ComponentModel.Primitives.dll",
        stdlib_path = "@core_sdk//:core/shared/Microsoft.NETCore.App/3.1.0/System.ComponentModel.Primitives.dll",
        deps = [
            ":p2_netstandard.dll",
        ],
    )
    core_stdlib_internal(
        name = "p2_system.componentmodel.typeconverter.dll",
        version = "4.1.2.0",
        ref = "@core_sdk//:core/packs/NETStandard.Library.Ref/2.1.0/ref/netstandard2.1/System.ComponentModel.TypeConverter.dll",
        stdlib_path = "@core_sdk//:core/shared/Microsoft.NETCore.App/3.1.0/System.ComponentModel.TypeConverter.dll",
        deps = [
            ":p2_netstandard.dll",
        ],
    )
    core_stdlib_internal(
        name = "p2_system.console.dll",
        version = "4.0.2.0",
        ref = "@core_sdk//:core/packs/NETStandard.Library.Ref/2.1.0/ref/netstandard2.1/System.Console.dll",
        stdlib_path = "@core_sdk//:core/shared/Microsoft.NETCore.App/3.1.0/System.Console.dll",
        deps = [
            ":p2_netstandard.dll",
        ],
    )
    core_stdlib_internal(
        name = "p2_system.core.dll",
        version = "4.0.0.0",
        ref = "@core_sdk//:core/packs/NETStandard.Library.Ref/2.1.0/ref/netstandard2.1/System.Core.dll",
        stdlib_path = "@core_sdk//:core/shared/Microsoft.NETCore.App/3.1.0/System.Core.dll",
        deps = [
            ":p2_netstandard.dll",
        ],
    )
    core_stdlib_internal(
        name = "p2_system.data.common.dll",
        version = "4.1.2.0",
        ref = "@core_sdk//:core/packs/NETStandard.Library.Ref/2.1.0/ref/netstandard2.1/System.Data.Common.dll",
        stdlib_path = "@core_sdk//:core/shared/Microsoft.NETCore.App/3.1.0/System.Data.Common.dll",
        deps = [
            ":p2_netstandard.dll",
        ],
    )
    core_stdlib_internal(
        name = "p2_system.data.dll",
        version = "4.0.0.0",
        ref = "@core_sdk//:core/packs/NETStandard.Library.Ref/2.1.0/ref/netstandard2.1/System.Data.dll",
        stdlib_path = "@core_sdk//:core/shared/Microsoft.NETCore.App/3.1.0/System.Data.dll",
        deps = [
            ":p2_netstandard.dll",
        ],
    )
    core_stdlib_internal(
        name = "p2_system.diagnostics.contracts.dll",
        version = "4.0.1.0",
        ref = "@core_sdk//:core/packs/NETStandard.Library.Ref/2.1.0/ref/netstandard2.1/System.Diagnostics.Contracts.dll",
        stdlib_path = "@core_sdk//:core/shared/Microsoft.NETCore.App/3.1.0/System.Diagnostics.Contracts.dll",
        deps = [
            ":p2_netstandard.dll",
        ],
    )
    core_stdlib_internal(
        name = "p2_system.diagnostics.debug.dll",
        version = "4.0.11.0",
        ref = "@core_sdk//:core/packs/NETStandard.Library.Ref/2.1.0/ref/netstandard2.1/System.Diagnostics.Debug.dll",
        stdlib_path = "@core_sdk//:core/shared/Microsoft.NETCore.App/3.1.0/System.Diagnostics.Debug.dll",
        deps = [
            ":p2_netstandard.dll",
        ],
    )
    core_stdlib_internal(
        name = "p2_system.diagnostics.fileversioninfo.dll",
        version = "4.0.2.0",
        ref = "@core_sdk//:core/packs/NETStandard.Library.Ref/2.1.0/ref/netstandard2.1/System.Diagnostics.FileVersionInfo.dll",
        stdlib_path = "@core_sdk//:core/shared/Microsoft.NETCore.App/3.1.0/System.Diagnostics.FileVersionInfo.dll",
        deps = [
            ":p2_netstandard.dll",
        ],
    )
    core_stdlib_internal(
        name = "p2_system.diagnostics.process.dll",
        version = "4.1.2.0",
        ref = "@core_sdk//:core/packs/NETStandard.Library.Ref/2.1.0/ref/netstandard2.1/System.Diagnostics.Process.dll",
        stdlib_path = "@core_sdk//:core/shared/Microsoft.NETCore.App/3.1.0/System.Diagnostics.Process.dll",
        deps = [
            ":p2_netstandard.dll",
        ],
    )
    core_stdlib_internal(
        name = "p2_system.diagnostics.stacktrace.dll",
        version = "4.0.4.0",
        ref = "@core_sdk//:core/packs/NETStandard.Library.Ref/2.1.0/ref/netstandard2.1/System.Diagnostics.StackTrace.dll",
        stdlib_path = "@core_sdk//:core/shared/Microsoft.NETCore.App/3.1.0/System.Diagnostics.StackTrace.dll",
        deps = [
            ":p2_netstandard.dll",
        ],
    )
    core_stdlib_internal(
        name = "p2_system.diagnostics.textwritertracelistener.dll",
        version = "4.0.2.0",
        ref = "@core_sdk//:core/packs/NETStandard.Library.Ref/2.1.0/ref/netstandard2.1/System.Diagnostics.TextWriterTraceListener.dll",
        stdlib_path = "@core_sdk//:core/shared/Microsoft.NETCore.App/3.1.0/System.Diagnostics.TextWriterTraceListener.dll",
        deps = [
            ":p2_netstandard.dll",
        ],
    )
    core_stdlib_internal(
        name = "p2_system.diagnostics.tools.dll",
        version = "4.0.1.0",
        ref = "@core_sdk//:core/packs/NETStandard.Library.Ref/2.1.0/ref/netstandard2.1/System.Diagnostics.Tools.dll",
        stdlib_path = "@core_sdk//:core/shared/Microsoft.NETCore.App/3.1.0/System.Diagnostics.Tools.dll",
        deps = [
            ":p2_netstandard.dll",
        ],
    )
    core_stdlib_internal(
        name = "p2_system.diagnostics.tracesource.dll",
        version = "4.0.2.0",
        ref = "@core_sdk//:core/packs/NETStandard.Library.Ref/2.1.0/ref/netstandard2.1/System.Diagnostics.TraceSource.dll",
        stdlib_path = "@core_sdk//:core/shared/Microsoft.NETCore.App/3.1.0/System.Diagnostics.TraceSource.dll",
        deps = [
            ":p2_netstandard.dll",
        ],
    )
    core_stdlib_internal(
        name = "p2_system.diagnostics.tracing.dll",
        version = "4.1.2.0",
        ref = "@core_sdk//:core/packs/NETStandard.Library.Ref/2.1.0/ref/netstandard2.1/System.Diagnostics.Tracing.dll",
        stdlib_path = "@core_sdk//:core/shared/Microsoft.NETCore.App/3.1.0/System.Diagnostics.Tracing.dll",
        deps = [
            ":p2_netstandard.dll",
        ],
    )
    core_stdlib_internal(
        name = "p2_system.dll",
        version = "4.0.0.0",
        ref = "@core_sdk//:core/packs/NETStandard.Library.Ref/2.1.0/ref/netstandard2.1/System.dll",
        stdlib_path = "@core_sdk//:core/shared/Microsoft.NETCore.App/3.1.0/System.dll",
        deps = [
            ":p2_netstandard.dll",
        ],
    )
    core_stdlib_internal(
        name = "p2_system.drawing.dll",
        version = "4.0.0.0",
        ref = "@core_sdk//:core/packs/NETStandard.Library.Ref/2.1.0/ref/netstandard2.1/System.Drawing.dll",
        stdlib_path = "@core_sdk//:core/shared/Microsoft.NETCore.App/3.1.0/System.Drawing.dll",
        deps = [
            ":p2_netstandard.dll",
        ],
    )
    core_stdlib_internal(
        name = "p2_system.drawing.primitives.dll",
        version = "4.0.2.0",
        ref = "@core_sdk//:core/packs/NETStandard.Library.Ref/2.1.0/ref/netstandard2.1/System.Drawing.Primitives.dll",
        stdlib_path = "@core_sdk//:core/shared/Microsoft.NETCore.App/3.1.0/System.Drawing.Primitives.dll",
        deps = [
            ":p2_netstandard.dll",
        ],
    )
    core_stdlib_internal(
        name = "p2_system.dynamic.runtime.dll",
        version = "4.0.11.0",
        ref = "@core_sdk//:core/packs/NETStandard.Library.Ref/2.1.0/ref/netstandard2.1/System.Dynamic.Runtime.dll",
        stdlib_path = "@core_sdk//:core/shared/Microsoft.NETCore.App/3.1.0/System.Dynamic.Runtime.dll",
        deps = [
            ":p2_netstandard.dll",
        ],
    )
    core_stdlib_internal(
        name = "p2_system.globalization.calendars.dll",
        version = "4.0.3.0",
        ref = "@core_sdk//:core/packs/NETStandard.Library.Ref/2.1.0/ref/netstandard2.1/System.Globalization.Calendars.dll",
        stdlib_path = "@core_sdk//:core/shared/Microsoft.NETCore.App/3.1.0/System.Globalization.Calendars.dll",
        deps = [
            ":p2_netstandard.dll",
        ],
    )
    core_stdlib_internal(
        name = "p2_system.globalization.dll",
        version = "4.0.11.0",
        ref = "@core_sdk//:core/packs/NETStandard.Library.Ref/2.1.0/ref/netstandard2.1/System.Globalization.dll",
        stdlib_path = "@core_sdk//:core/shared/Microsoft.NETCore.App/3.1.0/System.Globalization.dll",
        deps = [
            ":p2_netstandard.dll",
        ],
    )
    core_stdlib_internal(
        name = "p2_system.globalization.extensions.dll",
        version = "4.0.3.0",
        ref = "@core_sdk//:core/packs/NETStandard.Library.Ref/2.1.0/ref/netstandard2.1/System.Globalization.Extensions.dll",
        stdlib_path = "@core_sdk//:core/shared/Microsoft.NETCore.App/3.1.0/System.Globalization.Extensions.dll",
        deps = [
            ":p2_netstandard.dll",
        ],
    )
    core_stdlib_internal(
        name = "p2_system.io.compression.dll",
        version = "4.1.3.0",
        ref = "@core_sdk//:core/packs/NETStandard.Library.Ref/2.1.0/ref/netstandard2.1/System.IO.Compression.dll",
        stdlib_path = "@core_sdk//:core/shared/Microsoft.NETCore.App/3.1.0/System.IO.Compression.dll",
        deps = [
            ":p2_netstandard.dll",
        ],
    )
    core_stdlib_internal(
        name = "p2_system.io.compression.filesystem.dll",
        version = "4.0.0.0",
        ref = "@core_sdk//:core/packs/NETStandard.Library.Ref/2.1.0/ref/netstandard2.1/System.IO.Compression.FileSystem.dll",
        stdlib_path = "@core_sdk//:core/shared/Microsoft.NETCore.App/3.1.0/System.IO.Compression.FileSystem.dll",
        deps = [
            ":p2_netstandard.dll",
        ],
    )
    core_stdlib_internal(
        name = "p2_system.io.compression.zipfile.dll",
        version = "4.0.3.0",
        ref = "@core_sdk//:core/packs/NETStandard.Library.Ref/2.1.0/ref/netstandard2.1/System.IO.Compression.ZipFile.dll",
        stdlib_path = "@core_sdk//:core/shared/Microsoft.NETCore.App/3.1.0/System.IO.Compression.ZipFile.dll",
        deps = [
            ":p2_netstandard.dll",
        ],
    )
    core_stdlib_internal(
        name = "p2_system.io.dll",
        version = "4.1.2.0",
        ref = "@core_sdk//:core/packs/NETStandard.Library.Ref/2.1.0/ref/netstandard2.1/System.IO.dll",
        stdlib_path = "@core_sdk//:core/shared/Microsoft.NETCore.App/3.1.0/System.IO.dll",
        deps = [
            ":p2_netstandard.dll",
        ],
    )
    core_stdlib_internal(
        name = "p2_system.io.filesystem.dll",
        version = "4.0.3.0",
        ref = "@core_sdk//:core/packs/NETStandard.Library.Ref/2.1.0/ref/netstandard2.1/System.IO.FileSystem.dll",
        stdlib_path = "@core_sdk//:core/shared/Microsoft.NETCore.App/3.1.0/System.IO.FileSystem.dll",
        deps = [
            ":p2_netstandard.dll",
        ],
    )
    core_stdlib_internal(
        name = "p2_system.io.filesystem.driveinfo.dll",
        version = "4.0.2.0",
        ref = "@core_sdk//:core/packs/NETStandard.Library.Ref/2.1.0/ref/netstandard2.1/System.IO.FileSystem.DriveInfo.dll",
        stdlib_path = "@core_sdk//:core/shared/Microsoft.NETCore.App/3.1.0/System.IO.FileSystem.DriveInfo.dll",
        deps = [
            ":p2_netstandard.dll",
        ],
    )
    core_stdlib_internal(
        name = "p2_system.io.filesystem.primitives.dll",
        version = "4.0.3.0",
        ref = "@core_sdk//:core/packs/NETStandard.Library.Ref/2.1.0/ref/netstandard2.1/System.IO.FileSystem.Primitives.dll",
        stdlib_path = "@core_sdk//:core/shared/Microsoft.NETCore.App/3.1.0/System.IO.FileSystem.Primitives.dll",
        deps = [
            ":p2_netstandard.dll",
        ],
    )
    core_stdlib_internal(
        name = "p2_system.io.filesystem.watcher.dll",
        version = "4.0.2.0",
        ref = "@core_sdk//:core/packs/NETStandard.Library.Ref/2.1.0/ref/netstandard2.1/System.IO.FileSystem.Watcher.dll",
        stdlib_path = "@core_sdk//:core/shared/Microsoft.NETCore.App/3.1.0/System.IO.FileSystem.Watcher.dll",
        deps = [
            ":p2_netstandard.dll",
        ],
    )
    core_stdlib_internal(
        name = "p2_system.io.isolatedstorage.dll",
        version = "4.0.2.0",
        ref = "@core_sdk//:core/packs/NETStandard.Library.Ref/2.1.0/ref/netstandard2.1/System.IO.IsolatedStorage.dll",
        stdlib_path = "@core_sdk//:core/shared/Microsoft.NETCore.App/3.1.0/System.IO.IsolatedStorage.dll",
        deps = [
            ":p2_netstandard.dll",
        ],
    )
    core_stdlib_internal(
        name = "p2_system.io.memorymappedfiles.dll",
        version = "4.0.2.0",
        ref = "@core_sdk//:core/packs/NETStandard.Library.Ref/2.1.0/ref/netstandard2.1/System.IO.MemoryMappedFiles.dll",
        stdlib_path = "@core_sdk//:core/shared/Microsoft.NETCore.App/3.1.0/System.IO.MemoryMappedFiles.dll",
        deps = [
            ":p2_netstandard.dll",
        ],
    )
    core_stdlib_internal(
        name = "p2_system.io.pipes.dll",
        version = "4.0.2.0",
        ref = "@core_sdk//:core/packs/NETStandard.Library.Ref/2.1.0/ref/netstandard2.1/System.IO.Pipes.dll",
        stdlib_path = "@core_sdk//:core/shared/Microsoft.NETCore.App/3.1.0/System.IO.Pipes.dll",
        deps = [
            ":p2_netstandard.dll",
        ],
    )
    core_stdlib_internal(
        name = "p2_system.io.unmanagedmemorystream.dll",
        version = "4.0.3.0",
        ref = "@core_sdk//:core/packs/NETStandard.Library.Ref/2.1.0/ref/netstandard2.1/System.IO.UnmanagedMemoryStream.dll",
        stdlib_path = "@core_sdk//:core/shared/Microsoft.NETCore.App/3.1.0/System.IO.UnmanagedMemoryStream.dll",
        deps = [
            ":p2_netstandard.dll",
        ],
    )
    core_stdlib_internal(
        name = "p2_system.linq.dll",
        version = "4.1.2.0",
        ref = "@core_sdk//:core/packs/NETStandard.Library.Ref/2.1.0/ref/netstandard2.1/System.Linq.dll",
        stdlib_path = "@core_sdk//:core/shared/Microsoft.NETCore.App/3.1.0/System.Linq.dll",
        deps = [
            ":p2_netstandard.dll",
        ],
    )
    core_stdlib_internal(
        name = "p2_system.linq.expressions.dll",
        version = "4.1.2.0",
        ref = "@core_sdk//:core/packs/NETStandard.Library.Ref/2.1.0/ref/netstandard2.1/System.Linq.Expressions.dll",
        stdlib_path = "@core_sdk//:core/shared/Microsoft.NETCore.App/3.1.0/System.Linq.Expressions.dll",
        deps = [
            ":p2_netstandard.dll",
        ],
    )
    core_stdlib_internal(
        name = "p2_system.linq.parallel.dll",
        version = "4.0.1.0",
        ref = "@core_sdk//:core/packs/NETStandard.Library.Ref/2.1.0/ref/netstandard2.1/System.Linq.Parallel.dll",
        stdlib_path = "@core_sdk//:core/shared/Microsoft.NETCore.App/3.1.0/System.Linq.Parallel.dll",
        deps = [
            ":p2_netstandard.dll",
        ],
    )
    core_stdlib_internal(
        name = "p2_system.linq.queryable.dll",
        version = "4.0.1.0",
        ref = "@core_sdk//:core/packs/NETStandard.Library.Ref/2.1.0/ref/netstandard2.1/System.Linq.Queryable.dll",
        stdlib_path = "@core_sdk//:core/shared/Microsoft.NETCore.App/3.1.0/System.Linq.Queryable.dll",
        deps = [
            ":p2_netstandard.dll",
        ],
    )
    core_stdlib_internal(
        name = "p2_system.memory.dll",
        version = "4.0.2.0",
        ref = "@core_sdk//:core/packs/NETStandard.Library.Ref/2.1.0/ref/netstandard2.1/System.Memory.dll",
        stdlib_path = "@core_sdk//:core/shared/Microsoft.NETCore.App/3.1.0/System.Memory.dll",
        deps = [
            ":p2_netstandard.dll",
        ],
    )
    core_stdlib_internal(
        name = "p2_system.net.dll",
        version = "4.0.0.0",
        ref = "@core_sdk//:core/packs/NETStandard.Library.Ref/2.1.0/ref/netstandard2.1/System.Net.dll",
        stdlib_path = "@core_sdk//:core/shared/Microsoft.NETCore.App/3.1.0/System.Net.dll",
        deps = [
            ":p2_netstandard.dll",
        ],
    )
    core_stdlib_internal(
        name = "p2_system.net.http.dll",
        version = "4.1.2.0",
        ref = "@core_sdk//:core/packs/NETStandard.Library.Ref/2.1.0/ref/netstandard2.1/System.Net.Http.dll",
        stdlib_path = "@core_sdk//:core/shared/Microsoft.NETCore.App/3.1.0/System.Net.Http.dll",
        deps = [
            ":p2_netstandard.dll",
        ],
    )
    core_stdlib_internal(
        name = "p2_system.net.nameresolution.dll",
        version = "4.0.2.0",
        ref = "@core_sdk//:core/packs/NETStandard.Library.Ref/2.1.0/ref/netstandard2.1/System.Net.NameResolution.dll",
        stdlib_path = "@core_sdk//:core/shared/Microsoft.NETCore.App/3.1.0/System.Net.NameResolution.dll",
        deps = [
            ":p2_netstandard.dll",
        ],
    )
    core_stdlib_internal(
        name = "p2_system.net.networkinformation.dll",
        version = "4.1.2.0",
        ref = "@core_sdk//:core/packs/NETStandard.Library.Ref/2.1.0/ref/netstandard2.1/System.Net.NetworkInformation.dll",
        stdlib_path = "@core_sdk//:core/shared/Microsoft.NETCore.App/3.1.0/System.Net.NetworkInformation.dll",
        deps = [
            ":p2_netstandard.dll",
        ],
    )
    core_stdlib_internal(
        name = "p2_system.net.ping.dll",
        version = "4.0.2.0",
        ref = "@core_sdk//:core/packs/NETStandard.Library.Ref/2.1.0/ref/netstandard2.1/System.Net.Ping.dll",
        stdlib_path = "@core_sdk//:core/shared/Microsoft.NETCore.App/3.1.0/System.Net.Ping.dll",
        deps = [
            ":p2_netstandard.dll",
        ],
    )
    core_stdlib_internal(
        name = "p2_system.net.primitives.dll",
        version = "4.0.11.0",
        ref = "@core_sdk//:core/packs/NETStandard.Library.Ref/2.1.0/ref/netstandard2.1/System.Net.Primitives.dll",
        stdlib_path = "@core_sdk//:core/shared/Microsoft.NETCore.App/3.1.0/System.Net.Primitives.dll",
        deps = [
            ":p2_netstandard.dll",
        ],
    )
    core_stdlib_internal(
        name = "p2_system.net.requests.dll",
        version = "4.0.11.0",
        ref = "@core_sdk//:core/packs/NETStandard.Library.Ref/2.1.0/ref/netstandard2.1/System.Net.Requests.dll",
        stdlib_path = "@core_sdk//:core/shared/Microsoft.NETCore.App/3.1.0/System.Net.Requests.dll",
        deps = [
            ":p2_netstandard.dll",
        ],
    )
    core_stdlib_internal(
        name = "p2_system.net.security.dll",
        version = "4.0.2.0",
        ref = "@core_sdk//:core/packs/NETStandard.Library.Ref/2.1.0/ref/netstandard2.1/System.Net.Security.dll",
        stdlib_path = "@core_sdk//:core/shared/Microsoft.NETCore.App/3.1.0/System.Net.Security.dll",
        deps = [
            ":p2_netstandard.dll",
        ],
    )
    core_stdlib_internal(
        name = "p2_system.net.sockets.dll",
        version = "4.1.2.0",
        ref = "@core_sdk//:core/packs/NETStandard.Library.Ref/2.1.0/ref/netstandard2.1/System.Net.Sockets.dll",
        stdlib_path = "@core_sdk//:core/shared/Microsoft.NETCore.App/3.1.0/System.Net.Sockets.dll",
        deps = [
            ":p2_netstandard.dll",
        ],
    )
    core_stdlib_internal(
        name = "p2_system.net.webheadercollection.dll",
        version = "4.0.1.0",
        ref = "@core_sdk//:core/packs/NETStandard.Library.Ref/2.1.0/ref/netstandard2.1/System.Net.WebHeaderCollection.dll",
        stdlib_path = "@core_sdk//:core/shared/Microsoft.NETCore.App/3.1.0/System.Net.WebHeaderCollection.dll",
        deps = [
            ":p2_netstandard.dll",
        ],
    )
    core_stdlib_internal(
        name = "p2_system.net.websockets.client.dll",
        version = "4.0.2.0",
        ref = "@core_sdk//:core/packs/NETStandard.Library.Ref/2.1.0/ref/netstandard2.1/System.Net.WebSockets.Client.dll",
        stdlib_path = "@core_sdk//:core/shared/Microsoft.NETCore.App/3.1.0/System.Net.WebSockets.Client.dll",
        deps = [
            ":p2_netstandard.dll",
        ],
    )
    core_stdlib_internal(
        name = "p2_system.net.websockets.dll",
        version = "4.0.2.0",
        ref = "@core_sdk//:core/packs/NETStandard.Library.Ref/2.1.0/ref/netstandard2.1/System.Net.WebSockets.dll",
        stdlib_path = "@core_sdk//:core/shared/Microsoft.NETCore.App/3.1.0/System.Net.WebSockets.dll",
        deps = [
            ":p2_netstandard.dll",
        ],
    )
    core_stdlib_internal(
        name = "p2_system.numerics.dll",
        version = "4.0.0.0",
        ref = "@core_sdk//:core/packs/NETStandard.Library.Ref/2.1.0/ref/netstandard2.1/System.Numerics.dll",
        stdlib_path = "@core_sdk//:core/shared/Microsoft.NETCore.App/3.1.0/System.Numerics.dll",
        deps = [
            ":p2_netstandard.dll",
        ],
    )
    core_stdlib_internal(
        name = "p2_system.numerics.vectors.dll",
        version = "4.1.5.0",
        ref = "@core_sdk//:core/packs/NETStandard.Library.Ref/2.1.0/ref/netstandard2.1/System.Numerics.Vectors.dll",
        stdlib_path = "@core_sdk//:core/shared/Microsoft.NETCore.App/3.1.0/System.Numerics.Vectors.dll",
        deps = [
            ":p2_netstandard.dll",
        ],
    )
    core_stdlib_internal(
        name = "p2_system.objectmodel.dll",
        version = "4.0.11.0",
        ref = "@core_sdk//:core/packs/NETStandard.Library.Ref/2.1.0/ref/netstandard2.1/System.ObjectModel.dll",
        stdlib_path = "@core_sdk//:core/shared/Microsoft.NETCore.App/3.1.0/System.ObjectModel.dll",
        deps = [
            ":p2_netstandard.dll",
        ],
    )
    core_stdlib_internal(
        name = "p2_system.reflection.dispatchproxy.dll",
        version = "4.0.5.0",
        ref = "@core_sdk//:core/packs/NETStandard.Library.Ref/2.1.0/ref/netstandard2.1/System.Reflection.DispatchProxy.dll",
        stdlib_path = "@core_sdk//:core/shared/Microsoft.NETCore.App/3.1.0/System.Reflection.DispatchProxy.dll",
        deps = [
            ":p2_netstandard.dll",
        ],
    )
    core_stdlib_internal(
        name = "p2_system.reflection.dll",
        version = "4.1.2.0",
        ref = "@core_sdk//:core/packs/NETStandard.Library.Ref/2.1.0/ref/netstandard2.1/System.Reflection.dll",
        stdlib_path = "@core_sdk//:core/shared/Microsoft.NETCore.App/3.1.0/System.Reflection.dll",
        deps = [
            ":p2_netstandard.dll",
        ],
    )
    core_stdlib_internal(
        name = "p2_system.reflection.emit.dll",
        version = "4.0.1.0",
        ref = "@core_sdk//:core/packs/NETStandard.Library.Ref/2.1.0/ref/netstandard2.1/System.Reflection.Emit.dll",
        stdlib_path = "@core_sdk//:core/shared/Microsoft.NETCore.App/3.1.0/System.Reflection.Emit.dll",
        deps = [
            ":p2_netstandard.dll",
        ],
    )
    core_stdlib_internal(
        name = "p2_system.reflection.emit.ilgeneration.dll",
        version = "4.0.1.0",
        ref = "@core_sdk//:core/packs/NETStandard.Library.Ref/2.1.0/ref/netstandard2.1/System.Reflection.Emit.ILGeneration.dll",
        stdlib_path = "@core_sdk//:core/shared/Microsoft.NETCore.App/3.1.0/System.Reflection.Emit.ILGeneration.dll",
        deps = [
            ":p2_netstandard.dll",
        ],
    )
    core_stdlib_internal(
        name = "p2_system.reflection.emit.lightweight.dll",
        version = "4.0.1.0",
        ref = "@core_sdk//:core/packs/NETStandard.Library.Ref/2.1.0/ref/netstandard2.1/System.Reflection.Emit.Lightweight.dll",
        stdlib_path = "@core_sdk//:core/shared/Microsoft.NETCore.App/3.1.0/System.Reflection.Emit.Lightweight.dll",
        deps = [
            ":p2_netstandard.dll",
        ],
    )
    core_stdlib_internal(
        name = "p2_system.reflection.extensions.dll",
        version = "4.0.1.0",
        ref = "@core_sdk//:core/packs/NETStandard.Library.Ref/2.1.0/ref/netstandard2.1/System.Reflection.Extensions.dll",
        stdlib_path = "@core_sdk//:core/shared/Microsoft.NETCore.App/3.1.0/System.Reflection.Extensions.dll",
        deps = [
            ":p2_netstandard.dll",
        ],
    )
    core_stdlib_internal(
        name = "p2_system.reflection.primitives.dll",
        version = "4.0.1.0",
        ref = "@core_sdk//:core/packs/NETStandard.Library.Ref/2.1.0/ref/netstandard2.1/System.Reflection.Primitives.dll",
        stdlib_path = "@core_sdk//:core/shared/Microsoft.NETCore.App/3.1.0/System.Reflection.Primitives.dll",
        deps = [
            ":p2_netstandard.dll",
        ],
    )
    core_stdlib_internal(
        name = "p2_system.resources.reader.dll",
        version = "4.0.2.0",
        ref = "@core_sdk//:core/packs/NETStandard.Library.Ref/2.1.0/ref/netstandard2.1/System.Resources.Reader.dll",
        stdlib_path = "@core_sdk//:core/shared/Microsoft.NETCore.App/3.1.0/System.Resources.Reader.dll",
        deps = [
            ":p2_netstandard.dll",
        ],
    )
    core_stdlib_internal(
        name = "p2_system.resources.resourcemanager.dll",
        version = "4.0.1.0",
        ref = "@core_sdk//:core/packs/NETStandard.Library.Ref/2.1.0/ref/netstandard2.1/System.Resources.ResourceManager.dll",
        stdlib_path = "@core_sdk//:core/shared/Microsoft.NETCore.App/3.1.0/System.Resources.ResourceManager.dll",
        deps = [
            ":p2_netstandard.dll",
        ],
    )
    core_stdlib_internal(
        name = "p2_system.resources.writer.dll",
        version = "4.0.2.0",
        ref = "@core_sdk//:core/packs/NETStandard.Library.Ref/2.1.0/ref/netstandard2.1/System.Resources.Writer.dll",
        stdlib_path = "@core_sdk//:core/shared/Microsoft.NETCore.App/3.1.0/System.Resources.Writer.dll",
        deps = [
            ":p2_netstandard.dll",
        ],
    )
    core_stdlib_internal(
        name = "p2_system.runtime.compilerservices.visualc.dll",
        version = "4.0.2.0",
        ref = "@core_sdk//:core/packs/NETStandard.Library.Ref/2.1.0/ref/netstandard2.1/System.Runtime.CompilerServices.VisualC.dll",
        stdlib_path = "@core_sdk//:core/shared/Microsoft.NETCore.App/3.1.0/System.Runtime.CompilerServices.VisualC.dll",
        deps = [
            ":p2_netstandard.dll",
        ],
    )
    core_stdlib_internal(
        name = "p2_system.runtime.dll",
        version = "4.1.2.0",
        ref = "@core_sdk//:core/packs/NETStandard.Library.Ref/2.1.0/ref/netstandard2.1/System.Runtime.dll",
        stdlib_path = "@core_sdk//:core/shared/Microsoft.NETCore.App/3.1.0/System.Runtime.dll",
        deps = [
            ":p2_netstandard.dll",
        ],
    )
    core_stdlib_internal(
        name = "p2_system.runtime.extensions.dll",
        version = "4.1.2.0",
        ref = "@core_sdk//:core/packs/NETStandard.Library.Ref/2.1.0/ref/netstandard2.1/System.Runtime.Extensions.dll",
        stdlib_path = "@core_sdk//:core/shared/Microsoft.NETCore.App/3.1.0/System.Runtime.Extensions.dll",
        deps = [
            ":p2_netstandard.dll",
        ],
    )
    core_stdlib_internal(
        name = "p2_system.runtime.handles.dll",
        version = "4.0.1.0",
        ref = "@core_sdk//:core/packs/NETStandard.Library.Ref/2.1.0/ref/netstandard2.1/System.Runtime.Handles.dll",
        stdlib_path = "@core_sdk//:core/shared/Microsoft.NETCore.App/3.1.0/System.Runtime.Handles.dll",
        deps = [
            ":p2_netstandard.dll",
        ],
    )
    core_stdlib_internal(
        name = "p2_system.runtime.interopservices.dll",
        version = "4.1.2.0",
        ref = "@core_sdk//:core/packs/NETStandard.Library.Ref/2.1.0/ref/netstandard2.1/System.Runtime.InteropServices.dll",
        stdlib_path = "@core_sdk//:core/shared/Microsoft.NETCore.App/3.1.0/System.Runtime.InteropServices.dll",
        deps = [
            ":p2_netstandard.dll",
        ],
    )
    core_stdlib_internal(
        name = "p2_system.runtime.interopservices.runtimeinformation.dll",
        version = "4.0.2.0",
        ref = "@core_sdk//:core/packs/NETStandard.Library.Ref/2.1.0/ref/netstandard2.1/System.Runtime.InteropServices.RuntimeInformation.dll",
        stdlib_path = "@core_sdk//:core/shared/Microsoft.NETCore.App/3.1.0/System.Runtime.InteropServices.RuntimeInformation.dll",
        deps = [
            ":p2_netstandard.dll",
        ],
    )
    core_stdlib_internal(
        name = "p2_system.runtime.numerics.dll",
        version = "4.0.1.0",
        ref = "@core_sdk//:core/packs/NETStandard.Library.Ref/2.1.0/ref/netstandard2.1/System.Runtime.Numerics.dll",
        stdlib_path = "@core_sdk//:core/shared/Microsoft.NETCore.App/3.1.0/System.Runtime.Numerics.dll",
        deps = [
            ":p2_netstandard.dll",
        ],
    )
    core_stdlib_internal(
        name = "p2_system.runtime.serialization.dll",
        version = "4.0.0.0",
        ref = "@core_sdk//:core/packs/NETStandard.Library.Ref/2.1.0/ref/netstandard2.1/System.Runtime.Serialization.dll",
        stdlib_path = "@core_sdk//:core/shared/Microsoft.NETCore.App/3.1.0/System.Runtime.Serialization.dll",
        deps = [
            ":p2_netstandard.dll",
        ],
    )
    core_stdlib_internal(
        name = "p2_system.runtime.serialization.formatters.dll",
        version = "4.0.2.0",
        ref = "@core_sdk//:core/packs/NETStandard.Library.Ref/2.1.0/ref/netstandard2.1/System.Runtime.Serialization.Formatters.dll",
        stdlib_path = "@core_sdk//:core/shared/Microsoft.NETCore.App/3.1.0/System.Runtime.Serialization.Formatters.dll",
        deps = [
            ":p2_netstandard.dll",
        ],
    )
    core_stdlib_internal(
        name = "p2_system.runtime.serialization.json.dll",
        version = "4.0.1.0",
        ref = "@core_sdk//:core/packs/NETStandard.Library.Ref/2.1.0/ref/netstandard2.1/System.Runtime.Serialization.Json.dll",
        stdlib_path = "@core_sdk//:core/shared/Microsoft.NETCore.App/3.1.0/System.Runtime.Serialization.Json.dll",
        deps = [
            ":p2_netstandard.dll",
        ],
    )
    core_stdlib_internal(
        name = "p2_system.runtime.serialization.primitives.dll",
        version = "4.1.3.0",
        ref = "@core_sdk//:core/packs/NETStandard.Library.Ref/2.1.0/ref/netstandard2.1/System.Runtime.Serialization.Primitives.dll",
        stdlib_path = "@core_sdk//:core/shared/Microsoft.NETCore.App/3.1.0/System.Runtime.Serialization.Primitives.dll",
        deps = [
            ":p2_netstandard.dll",
        ],
    )
    core_stdlib_internal(
        name = "p2_system.runtime.serialization.xml.dll",
        version = "4.1.3.0",
        ref = "@core_sdk//:core/packs/NETStandard.Library.Ref/2.1.0/ref/netstandard2.1/System.Runtime.Serialization.Xml.dll",
        stdlib_path = "@core_sdk//:core/shared/Microsoft.NETCore.App/3.1.0/System.Runtime.Serialization.Xml.dll",
        deps = [
            ":p2_netstandard.dll",
        ],
    )
    core_stdlib_internal(
        name = "p2_system.security.claims.dll",
        version = "4.0.3.0",
        ref = "@core_sdk//:core/packs/NETStandard.Library.Ref/2.1.0/ref/netstandard2.1/System.Security.Claims.dll",
        stdlib_path = "@core_sdk//:core/shared/Microsoft.NETCore.App/3.1.0/System.Security.Claims.dll",
        deps = [
            ":p2_netstandard.dll",
        ],
    )
    core_stdlib_internal(
        name = "p2_system.security.cryptography.algorithms.dll",
        version = "4.2.2.0",
        ref = "@core_sdk//:core/packs/NETStandard.Library.Ref/2.1.0/ref/netstandard2.1/System.Security.Cryptography.Algorithms.dll",
        stdlib_path = "@core_sdk//:core/shared/Microsoft.NETCore.App/3.1.0/System.Security.Cryptography.Algorithms.dll",
        deps = [
            ":p2_netstandard.dll",
        ],
    )
    core_stdlib_internal(
        name = "p2_system.security.cryptography.csp.dll",
        version = "4.0.2.0",
        ref = "@core_sdk//:core/packs/NETStandard.Library.Ref/2.1.0/ref/netstandard2.1/System.Security.Cryptography.Csp.dll",
        stdlib_path = "@core_sdk//:core/shared/Microsoft.NETCore.App/3.1.0/System.Security.Cryptography.Csp.dll",
        deps = [
            ":p2_netstandard.dll",
        ],
    )
    core_stdlib_internal(
        name = "p2_system.security.cryptography.encoding.dll",
        version = "4.0.2.0",
        ref = "@core_sdk//:core/packs/NETStandard.Library.Ref/2.1.0/ref/netstandard2.1/System.Security.Cryptography.Encoding.dll",
        stdlib_path = "@core_sdk//:core/shared/Microsoft.NETCore.App/3.1.0/System.Security.Cryptography.Encoding.dll",
        deps = [
            ":p2_netstandard.dll",
        ],
    )
    core_stdlib_internal(
        name = "p2_system.security.cryptography.primitives.dll",
        version = "4.0.2.0",
        ref = "@core_sdk//:core/packs/NETStandard.Library.Ref/2.1.0/ref/netstandard2.1/System.Security.Cryptography.Primitives.dll",
        stdlib_path = "@core_sdk//:core/shared/Microsoft.NETCore.App/3.1.0/System.Security.Cryptography.Primitives.dll",
        deps = [
            ":p2_netstandard.dll",
        ],
    )
    core_stdlib_internal(
        name = "p2_system.security.cryptography.x509certificates.dll",
        version = "4.1.2.0",
        ref = "@core_sdk//:core/packs/NETStandard.Library.Ref/2.1.0/ref/netstandard2.1/System.Security.Cryptography.X509Certificates.dll",
        stdlib_path = "@core_sdk//:core/shared/Microsoft.NETCore.App/3.1.0/System.Security.Cryptography.X509Certificates.dll",
        deps = [
            ":p2_netstandard.dll",
        ],
    )
    core_stdlib_internal(
        name = "p2_system.security.principal.dll",
        version = "4.0.1.0",
        ref = "@core_sdk//:core/packs/NETStandard.Library.Ref/2.1.0/ref/netstandard2.1/System.Security.Principal.dll",
        stdlib_path = "@core_sdk//:core/shared/Microsoft.NETCore.App/3.1.0/System.Security.Principal.dll",
        deps = [
            ":p2_netstandard.dll",
        ],
    )
    core_stdlib_internal(
        name = "p2_system.security.securestring.dll",
        version = "4.0.2.0",
        ref = "@core_sdk//:core/packs/NETStandard.Library.Ref/2.1.0/ref/netstandard2.1/System.Security.SecureString.dll",
        stdlib_path = "@core_sdk//:core/shared/Microsoft.NETCore.App/3.1.0/System.Security.SecureString.dll",
        deps = [
            ":p2_netstandard.dll",
        ],
    )
    core_stdlib_internal(
        name = "p2_system.servicemodel.web.dll",
        version = "4.0.0.0",
        ref = "@core_sdk//:core/packs/NETStandard.Library.Ref/2.1.0/ref/netstandard2.1/System.ServiceModel.Web.dll",
        stdlib_path = "@core_sdk//:core/shared/Microsoft.NETCore.App/3.1.0/System.ServiceModel.Web.dll",
        deps = [
            ":p2_netstandard.dll",
        ],
    )
    core_stdlib_internal(
        name = "p2_system.text.encoding.dll",
        version = "4.0.11.0",
        ref = "@core_sdk//:core/packs/NETStandard.Library.Ref/2.1.0/ref/netstandard2.1/System.Text.Encoding.dll",
        stdlib_path = "@core_sdk//:core/shared/Microsoft.NETCore.App/3.1.0/System.Text.Encoding.dll",
        deps = [
            ":p2_netstandard.dll",
        ],
    )
    core_stdlib_internal(
        name = "p2_system.text.encoding.extensions.dll",
        version = "4.0.11.0",
        ref = "@core_sdk//:core/packs/NETStandard.Library.Ref/2.1.0/ref/netstandard2.1/System.Text.Encoding.Extensions.dll",
        stdlib_path = "@core_sdk//:core/shared/Microsoft.NETCore.App/3.1.0/System.Text.Encoding.Extensions.dll",
        deps = [
            ":p2_netstandard.dll",
        ],
    )
    core_stdlib_internal(
        name = "p2_system.text.regularexpressions.dll",
        version = "4.1.1.0",
        ref = "@core_sdk//:core/packs/NETStandard.Library.Ref/2.1.0/ref/netstandard2.1/System.Text.RegularExpressions.dll",
        stdlib_path = "@core_sdk//:core/shared/Microsoft.NETCore.App/3.1.0/System.Text.RegularExpressions.dll",
        deps = [
            ":p2_netstandard.dll",
        ],
    )
    core_stdlib_internal(
        name = "p2_system.threading.dll",
        version = "4.0.11.0",
        ref = "@core_sdk//:core/packs/NETStandard.Library.Ref/2.1.0/ref/netstandard2.1/System.Threading.dll",
        stdlib_path = "@core_sdk//:core/shared/Microsoft.NETCore.App/3.1.0/System.Threading.dll",
        deps = [
            ":p2_netstandard.dll",
        ],
    )
    core_stdlib_internal(
        name = "p2_system.threading.overlapped.dll",
        version = "4.0.3.0",
        ref = "@core_sdk//:core/packs/NETStandard.Library.Ref/2.1.0/ref/netstandard2.1/System.Threading.Overlapped.dll",
        stdlib_path = "@core_sdk//:core/shared/Microsoft.NETCore.App/3.1.0/System.Threading.Overlapped.dll",
        deps = [
            ":p2_netstandard.dll",
        ],
    )
    core_stdlib_internal(
        name = "p2_system.threading.tasks.dll",
        version = "4.0.11.0",
        ref = "@core_sdk//:core/packs/NETStandard.Library.Ref/2.1.0/ref/netstandard2.1/System.Threading.Tasks.dll",
        stdlib_path = "@core_sdk//:core/shared/Microsoft.NETCore.App/3.1.0/System.Threading.Tasks.dll",
        deps = [
            ":p2_netstandard.dll",
        ],
    )
    core_stdlib_internal(
        name = "p2_system.threading.tasks.extensions.dll",
        version = "4.2.1.0",
        ref = "@core_sdk//:core/packs/NETStandard.Library.Ref/2.1.0/ref/netstandard2.1/System.Threading.Tasks.Extensions.dll",
        stdlib_path = "@core_sdk//:core/shared/Microsoft.NETCore.App/3.1.0/System.Threading.Tasks.Extensions.dll",
        deps = [
            ":p2_netstandard.dll",
        ],
    )
    core_stdlib_internal(
        name = "p2_system.threading.tasks.parallel.dll",
        version = "4.0.1.0",
        ref = "@core_sdk//:core/packs/NETStandard.Library.Ref/2.1.0/ref/netstandard2.1/System.Threading.Tasks.Parallel.dll",
        stdlib_path = "@core_sdk//:core/shared/Microsoft.NETCore.App/3.1.0/System.Threading.Tasks.Parallel.dll",
        deps = [
            ":p2_netstandard.dll",
        ],
    )
    core_stdlib_internal(
        name = "p2_system.threading.thread.dll",
        version = "4.0.2.0",
        ref = "@core_sdk//:core/packs/NETStandard.Library.Ref/2.1.0/ref/netstandard2.1/System.Threading.Thread.dll",
        stdlib_path = "@core_sdk//:core/shared/Microsoft.NETCore.App/3.1.0/System.Threading.Thread.dll",
        deps = [
            ":p2_netstandard.dll",
        ],
    )
    core_stdlib_internal(
        name = "p2_system.threading.threadpool.dll",
        version = "4.0.12.0",
        ref = "@core_sdk//:core/packs/NETStandard.Library.Ref/2.1.0/ref/netstandard2.1/System.Threading.ThreadPool.dll",
        stdlib_path = "@core_sdk//:core/shared/Microsoft.NETCore.App/3.1.0/System.Threading.ThreadPool.dll",
        deps = [
            ":p2_netstandard.dll",
        ],
    )
    core_stdlib_internal(
        name = "p2_system.threading.timer.dll",
        version = "4.0.1.0",
        ref = "@core_sdk//:core/packs/NETStandard.Library.Ref/2.1.0/ref/netstandard2.1/System.Threading.Timer.dll",
        stdlib_path = "@core_sdk//:core/shared/Microsoft.NETCore.App/3.1.0/System.Threading.Timer.dll",
        deps = [
            ":p2_netstandard.dll",
        ],
    )
    core_stdlib_internal(
        name = "p2_system.transactions.dll",
        version = "4.0.0.0",
        ref = "@core_sdk//:core/packs/NETStandard.Library.Ref/2.1.0/ref/netstandard2.1/System.Transactions.dll",
        stdlib_path = "@core_sdk//:core/shared/Microsoft.NETCore.App/3.1.0/System.Transactions.dll",
        deps = [
            ":p2_netstandard.dll",
        ],
    )
    core_stdlib_internal(
        name = "p2_system.valuetuple.dll",
        version = "4.0.2.0",
        ref = "@core_sdk//:core/packs/NETStandard.Library.Ref/2.1.0/ref/netstandard2.1/System.ValueTuple.dll",
        stdlib_path = "@core_sdk//:core/shared/Microsoft.NETCore.App/3.1.0/System.ValueTuple.dll",
        deps = [
            ":p2_netstandard.dll",
        ],
    )
    core_stdlib_internal(
        name = "p2_system.web.dll",
        version = "4.0.0.0",
        ref = "@core_sdk//:core/packs/NETStandard.Library.Ref/2.1.0/ref/netstandard2.1/System.Web.dll",
        stdlib_path = "@core_sdk//:core/shared/Microsoft.NETCore.App/3.1.0/System.Web.dll",
        deps = [
            ":p2_netstandard.dll",
        ],
    )
    core_stdlib_internal(
        name = "p2_system.windows.dll",
        version = "4.0.0.0",
        ref = "@core_sdk//:core/packs/NETStandard.Library.Ref/2.1.0/ref/netstandard2.1/System.Windows.dll",
        stdlib_path = "@core_sdk//:core/shared/Microsoft.NETCore.App/3.1.0/System.Windows.dll",
        deps = [
            ":p2_netstandard.dll",
        ],
    )
    core_stdlib_internal(
        name = "p2_system.xml.dll",
        version = "4.0.0.0",
        ref = "@core_sdk//:core/packs/NETStandard.Library.Ref/2.1.0/ref/netstandard2.1/System.Xml.dll",
        stdlib_path = "@core_sdk//:core/shared/Microsoft.NETCore.App/3.1.0/System.Xml.dll",
        deps = [
            ":p2_netstandard.dll",
        ],
    )
    core_stdlib_internal(
        name = "p2_system.xml.linq.dll",
        version = "4.0.0.0",
        ref = "@core_sdk//:core/packs/NETStandard.Library.Ref/2.1.0/ref/netstandard2.1/System.Xml.Linq.dll",
        stdlib_path = "@core_sdk//:core/shared/Microsoft.NETCore.App/3.1.0/System.Xml.Linq.dll",
        deps = [
            ":p2_netstandard.dll",
        ],
    )
    core_stdlib_internal(
        name = "p2_system.xml.readerwriter.dll",
        version = "4.1.1.0",
        ref = "@core_sdk//:core/packs/NETStandard.Library.Ref/2.1.0/ref/netstandard2.1/System.Xml.ReaderWriter.dll",
        stdlib_path = "@core_sdk//:core/shared/Microsoft.NETCore.App/3.1.0/System.Xml.ReaderWriter.dll",
        deps = [
            ":p2_netstandard.dll",
        ],
    )
    core_stdlib_internal(
        name = "p2_system.xml.serialization.dll",
        version = "4.0.0.0",
        ref = "@core_sdk//:core/packs/NETStandard.Library.Ref/2.1.0/ref/netstandard2.1/System.Xml.Serialization.dll",
        stdlib_path = "@core_sdk//:core/shared/Microsoft.NETCore.App/3.1.0/System.Xml.Serialization.dll",
        deps = [
            ":p2_netstandard.dll",
        ],
    )
    core_stdlib_internal(
        name = "p2_system.xml.xdocument.dll",
        version = "4.0.11.0",
        ref = "@core_sdk//:core/packs/NETStandard.Library.Ref/2.1.0/ref/netstandard2.1/System.Xml.XDocument.dll",
        stdlib_path = "@core_sdk//:core/shared/Microsoft.NETCore.App/3.1.0/System.Xml.XDocument.dll",
        deps = [
            ":p2_netstandard.dll",
        ],
    )
    core_stdlib_internal(
        name = "p2_system.xml.xmldocument.dll",
        version = "4.0.3.0",
        ref = "@core_sdk//:core/packs/NETStandard.Library.Ref/2.1.0/ref/netstandard2.1/System.Xml.XmlDocument.dll",
        stdlib_path = "@core_sdk//:core/shared/Microsoft.NETCore.App/3.1.0/System.Xml.XmlDocument.dll",
        deps = [
            ":p2_netstandard.dll",
        ],
    )
    core_stdlib_internal(
        name = "p2_system.xml.xmlserializer.dll",
        version = "4.0.11.0",
        ref = "@core_sdk//:core/packs/NETStandard.Library.Ref/2.1.0/ref/netstandard2.1/System.Xml.XmlSerializer.dll",
        stdlib_path = "@core_sdk//:core/shared/Microsoft.NETCore.App/3.1.0/System.Xml.XmlSerializer.dll",
        deps = [
            ":p2_netstandard.dll",
        ],
    )
    core_stdlib_internal(
        name = "p2_system.xml.xpath.dll",
        version = "4.0.3.0",
        ref = "@core_sdk//:core/packs/NETStandard.Library.Ref/2.1.0/ref/netstandard2.1/System.Xml.XPath.dll",
        stdlib_path = "@core_sdk//:core/shared/Microsoft.NETCore.App/3.1.0/System.Xml.XPath.dll",
        deps = [
            ":p2_netstandard.dll",
        ],
    )
    core_stdlib_internal(
        name = "p2_system.xml.xpath.xdocument.dll",
        version = "4.0.3.0",
        ref = "@core_sdk//:core/packs/NETStandard.Library.Ref/2.1.0/ref/netstandard2.1/System.Xml.XPath.XDocument.dll",
        stdlib_path = "@core_sdk//:core/shared/Microsoft.NETCore.App/3.1.0/System.Xml.XPath.XDocument.dll",
        deps = [
            ":p2_netstandard.dll",
        ],
    )
