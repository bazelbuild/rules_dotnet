load("@io_bazel_rules_dotnet//dotnet/private:rules/stdlib.bzl", "netstandard_stdlib")

def all_netstandard_stdlib(framework):
    if framework:
        context = "@io_bazel_rules_dotnet//:netstandard_context_data_{}".format(framework)
    else:
        context = "@io_bazel_rules_dotnet//:netstandard_context_data"

    netstandard_stdlib(
        name = "microsoft.win32.primitives.dll",
        deps = [
        ],
        dotnet_context_data = context,
    )
    netstandard_stdlib(
        name = "system.appcontext.dll",
        deps = [
        ],
        dotnet_context_data = context,
    )
    netstandard_stdlib(
        name = "system.collections.concurrent.dll",
        deps = [
        ],
        dotnet_context_data = context,
    )
    netstandard_stdlib(
        name = "system.collections.dll",
        deps = [
        ],
        dotnet_context_data = context,
    )
    netstandard_stdlib(
        name = "system.collections.nongeneric.dll",
        deps = [
        ],
        dotnet_context_data = context,
    )
    netstandard_stdlib(
        name = "system.collections.specialized.dll",
        deps = [
        ],
        dotnet_context_data = context,
    )
    netstandard_stdlib(
        name = "system.componentmodel.composition.dll",
        deps = [
        ],
        dotnet_context_data = context,
    )
    netstandard_stdlib(
        name = "system.componentmodel.dll",
        deps = [
        ],
        dotnet_context_data = context,
    )
    netstandard_stdlib(
        name = "system.componentmodel.eventbasedasync.dll",
        deps = [
        ],
        dotnet_context_data = context,
    )
    netstandard_stdlib(
        name = "system.componentmodel.primitives.dll",
        deps = [
        ],
        dotnet_context_data = context,
    )
    netstandard_stdlib(
        name = "system.componentmodel.typeconverter.dll",
        deps = [
        ],
        dotnet_context_data = context,
    )
    netstandard_stdlib(
        name = "system.console.dll",
        deps = [
        ],
        dotnet_context_data = context,
    )
    netstandard_stdlib(
        name = "system.core.dll",
        deps = [
        ],
        dotnet_context_data = context,
    )
    netstandard_stdlib(
        name = "system.data.common.dll",
        deps = [
        ],
        dotnet_context_data = context,
    )
    netstandard_stdlib(
        name = "system.data.dll",
        deps = [
        ],
        dotnet_context_data = context,
    )
    netstandard_stdlib(
        name = "system.diagnostics.contracts.dll",
        deps = [
        ],
        dotnet_context_data = context,
    )
    netstandard_stdlib(
        name = "system.diagnostics.debug.dll",
        deps = [
        ],
        dotnet_context_data = context,
    )
    netstandard_stdlib(
        name = "system.diagnostics.fileversioninfo.dll",
        deps = [
        ],
        dotnet_context_data = context,
    )
    netstandard_stdlib(
        name = "system.diagnostics.process.dll",
        deps = [
        ],
        dotnet_context_data = context,
    )
    netstandard_stdlib(
        name = "system.diagnostics.stacktrace.dll",
        deps = [
        ],
        dotnet_context_data = context,
    )
    netstandard_stdlib(
        name = "system.diagnostics.textwritertracelistener.dll",
        deps = [
        ],
        dotnet_context_data = context,
    )
    netstandard_stdlib(
        name = "system.diagnostics.tools.dll",
        deps = [
        ],
        dotnet_context_data = context,
    )
    netstandard_stdlib(
        name = "system.diagnostics.tracesource.dll",
        deps = [
        ],
        dotnet_context_data = context,
    )
    netstandard_stdlib(
        name = "system.diagnostics.tracing.dll",
        deps = [
        ],
        dotnet_context_data = context,
    )
    netstandard_stdlib(
        name = "system.dll",
        deps = [
        ],
        dotnet_context_data = context,
    )
    netstandard_stdlib(
        name = "system.drawing.dll",
        deps = [
        ],
        dotnet_context_data = context,
    )
    netstandard_stdlib(
        name = "system.drawing.primitives.dll",
        deps = [
        ],
        dotnet_context_data = context,
    )
    netstandard_stdlib(
        name = "system.dynamic.runtime.dll",
        deps = [
        ],
        dotnet_context_data = context,
    )
    netstandard_stdlib(
        name = "system.globalization.calendars.dll",
        deps = [
        ],
        dotnet_context_data = context,
    )
    netstandard_stdlib(
        name = "system.globalization.dll",
        deps = [
        ],
        dotnet_context_data = context,
    )
    netstandard_stdlib(
        name = "system.globalization.extensions.dll",
        deps = [
        ],
        dotnet_context_data = context,
    )
    netstandard_stdlib(
        name = "system.io.compression.dll",
        deps = [
        ],
        dotnet_context_data = context,
    )
    netstandard_stdlib(
        name = "system.io.compression.filesystem.dll",
        deps = [
        ],
        dotnet_context_data = context,
    )
    netstandard_stdlib(
        name = "system.io.compression.zipfile.dll",
        deps = [
        ],
        dotnet_context_data = context,
    )
    netstandard_stdlib(
        name = "system.io.dll",
        deps = [
        ],
        dotnet_context_data = context,
    )
    netstandard_stdlib(
        name = "system.io.filesystem.dll",
        deps = [
        ],
        dotnet_context_data = context,
    )
    netstandard_stdlib(
        name = "system.io.filesystem.driveinfo.dll",
        deps = [
        ],
        dotnet_context_data = context,
    )
    netstandard_stdlib(
        name = "system.io.filesystem.primitives.dll",
        deps = [
        ],
        dotnet_context_data = context,
    )
    netstandard_stdlib(
        name = "system.io.filesystem.watcher.dll",
        deps = [
        ],
        dotnet_context_data = context,
    )
    netstandard_stdlib(
        name = "system.io.isolatedstorage.dll",
        deps = [
        ],
        dotnet_context_data = context,
    )
    netstandard_stdlib(
        name = "system.io.memorymappedfiles.dll",
        deps = [
        ],
        dotnet_context_data = context,
    )
    netstandard_stdlib(
        name = "system.io.pipes.dll",
        deps = [
        ],
        dotnet_context_data = context,
    )
    netstandard_stdlib(
        name = "system.io.unmanagedmemorystream.dll",
        deps = [
        ],
        dotnet_context_data = context,
    )
    netstandard_stdlib(
        name = "system.linq.dll",
        deps = [
        ],
        dotnet_context_data = context,
    )
    netstandard_stdlib(
        name = "system.linq.expressions.dll",
        deps = [
        ],
        dotnet_context_data = context,
    )
    netstandard_stdlib(
        name = "system.linq.parallel.dll",
        deps = [
        ],
        dotnet_context_data = context,
    )
    netstandard_stdlib(
        name = "system.linq.queryable.dll",
        deps = [
        ],
        dotnet_context_data = context,
    )
    netstandard_stdlib(
        name = "system.net.dll",
        deps = [
        ],
        dotnet_context_data = context,
    )
    netstandard_stdlib(
        name = "system.net.http.dll",
        deps = [
        ],
        dotnet_context_data = context,
    )
    netstandard_stdlib(
        name = "system.net.nameresolution.dll",
        deps = [
        ],
        dotnet_context_data = context,
    )
    netstandard_stdlib(
        name = "system.net.networkinformation.dll",
        deps = [
        ],
        dotnet_context_data = context,
    )
    netstandard_stdlib(
        name = "system.net.ping.dll",
        deps = [
        ],
        dotnet_context_data = context,
    )
    netstandard_stdlib(
        name = "system.net.primitives.dll",
        deps = [
        ],
        dotnet_context_data = context,
    )
    netstandard_stdlib(
        name = "system.net.requests.dll",
        deps = [
        ],
        dotnet_context_data = context,
    )
    netstandard_stdlib(
        name = "system.net.security.dll",
        deps = [
        ],
        dotnet_context_data = context,
    )

    netstandard_stdlib(
	    name = "system.net.sockets.dll",
        deps = [
        ],
        dotnet_context_data = context,
    )
    netstandard_stdlib(
        name = "system.net.webheadercollection.dll",
        deps = [
        ],
        dotnet_context_data = context,
    )
    netstandard_stdlib(
        name = "system.net.websockets.client.dll",
        deps = [
        ],
        dotnet_context_data = context,
    )
    netstandard_stdlib(
        name = "system.net.websockets.dll",
        deps = [
        ],
        dotnet_context_data = context,
    )
    netstandard_stdlib(
        name = "system.numerics.dll",
        deps = [
        ],
        dotnet_context_data = context,
    )
    netstandard_stdlib(
        name = "system.objectmodel.dll",
        deps = [
        ],
        dotnet_context_data = context,
    )
    netstandard_stdlib(
        name = "system.reflection.dll",
        deps = [
        ],
        dotnet_context_data = context,
    )
    netstandard_stdlib(
        name = "system.reflection.extensions.dll",
        deps = [
        ],
        dotnet_context_data = context,
    )
    netstandard_stdlib(
        name = "system.reflection.primitives.dll",
        deps = [
        ],
        dotnet_context_data = context,
    )
    netstandard_stdlib(
        name = "system.resources.reader.dll",
        deps = [
        ],
        dotnet_context_data = context,
    )
    netstandard_stdlib(
        name = "system.resources.resourcemanager.dll",
        deps = [
        ],
        dotnet_context_data = context,
    )
    netstandard_stdlib(
        name = "system.resources.writer.dll",
        deps = [
        ],
        dotnet_context_data = context,
    )
    netstandard_stdlib(
        name = "system.runtime.compilerservices.visualc.dll",
        deps = [
        ],
        dotnet_context_data = context,
    )
    netstandard_stdlib(
        name = "system.runtime.dll",
        deps = [
        ],
        dotnet_context_data = context,
    )
    netstandard_stdlib(
        name = "system.runtime.extensions.dll",
        deps = [
        ],
        dotnet_context_data = context,
    )
    netstandard_stdlib(
        name = "system.runtime.handles.dll",
        deps = [
        ],
        dotnet_context_data = context,
    )
    netstandard_stdlib(
        name = "system.runtime.interopservices.dll",
        deps = [
        ],
        dotnet_context_data = context,
    )
    netstandard_stdlib(
        name = "system.runtime.interopservices.runtimeinformation.dll",
        deps = [
        ],
        dotnet_context_data = context,
    )
    netstandard_stdlib(
        name = "system.runtime.numerics.dll",
        deps = [
        ],
        dotnet_context_data = context,
    )
    netstandard_stdlib(
        name = "system.runtime.serialization.dll",
        deps = [
        ],
        dotnet_context_data = context,
    )
    netstandard_stdlib(
        name = "system.runtime.serialization.formatters.dll",
        deps = [
        ],
        dotnet_context_data = context,
    )
    netstandard_stdlib(
        name = "system.runtime.serialization.json.dll",
        deps = [
        ],
        dotnet_context_data = context,
    )
    netstandard_stdlib(
        name = "system.runtime.serialization.primitives.dll",
        deps = [
        ],
        dotnet_context_data = context,
    )
    netstandard_stdlib(
        name = "system.runtime.serialization.xml.dll",
        deps = [
        ],
        dotnet_context_data = context,
    )
    netstandard_stdlib(
        name = "system.security.claims.dll",
        deps = [
        ],
        dotnet_context_data = context,
    )
    netstandard_stdlib(
        name = "system.security.cryptography.algorithms.dll",
        deps = [
        ],
        dotnet_context_data = context,
    )
    netstandard_stdlib(
        name = "system.security.cryptography.csp.dll",
        deps = [
        ],
        dotnet_context_data = context,
    )
    netstandard_stdlib(
        name = "system.security.cryptography.encoding.dll",
        deps = [
        ],
        dotnet_context_data = context,
    )
    netstandard_stdlib(
        name = "system.security.cryptography.primitives.dll",
        deps = [
        ],
        dotnet_context_data = context,
    )
    netstandard_stdlib(
        name = "system.security.cryptography.x509certificates.dll",
        deps = [
        ],
        dotnet_context_data = context,
    )
    netstandard_stdlib(
        name = "system.security.principal.dll",
        deps = [
        ],
        dotnet_context_data = context,
    )
    netstandard_stdlib(
        name = "system.security.securestring.dll",
        deps = [
        ],
        dotnet_context_data = context,
    )
    netstandard_stdlib(
        name = "system.servicemodel.web.dll",
        deps = [
        ],
        dotnet_context_data = context,
    )
    netstandard_stdlib(
        name = "system.text.encoding.dll",
        deps = [
        ],
        dotnet_context_data = context,
    )
    netstandard_stdlib(
        name = "system.text.encoding.extensions.dll",
        deps = [
        ],
        dotnet_context_data = context,
    )
    netstandard_stdlib(
        name = "system.text.regularexpressions.dll",
        deps = [
        ],
        dotnet_context_data = context,
    )
    netstandard_stdlib(
        name = "system.threading.dll",
        deps = [
        ],
        dotnet_context_data = context,
    )
    netstandard_stdlib(
        name = "system.threading.overlapped.dll",
        deps = [
        ],
        dotnet_context_data = context,
    )
    netstandard_stdlib(
        name = "system.threading.tasks.dll",
        deps = [
        ],
        dotnet_context_data = context,
    )
    netstandard_stdlib(
        name = "system.threading.tasks.parallel.dll",
        deps = [
        ],
        dotnet_context_data = context,
    )
    netstandard_stdlib(
        name = "system.threading.thread.dll",
        deps = [
        ],
        dotnet_context_data = context,
    )
    netstandard_stdlib(
        name = "system.threading.threadpool.dll",
        deps = [
        ],
        dotnet_context_data = context,
    )
    netstandard_stdlib(
        name = "system.threading.timer.dll",
        deps = [
        ],
        dotnet_context_data = context,
    )
    netstandard_stdlib(
        name = "system.transactions.dll",
        deps = [
        ],
        dotnet_context_data = context,
    )
    netstandard_stdlib(
        name = "system.valuetuple.dll",
        deps = [
        ],
        dotnet_context_data = context,
    )
    netstandard_stdlib(
        name = "system.web.dll",
        deps = [
        ],
        dotnet_context_data = context,
    )
    netstandard_stdlib(
        name = "system.windows.dll",
        deps = [
        ],
        dotnet_context_data = context,
    )
    netstandard_stdlib(
        name = "system.xml.dll",
        deps = [
        ],
        dotnet_context_data = context,
    )
    netstandard_stdlib(
        name = "system.xml.linq.dll",
        deps = [
        ],
        dotnet_context_data = context,
    )
    netstandard_stdlib(
        name = "system.xml.readerwriter.dll",
        deps = [
        ],
        dotnet_context_data = context,
    )
    netstandard_stdlib(
        name = "system.xml.serialization.dll",
        deps = [
        ],
        dotnet_context_data = context,
    )
    netstandard_stdlib(
        name = "system.xml.xdocument.dll",
        deps = [
        ],
        dotnet_context_data = context,
    )
    netstandard_stdlib(
        name = "system.xml.xmldocument.dll",
        deps = [
        ],
        dotnet_context_data = context,
    )
    netstandard_stdlib(
        name = "system.xml.xmlserializer.dll",
        deps = [
        ],
        dotnet_context_data = context,
    )
    netstandard_stdlib(
        name = "system.xml.xpath.dll",
        deps = [
        ],
        dotnet_context_data = context,
    )
    netstandard_stdlib(
        name = "system.xml.xpath.xdocument.dll",
        deps = [
        ],
        dotnet_context_data = context,
    )
    netstandard_stdlib(
        name = "mscorlib.dll",
        deps = [
            ":netstandard.dll",
        ],
        dotnet_context_data = context,
    )
    netstandard_stdlib(
        name = "netstandard.dll",
        deps = [
            ":microsoft.win32.primitives.dll",
            ":system.appcontext.dll",
            ":system.collections.concurrent.dll",
            ":system.collections.dll",
            ":system.collections.nongeneric.dll",
            ":system.collections.specialized.dll",
            ":system.componentmodel.composition.dll",
            ":system.componentmodel.dll",
            ":system.componentmodel.eventbasedasync.dll",
            ":system.componentmodel.primitives.dll",
            ":system.componentmodel.typeconverter.dll",
            ":system.console.dll",
            ":system.core.dll",
            ":system.data.common.dll",
            ":system.data.dll",
            ":system.diagnostics.contracts.dll",
            ":system.diagnostics.debug.dll",
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
            ":system.net.dll",
            ":system.net.http.dll",
            ":system.net.nameresolution.dll",
            ":system.net.networkinformation.dll",
            ":system.net.ping.dll",
            ":system.net.primitives.dll",
            ":system.net.requests.dll",
            ":system.net.security.dll",
            ":system.net.sockets.dll",
            ":system.net.webheadercollection.dll",
            ":system.net.websockets.client.dll",
            ":system.net.websockets.dll",
            ":system.numerics.dll",
            ":system.objectmodel.dll",
            ":system.reflection.dll",
            ":system.reflection.extensions.dll",
            ":system.reflection.primitives.dll",
            ":system.resources.reader.dll",
            ":system.resources.resourcemanager.dll",
            ":system.resources.writer.dll",
            ":system.runtime.compilerservices.visualc.dll",
            ":system.runtime.dll",
            ":system.runtime.extensions.dll",
            ":system.runtime.handles.dll",
            ":system.runtime.interopservices.dll",
            ":system.runtime.interopservices.runtimeinformation.dll",
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
            ":system.security.principal.dll",
            ":system.security.securestring.dll",
            ":system.servicemodel.web.dll",
            ":system.text.encoding.dll",
            ":system.text.encoding.extensions.dll",
            ":system.text.regularexpressions.dll",
            ":system.threading.dll",
            ":system.threading.overlapped.dll",
            ":system.threading.tasks.dll",
            ":system.threading.tasks.parallel.dll",
            ":system.threading.thread.dll",
            ":system.threading.threadpool.dll",
            ":system.threading.timer.dll",
            ":system.transactions.dll",
            ":system.valuetuple.dll",
            ":system.web.dll",
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
        ],
        dotnet_context_data = context,
    )

    native.alias(
        name = "netstandard.library.dll",
        actual = ":netstandard.dll",
    )
