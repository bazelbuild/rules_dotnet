load("@io_bazel_rules_dotnet//dotnet/private:rules/stdlib.bzl", "dotnet_stdlib")

def define_stdlib(context_data):
    dotnet_stdlib(
        name = "accessibility.dll",
        dotnet_context_data = context_data,
        ref = "@Mono.ReferenceAssemblies.v4.5//:build/.NETFramework/v4.5/Accessibility.dll",
        deps = [
            ":mscorlib.dll",
        ]
    )
    dotnet_stdlib(
        name = "custommarshalers.dll",
        dotnet_context_data = context_data,
        ref = "@Mono.ReferenceAssemblies.v4.5//:build/.NETFramework/v4.5/CustomMarshalers.dll",
        deps = [
            ":mscorlib.dll",
        ]
    )
    dotnet_stdlib(
        name = "microsoft.build.dll",
        dotnet_context_data = context_data,
        ref = "@Mono.ReferenceAssemblies.v4.5//:build/.NETFramework/v4.5/Microsoft.Build.dll",
        deps = [
            ":mscorlib.dll",
            ":microsoft.build.framework.dll",
        ]
    )
    dotnet_stdlib(
        name = "microsoft.build.engine.dll",
        dotnet_context_data = context_data,
        ref = "@Mono.ReferenceAssemblies.v4.5//:build/.NETFramework/v4.5/Microsoft.Build.Engine.dll",
        deps = [
            ":mscorlib.dll",
            ":microsoft.build.framework.dll",
        ]
    )
    dotnet_stdlib(
        name = "microsoft.build.framework.dll",
        dotnet_context_data = context_data,
        ref = "@Mono.ReferenceAssemblies.v4.5//:build/.NETFramework/v4.5/Microsoft.Build.Framework.dll",
        deps = [
            ":mscorlib.dll",
            ":system.dll",
        ]
    )
    dotnet_stdlib(
        name = "microsoft.build.tasks.v4.0.dll",
        dotnet_context_data = context_data,
        ref = "@Mono.ReferenceAssemblies.v4.5//:build/.NETFramework/v4.5/Microsoft.Build.Tasks.v4.0.dll",
        deps = [
            ":mscorlib.dll",
            ":microsoft.build.framework.dll",
            ":microsoft.build.utilities.v4.0.dll",
            ":system.dll",
        ]
    )
    dotnet_stdlib(
        name = "microsoft.build.utilities.v4.0.dll",
        dotnet_context_data = context_data,
        ref = "@Mono.ReferenceAssemblies.v4.5//:build/.NETFramework/v4.5/Microsoft.Build.Utilities.v4.0.dll",
        deps = [
            ":mscorlib.dll",
            ":microsoft.build.framework.dll",
            ":system.dll",
        ]
    )
    dotnet_stdlib(
        name = "microsoft.csharp.dll",
        dotnet_context_data = context_data,
        ref = "@Mono.ReferenceAssemblies.v4.5//:build/.NETFramework/v4.5/Microsoft.CSharp.dll",
        deps = [
            ":mscorlib.dll",
            ":system.dll",
            ":system.core.dll",
        ]
    )
    dotnet_stdlib(
        name = "microsoft.visualbasic.dll",
        dotnet_context_data = context_data,
        ref = "@Mono.ReferenceAssemblies.v4.5//:build/.NETFramework/v4.5/Microsoft.VisualBasic.dll",
        deps = [
            ":mscorlib.dll",
            ":system.dll",
            ":system.drawing.dll",
        ]
    )
    dotnet_stdlib(
        name = "microsoft.visualc.dll",
        dotnet_context_data = context_data,
        ref = "@Mono.ReferenceAssemblies.v4.5//:build/.NETFramework/v4.5/Microsoft.VisualC.dll",
        deps = [
            ":mscorlib.dll",
        ]
    )
    dotnet_stdlib(
        name = "mscorlib.dll",
        dotnet_context_data = context_data,
        ref = "@Mono.ReferenceAssemblies.v4.5//:build/.NETFramework/v4.5/mscorlib.dll",
        deps = [
        ]
    )
    dotnet_stdlib(
        name = "system.componentmodel.composition.dll",
        dotnet_context_data = context_data,
        ref = "@Mono.ReferenceAssemblies.v4.5//:build/.NETFramework/v4.5/System.ComponentModel.Composition.dll",
        deps = [
            ":mscorlib.dll",
            ":system.core.dll",
            ":system.dll",
        ]
    )
    dotnet_stdlib(
        name = "system.componentmodel.dataannotations.dll",
        dotnet_context_data = context_data,
        ref = "@Mono.ReferenceAssemblies.v4.5//:build/.NETFramework/v4.5/System.ComponentModel.DataAnnotations.dll",
        deps = [
            ":mscorlib.dll",
            ":system.dll",
        ]
    )
    dotnet_stdlib(
        name = "system.configuration.dll",
        dotnet_context_data = context_data,
        ref = "@Mono.ReferenceAssemblies.v4.5//:build/.NETFramework/v4.5/System.Configuration.dll",
        deps = [
            ":mscorlib.dll",
            ":system.dll",
        ]
    )
    dotnet_stdlib(
        name = "system.configuration.install.dll",
        dotnet_context_data = context_data,
        ref = "@Mono.ReferenceAssemblies.v4.5//:build/.NETFramework/v4.5/System.Configuration.Install.dll",
        deps = [
            ":mscorlib.dll",
            ":system.dll",
        ]
    )
    dotnet_stdlib(
        name = "system.core.dll",
        dotnet_context_data = context_data,
        ref = "@Mono.ReferenceAssemblies.v4.5//:build/.NETFramework/v4.5/System.Core.dll",
        deps = [
            ":mscorlib.dll",
            ":system.dll",
        ]
    )
    dotnet_stdlib(
        name = "system.data.datasetextensions.dll",
        dotnet_context_data = context_data,
        ref = "@Mono.ReferenceAssemblies.v4.5//:build/.NETFramework/v4.5/System.Data.DataSetExtensions.dll",
        deps = [
            ":mscorlib.dll",
        ]
    )
    dotnet_stdlib(
        name = "system.data.dll",
        dotnet_context_data = context_data,
        ref = "@Mono.ReferenceAssemblies.v4.5//:build/.NETFramework/v4.5/System.Data.dll",
        deps = [
            ":mscorlib.dll",
            ":system.dll",
            ":system.enterpriseservices.dll",
        ]
    )
    dotnet_stdlib(
        name = "system.data.entity.dll",
        dotnet_context_data = context_data,
        ref = "@Mono.ReferenceAssemblies.v4.5//:build/.NETFramework/v4.5/System.Data.Entity.dll",
        deps = [
            ":mscorlib.dll",
            ":system.runtime.serialization.dll",
            ":system.dll",
            ":system.componentmodel.dataannotations.dll",
            ":system.core.dll",
        ]
    )
    dotnet_stdlib(
        name = "system.data.linq.dll",
        dotnet_context_data = context_data,
        ref = "@Mono.ReferenceAssemblies.v4.5//:build/.NETFramework/v4.5/System.Data.Linq.dll",
        deps = [
            ":mscorlib.dll",
            ":system.runtime.serialization.dll",
            ":system.core.dll",
            ":system.dll",
        ]
    )
    dotnet_stdlib(
        name = "system.data.oracleclient.dll",
        dotnet_context_data = context_data,
        ref = "@Mono.ReferenceAssemblies.v4.5//:build/.NETFramework/v4.5/System.Data.OracleClient.dll",
        deps = [
            ":mscorlib.dll",
            ":system.dll",
            ":system.drawing.dll",
            ":system.enterpriseservices.dll",
        ]
    )
    dotnet_stdlib(
        name = "system.data.services.client.dll",
        dotnet_context_data = context_data,
        ref = "@Mono.ReferenceAssemblies.v4.5//:build/.NETFramework/v4.5/System.Data.Services.Client.dll",
        deps = [
            ":mscorlib.dll",
            ":system.dll",
            ":system.core.dll",
            ":system.xml.linq.dll",
        ]
    )
    dotnet_stdlib(
        name = "system.data.services.dll",
        dotnet_context_data = context_data,
        ref = "@Mono.ReferenceAssemblies.v4.5//:build/.NETFramework/v4.5/System.Data.Services.dll",
        deps = [
            ":mscorlib.dll",
            ":system.data.services.client.dll",
            ":system.servicemodel.web.dll",
            ":system.dll",
            ":system.servicemodel.activation.dll",
            ":system.core.dll",
        ]
    )
    dotnet_stdlib(
        name = "system.design.dll",
        dotnet_context_data = context_data,
        ref = "@Mono.ReferenceAssemblies.v4.5//:build/.NETFramework/v4.5/System.Design.dll",
        deps = [
            ":mscorlib.dll",
            ":system.drawing.dll",
            ":system.dll",
            ":system.drawing.design.dll",
        ]
    )
    dotnet_stdlib(
        name = "system.directoryservices.dll",
        dotnet_context_data = context_data,
        ref = "@Mono.ReferenceAssemblies.v4.5//:build/.NETFramework/v4.5/System.DirectoryServices.dll",
        deps = [
            ":mscorlib.dll",
            ":system.dll",
        ]
    )
    dotnet_stdlib(
        name = "system.directoryservices.protocols.dll",
        dotnet_context_data = context_data,
        ref = "@Mono.ReferenceAssemblies.v4.5//:build/.NETFramework/v4.5/System.DirectoryServices.Protocols.dll",
        deps = [
            ":mscorlib.dll",
            ":system.dll",
            ":system.directoryservices.dll",
        ]
    )
    dotnet_stdlib(
        name = "system.dll",
        dotnet_context_data = context_data,
        ref = "@Mono.ReferenceAssemblies.v4.5//:build/.NETFramework/v4.5/System.dll",
        deps = [
            ":mscorlib.dll",
        ]
    )
    dotnet_stdlib(
        name = "system.drawing.design.dll",
        dotnet_context_data = context_data,
        ref = "@Mono.ReferenceAssemblies.v4.5//:build/.NETFramework/v4.5/System.Drawing.Design.dll",
        deps = [
            ":mscorlib.dll",
            ":system.drawing.dll",
            ":system.dll",
        ]
    )
    dotnet_stdlib(
        name = "system.drawing.dll",
        dotnet_context_data = context_data,
        ref = "@Mono.ReferenceAssemblies.v4.5//:build/.NETFramework/v4.5/System.Drawing.dll",
        deps = [
            ":mscorlib.dll",
            ":system.dll",
        ]
    )
    dotnet_stdlib(
        name = "system.dynamic.dll",
        dotnet_context_data = context_data,
        ref = "@Mono.ReferenceAssemblies.v4.5//:build/.NETFramework/v4.5/System.Dynamic.dll",
        deps = [
            ":mscorlib.dll",
        ]
    )
    dotnet_stdlib(
        name = "system.enterpriseservices.dll",
        dotnet_context_data = context_data,
        ref = "@Mono.ReferenceAssemblies.v4.5//:build/.NETFramework/v4.5/System.EnterpriseServices.dll",
        deps = [
            ":mscorlib.dll",
        ]
    )
    dotnet_stdlib(
        name = "system.identitymodel.dll",
        dotnet_context_data = context_data,
        ref = "@Mono.ReferenceAssemblies.v4.5//:build/.NETFramework/v4.5/System.IdentityModel.dll",
        deps = [
            ":mscorlib.dll",
            ":system.runtime.serialization.dll",
            ":system.dll",
            ":system.web.applicationservices.dll",
        ]
    )
    dotnet_stdlib(
        name = "system.identitymodel.selectors.dll",
        dotnet_context_data = context_data,
        ref = "@Mono.ReferenceAssemblies.v4.5//:build/.NETFramework/v4.5/System.IdentityModel.Selectors.dll",
        deps = [
            ":mscorlib.dll",
            ":system.dll",
            ":system.identitymodel.dll",
        ]
    )
    dotnet_stdlib(
        name = "system.io.compression.dll",
        dotnet_context_data = context_data,
        ref = "@Mono.ReferenceAssemblies.v4.5//:build/.NETFramework/v4.5/System.IO.Compression.dll",
        deps = [
            ":mscorlib.dll",
            ":system.dll",
        ]
    )
    dotnet_stdlib(
        name = "system.io.compression.filesystem.dll",
        dotnet_context_data = context_data,
        ref = "@Mono.ReferenceAssemblies.v4.5//:build/.NETFramework/v4.5/System.IO.Compression.FileSystem.dll",
        deps = [
            ":mscorlib.dll",
            ":system.dll",
            ":system.io.compression.dll",
        ]
    )
    dotnet_stdlib(
        name = "system.management.dll",
        dotnet_context_data = context_data,
        ref = "@Mono.ReferenceAssemblies.v4.5//:build/.NETFramework/v4.5/System.Management.dll",
        deps = [
            ":mscorlib.dll",
            ":system.dll",
            ":system.configuration.install.dll",
        ]
    )
    dotnet_stdlib(
        name = "system.messaging.dll",
        dotnet_context_data = context_data,
        ref = "@Mono.ReferenceAssemblies.v4.5//:build/.NETFramework/v4.5/System.Messaging.dll",
        deps = [
            ":mscorlib.dll",
            ":system.dll",
            ":system.drawing.dll",
            ":system.configuration.install.dll",
        ]
    )
    dotnet_stdlib(
        name = "system.net.dll",
        dotnet_context_data = context_data,
        ref = "@Mono.ReferenceAssemblies.v4.5//:build/.NETFramework/v4.5/System.Net.dll",
        deps = [
            ":mscorlib.dll",
            ":system.dll",
        ]
    )
    dotnet_stdlib(
        name = "system.net.http.dll",
        dotnet_context_data = context_data,
        ref = "@Mono.ReferenceAssemblies.v4.5//:build/.NETFramework/v4.5/System.Net.Http.dll",
        deps = [
            ":mscorlib.dll",
            ":system.dll",
        ]
    )
    dotnet_stdlib(
        name = "system.net.http.webrequest.dll",
        dotnet_context_data = context_data,
        ref = "@Mono.ReferenceAssemblies.v4.5//:build/.NETFramework/v4.5/System.Net.Http.WebRequest.dll",
        deps = [
            ":mscorlib.dll",
            ":system.net.http.dll",
            ":system.dll",
        ]
    )
    dotnet_stdlib(
        name = "system.numerics.dll",
        dotnet_context_data = context_data,
        ref = "@Mono.ReferenceAssemblies.v4.5//:build/.NETFramework/v4.5/System.Numerics.dll",
        deps = [
            ":mscorlib.dll",
        ]
    )
    dotnet_stdlib(
        name = "system.runtime.caching.dll",
        dotnet_context_data = context_data,
        ref = "@Mono.ReferenceAssemblies.v4.5//:build/.NETFramework/v4.5/System.Runtime.Caching.dll",
        deps = [
            ":mscorlib.dll",
            ":system.dll",
        ]
    )
    dotnet_stdlib(
        name = "system.runtime.durableinstancing.dll",
        dotnet_context_data = context_data,
        ref = "@Mono.ReferenceAssemblies.v4.5//:build/.NETFramework/v4.5/System.Runtime.DurableInstancing.dll",
        deps = [
            ":mscorlib.dll",
            ":system.xml.linq.dll",
            ":system.runtime.serialization.dll",
            ":system.servicemodel.internals.dll",
        ]
    )
    dotnet_stdlib(
        name = "system.runtime.remoting.dll",
        dotnet_context_data = context_data,
        ref = "@Mono.ReferenceAssemblies.v4.5//:build/.NETFramework/v4.5/System.Runtime.Remoting.dll",
        deps = [
            ":mscorlib.dll",
            ":system.dll",
        ]
    )
    dotnet_stdlib(
        name = "system.runtime.serialization.dll",
        dotnet_context_data = context_data,
        ref = "@Mono.ReferenceAssemblies.v4.5//:build/.NETFramework/v4.5/System.Runtime.Serialization.dll",
        deps = [
            ":mscorlib.dll",
            ":system.dll",
        ]
    )
    dotnet_stdlib(
        name = "system.runtime.serialization.formatters.soap.dll",
        dotnet_context_data = context_data,
        ref = "@Mono.ReferenceAssemblies.v4.5//:build/.NETFramework/v4.5/System.Runtime.Serialization.Formatters.Soap.dll",
        deps = [
            ":mscorlib.dll",
        ]
    )
    dotnet_stdlib(
        name = "system.security.dll",
        dotnet_context_data = context_data,
        ref = "@Mono.ReferenceAssemblies.v4.5//:build/.NETFramework/v4.5/System.Security.dll",
        deps = [
            ":mscorlib.dll",
            ":system.dll",
        ]
    )
    dotnet_stdlib(
        name = "system.servicemodel.activation.dll",
        dotnet_context_data = context_data,
        ref = "@Mono.ReferenceAssemblies.v4.5//:build/.NETFramework/v4.5/System.ServiceModel.Activation.dll",
        deps = [
            ":mscorlib.dll",
            ":system.dll",
        ]
    )
    dotnet_stdlib(
        name = "system.servicemodel.discovery.dll",
        dotnet_context_data = context_data,
        ref = "@Mono.ReferenceAssemblies.v4.5//:build/.NETFramework/v4.5/System.ServiceModel.Discovery.dll",
        deps = [
            ":mscorlib.dll",
            ":system.dll",
            ":system.xml.linq.dll",
        ]
    )
    dotnet_stdlib(
        name = "system.servicemodel.dll",
        dotnet_context_data = context_data,
        ref = "@Mono.ReferenceAssemblies.v4.5//:build/.NETFramework/v4.5/System.ServiceModel.dll",
        deps = [
            ":mscorlib.dll",
            ":system.dll",
            ":system.identitymodel.dll",
            ":system.runtime.serialization.dll",
            ":system.xaml.dll",
            ":system.web.applicationservices.dll",
            ":system.web.services.dll",
            ":system.messaging.dll",
            ":system.identitymodel.selectors.dll",
            ":system.xml.linq.dll",
            ":system.enterpriseservices.dll",
            ":system.runtime.durableinstancing.dll",
            ":system.net.http.dll",
            ":system.servicemodel.activation.dll",
        ]
    )
    dotnet_stdlib(
        name = "system.servicemodel.internals.dll",
        dotnet_context_data = context_data,
        ref = "@Mono.ReferenceAssemblies.v4.5//:build/.NETFramework/v4.5/System.ServiceModel.Internals.dll",
        deps = [
            ":mscorlib.dll",
        ]
    )
    dotnet_stdlib(
        name = "system.servicemodel.routing.dll",
        dotnet_context_data = context_data,
        ref = "@Mono.ReferenceAssemblies.v4.5//:build/.NETFramework/v4.5/System.ServiceModel.Routing.dll",
        deps = [
            ":mscorlib.dll",
        ]
    )
    dotnet_stdlib(
        name = "system.servicemodel.web.dll",
        dotnet_context_data = context_data,
        ref = "@Mono.ReferenceAssemblies.v4.5//:build/.NETFramework/v4.5/System.ServiceModel.Web.dll",
        deps = [
            ":mscorlib.dll",
            ":system.dll",
            ":system.runtime.serialization.dll",
            ":system.xml.linq.dll",
            ":system.servicemodel.activation.dll",
        ]
    )
    dotnet_stdlib(
        name = "system.serviceprocess.dll",
        dotnet_context_data = context_data,
        ref = "@Mono.ReferenceAssemblies.v4.5//:build/.NETFramework/v4.5/System.ServiceProcess.dll",
        deps = [
            ":mscorlib.dll",
            ":system.dll",
            ":system.configuration.install.dll",
        ]
    )
    dotnet_stdlib(
        name = "system.transactions.dll",
        dotnet_context_data = context_data,
        ref = "@Mono.ReferenceAssemblies.v4.5//:build/.NETFramework/v4.5/System.Transactions.dll",
        deps = [
            ":mscorlib.dll",
        ]
    )
    dotnet_stdlib(
        name = "system.web.abstractions.dll",
        dotnet_context_data = context_data,
        ref = "@Mono.ReferenceAssemblies.v4.5//:build/.NETFramework/v4.5/System.Web.Abstractions.dll",
        deps = [
            ":mscorlib.dll",
        ]
    )
    dotnet_stdlib(
        name = "system.web.applicationservices.dll",
        dotnet_context_data = context_data,
        ref = "@Mono.ReferenceAssemblies.v4.5//:build/.NETFramework/v4.5/System.Web.ApplicationServices.dll",
        deps = [
            ":mscorlib.dll",
        ]
    )
    dotnet_stdlib(
        name = "system.web.dll",
        dotnet_context_data = context_data,
        ref = "@Mono.ReferenceAssemblies.v4.5//:build/.NETFramework/v4.5/System.Web.dll",
        deps = [
            ":mscorlib.dll",
            ":system.dll",
            ":system.enterpriseservices.dll",
            ":system.web.applicationservices.dll",
            ":system.componentmodel.dataannotations.dll",
            ":system.web.services.dll",
            ":system.drawing.dll",
            ":system.core.dll",
        ]
    )
    dotnet_stdlib(
        name = "system.web.dynamicdata.dll",
        dotnet_context_data = context_data,
        ref = "@Mono.ReferenceAssemblies.v4.5//:build/.NETFramework/v4.5/System.Web.DynamicData.dll",
        deps = [
            ":mscorlib.dll",
            ":system.dll",
            ":system.web.extensions.dll",
            ":system.core.dll",
            ":system.drawing.dll",
            ":system.componentmodel.dataannotations.dll",
        ]
    )
    dotnet_stdlib(
        name = "system.web.extensions.design.dll",
        dotnet_context_data = context_data,
        ref = "@Mono.ReferenceAssemblies.v4.5//:build/.NETFramework/v4.5/System.Web.Extensions.Design.dll",
        deps = [
            ":mscorlib.dll",
            ":system.dll",
            ":system.web.extensions.dll",
            ":system.drawing.dll",
        ]
    )
    dotnet_stdlib(
        name = "system.web.extensions.dll",
        dotnet_context_data = context_data,
        ref = "@Mono.ReferenceAssemblies.v4.5//:build/.NETFramework/v4.5/System.Web.Extensions.dll",
        deps = [
            ":mscorlib.dll",
            ":system.dll",
            ":system.drawing.dll",
            ":system.core.dll",
            ":system.web.applicationservices.dll",
            ":system.servicemodel.activation.dll",
            ":system.runtime.serialization.dll",
        ]
    )
    dotnet_stdlib(
        name = "system.web.routing.dll",
        dotnet_context_data = context_data,
        ref = "@Mono.ReferenceAssemblies.v4.5//:build/.NETFramework/v4.5/System.Web.Routing.dll",
        deps = [
            ":mscorlib.dll",
        ]
    )
    dotnet_stdlib(
        name = "system.web.services.dll",
        dotnet_context_data = context_data,
        ref = "@Mono.ReferenceAssemblies.v4.5//:build/.NETFramework/v4.5/System.Web.Services.dll",
        deps = [
            ":mscorlib.dll",
            ":system.enterpriseservices.dll",
            ":system.dll",
        ]
    )
    dotnet_stdlib(
        name = "system.windows.dll",
        dotnet_context_data = context_data,
        ref = "@Mono.ReferenceAssemblies.v4.5//:build/.NETFramework/v4.5/System.Windows.dll",
        deps = [
            ":mscorlib.dll",
            ":system.dll",
        ]
    )
    dotnet_stdlib(
        name = "system.windows.forms.datavisualization.dll",
        dotnet_context_data = context_data,
        ref = "@Mono.ReferenceAssemblies.v4.5//:build/.NETFramework/v4.5/System.Windows.Forms.DataVisualization.dll",
        deps = [
            ":mscorlib.dll",
            ":system.drawing.dll",
            ":system.dll",
        ]
    )
    dotnet_stdlib(
        name = "system.windows.forms.dll",
        dotnet_context_data = context_data,
        ref = "@Mono.ReferenceAssemblies.v4.5//:build/.NETFramework/v4.5/System.Windows.Forms.dll",
        deps = [
            ":mscorlib.dll",
            ":system.dll",
            ":accessibility.dll",
            ":system.drawing.dll",
        ]
    )
    dotnet_stdlib(
        name = "system.xaml.dll",
        dotnet_context_data = context_data,
        ref = "@Mono.ReferenceAssemblies.v4.5//:build/.NETFramework/v4.5/System.Xaml.dll",
        deps = [
            ":mscorlib.dll",
            ":system.dll",
        ]
    )
    dotnet_stdlib(
        name = "system.xml.dll",
        dotnet_context_data = context_data,
        ref = "@Mono.ReferenceAssemblies.v4.5//:build/.NETFramework/v4.5/System.Xml.dll",
        deps = [
            ":mscorlib.dll",
            ":system.dll",
        ]
    )
    dotnet_stdlib(
        name = "system.xml.linq.dll",
        dotnet_context_data = context_data,
        ref = "@Mono.ReferenceAssemblies.v4.5//:build/.NETFramework/v4.5/System.Xml.Linq.dll",
        deps = [
            ":mscorlib.dll",
            ":system.runtime.serialization.dll",
            ":system.dll",
        ]
    )
    dotnet_stdlib(
        name = "system.xml.serialization.dll",
        dotnet_context_data = context_data,
        ref = "@Mono.ReferenceAssemblies.v4.5//:build/.NETFramework/v4.5/System.Xml.Serialization.dll",
        deps = [
            ":mscorlib.dll",
        ]
    )
    dotnet_stdlib(
        name = "windowsbase.dll",
        dotnet_context_data = context_data,
        ref = "@Mono.ReferenceAssemblies.v4.5//:build/.NETFramework/v4.5/WindowsBase.dll",
        deps = [
            ":mscorlib.dll",
            ":system.xaml.dll",
            ":system.dll",
            ":system.security.dll",
        ]
    )
    dotnet_stdlib(
        name = "system.collections.concurrent.dll",
        dotnet_context_data = context_data,
        ref = "@Mono.ReferenceAssemblies.v4.5//:build/.NETFramework/v4.5/Facades/System.Collections.Concurrent.dll",
        deps = [
            ":mscorlib.dll",
            ":system.dll",
        ]
    )
    dotnet_stdlib(
        name = "system.collections.dll",
        dotnet_context_data = context_data,
        ref = "@Mono.ReferenceAssemblies.v4.5//:build/.NETFramework/v4.5/Facades/System.Collections.dll",
        deps = [
            ":mscorlib.dll",
            ":system.core.dll",
            ":system.dll",
        ]
    )
    dotnet_stdlib(
        name = "system.componentmodel.annotations.dll",
        dotnet_context_data = context_data,
        ref = "@Mono.ReferenceAssemblies.v4.5//:build/.NETFramework/v4.5/Facades/System.ComponentModel.Annotations.dll",
        deps = [
            ":mscorlib.dll",
            ":system.componentmodel.dataannotations.dll",
        ]
    )
    dotnet_stdlib(
        name = "system.componentmodel.dll",
        dotnet_context_data = context_data,
        ref = "@Mono.ReferenceAssemblies.v4.5//:build/.NETFramework/v4.5/Facades/System.ComponentModel.dll",
        deps = [
            ":mscorlib.dll",
            ":system.dll",
        ]
    )
    dotnet_stdlib(
        name = "system.componentmodel.eventbasedasync.dll",
        dotnet_context_data = context_data,
        ref = "@Mono.ReferenceAssemblies.v4.5//:build/.NETFramework/v4.5/Facades/System.ComponentModel.EventBasedAsync.dll",
        deps = [
            ":mscorlib.dll",
            ":system.dll",
        ]
    )
    dotnet_stdlib(
        name = "system.diagnostics.contracts.dll",
        dotnet_context_data = context_data,
        ref = "@Mono.ReferenceAssemblies.v4.5//:build/.NETFramework/v4.5/Facades/System.Diagnostics.Contracts.dll",
        deps = [
            ":mscorlib.dll",
        ]
    )
    dotnet_stdlib(
        name = "system.diagnostics.debug.dll",
        dotnet_context_data = context_data,
        ref = "@Mono.ReferenceAssemblies.v4.5//:build/.NETFramework/v4.5/Facades/System.Diagnostics.Debug.dll",
        deps = [
            ":mscorlib.dll",
            ":system.dll",
        ]
    )
    dotnet_stdlib(
        name = "system.diagnostics.tools.dll",
        dotnet_context_data = context_data,
        ref = "@Mono.ReferenceAssemblies.v4.5//:build/.NETFramework/v4.5/Facades/System.Diagnostics.Tools.dll",
        deps = [
            ":mscorlib.dll",
            ":system.dll",
        ]
    )
    dotnet_stdlib(
        name = "system.diagnostics.tracing.dll",
        dotnet_context_data = context_data,
        ref = "@Mono.ReferenceAssemblies.v4.5//:build/.NETFramework/v4.5/Facades/System.Diagnostics.Tracing.dll",
        deps = [
            ":mscorlib.dll",
        ]
    )
    dotnet_stdlib(
        name = "system.dynamic.runtime.dll",
        dotnet_context_data = context_data,
        ref = "@Mono.ReferenceAssemblies.v4.5//:build/.NETFramework/v4.5/Facades/System.Dynamic.Runtime.dll",
        deps = [
            ":mscorlib.dll",
            ":system.core.dll",
        ]
    )
    dotnet_stdlib(
        name = "system.globalization.dll",
        dotnet_context_data = context_data,
        ref = "@Mono.ReferenceAssemblies.v4.5//:build/.NETFramework/v4.5/Facades/System.Globalization.dll",
        deps = [
            ":mscorlib.dll",
        ]
    )
    dotnet_stdlib(
        name = "system.io.dll",
        dotnet_context_data = context_data,
        ref = "@Mono.ReferenceAssemblies.v4.5//:build/.NETFramework/v4.5/Facades/System.IO.dll",
        deps = [
            ":mscorlib.dll",
            ":system.dll",
        ]
    )
    dotnet_stdlib(
        name = "system.linq.dll",
        dotnet_context_data = context_data,
        ref = "@Mono.ReferenceAssemblies.v4.5//:build/.NETFramework/v4.5/Facades/System.Linq.dll",
        deps = [
            ":mscorlib.dll",
            ":system.core.dll",
        ]
    )
    dotnet_stdlib(
        name = "system.linq.expressions.dll",
        dotnet_context_data = context_data,
        ref = "@Mono.ReferenceAssemblies.v4.5//:build/.NETFramework/v4.5/Facades/System.Linq.Expressions.dll",
        deps = [
            ":mscorlib.dll",
            ":system.core.dll",
        ]
    )
    dotnet_stdlib(
        name = "system.linq.parallel.dll",
        dotnet_context_data = context_data,
        ref = "@Mono.ReferenceAssemblies.v4.5//:build/.NETFramework/v4.5/Facades/System.Linq.Parallel.dll",
        deps = [
            ":mscorlib.dll",
            ":system.core.dll",
        ]
    )
    dotnet_stdlib(
        name = "system.linq.queryable.dll",
        dotnet_context_data = context_data,
        ref = "@Mono.ReferenceAssemblies.v4.5//:build/.NETFramework/v4.5/Facades/System.Linq.Queryable.dll",
        deps = [
            ":mscorlib.dll",
            ":system.core.dll",
        ]
    )
    dotnet_stdlib(
        name = "system.net.networkinformation.dll",
        dotnet_context_data = context_data,
        ref = "@Mono.ReferenceAssemblies.v4.5//:build/.NETFramework/v4.5/Facades/System.Net.NetworkInformation.dll",
        deps = [
            ":mscorlib.dll",
            ":system.dll",
        ]
    )
    dotnet_stdlib(
        name = "system.net.primitives.dll",
        dotnet_context_data = context_data,
        ref = "@Mono.ReferenceAssemblies.v4.5//:build/.NETFramework/v4.5/Facades/System.Net.Primitives.dll",
        deps = [
            ":mscorlib.dll",
            ":system.dll",
        ]
    )
    dotnet_stdlib(
        name = "system.net.requests.dll",
        dotnet_context_data = context_data,
        ref = "@Mono.ReferenceAssemblies.v4.5//:build/.NETFramework/v4.5/Facades/System.Net.Requests.dll",
        deps = [
            ":mscorlib.dll",
            ":system.dll",
        ]
    )
    dotnet_stdlib(
        name = "system.objectmodel.dll",
        dotnet_context_data = context_data,
        ref = "@Mono.ReferenceAssemblies.v4.5//:build/.NETFramework/v4.5/Facades/System.ObjectModel.dll",
        deps = [
            ":mscorlib.dll",
            ":system.dll",
        ]
    )
    dotnet_stdlib(
        name = "system.reflection.dll",
        dotnet_context_data = context_data,
        ref = "@Mono.ReferenceAssemblies.v4.5//:build/.NETFramework/v4.5/Facades/System.Reflection.dll",
        deps = [
            ":mscorlib.dll",
        ]
    )
    dotnet_stdlib(
        name = "system.reflection.emit.dll",
        dotnet_context_data = context_data,
        ref = "@Mono.ReferenceAssemblies.v4.5//:build/.NETFramework/v4.5/Facades/System.Reflection.Emit.dll",
        deps = [
            ":mscorlib.dll",
        ]
    )
    dotnet_stdlib(
        name = "system.reflection.emit.ilgeneration.dll",
        dotnet_context_data = context_data,
        ref = "@Mono.ReferenceAssemblies.v4.5//:build/.NETFramework/v4.5/Facades/System.Reflection.Emit.ILGeneration.dll",
        deps = [
            ":mscorlib.dll",
        ]
    )
    dotnet_stdlib(
        name = "system.reflection.emit.lightweight.dll",
        dotnet_context_data = context_data,
        ref = "@Mono.ReferenceAssemblies.v4.5//:build/.NETFramework/v4.5/Facades/System.Reflection.Emit.Lightweight.dll",
        deps = [
            ":mscorlib.dll",
        ]
    )
    dotnet_stdlib(
        name = "system.reflection.extensions.dll",
        dotnet_context_data = context_data,
        ref = "@Mono.ReferenceAssemblies.v4.5//:build/.NETFramework/v4.5/Facades/System.Reflection.Extensions.dll",
        deps = [
            ":mscorlib.dll",
        ]
    )
    dotnet_stdlib(
        name = "system.reflection.primitives.dll",
        dotnet_context_data = context_data,
        ref = "@Mono.ReferenceAssemblies.v4.5//:build/.NETFramework/v4.5/Facades/System.Reflection.Primitives.dll",
        deps = [
            ":mscorlib.dll",
        ]
    )
    dotnet_stdlib(
        name = "system.resources.resourcemanager.dll",
        dotnet_context_data = context_data,
        ref = "@Mono.ReferenceAssemblies.v4.5//:build/.NETFramework/v4.5/Facades/System.Resources.ResourceManager.dll",
        deps = [
            ":mscorlib.dll",
        ]
    )
    dotnet_stdlib(
        name = "system.runtime.dll",
        dotnet_context_data = context_data,
        ref = "@Mono.ReferenceAssemblies.v4.5//:build/.NETFramework/v4.5/Facades/System.Runtime.dll",
        deps = [
            ":mscorlib.dll",
            ":system.core.dll",
            ":system.dll",
            ":system.componentmodel.composition.dll",
        ]
    )
    dotnet_stdlib(
        name = "system.runtime.extensions.dll",
        dotnet_context_data = context_data,
        ref = "@Mono.ReferenceAssemblies.v4.5//:build/.NETFramework/v4.5/Facades/System.Runtime.Extensions.dll",
        deps = [
            ":mscorlib.dll",
            ":system.dll",
        ]
    )
    dotnet_stdlib(
        name = "system.runtime.interopservices.dll",
        dotnet_context_data = context_data,
        ref = "@Mono.ReferenceAssemblies.v4.5//:build/.NETFramework/v4.5/Facades/System.Runtime.InteropServices.dll",
        deps = [
            ":mscorlib.dll",
            ":system.core.dll",
            ":system.dll",
        ]
    )
    dotnet_stdlib(
        name = "system.runtime.interopservices.windowsruntime.dll",
        dotnet_context_data = context_data,
        ref = "@Mono.ReferenceAssemblies.v4.5//:build/.NETFramework/v4.5/Facades/System.Runtime.InteropServices.WindowsRuntime.dll",
        deps = [
            ":mscorlib.dll",
        ]
    )
    dotnet_stdlib(
        name = "system.runtime.numerics.dll",
        dotnet_context_data = context_data,
        ref = "@Mono.ReferenceAssemblies.v4.5//:build/.NETFramework/v4.5/Facades/System.Runtime.Numerics.dll",
        deps = [
            ":mscorlib.dll",
            ":system.numerics.dll",
        ]
    )
    dotnet_stdlib(
        name = "system.runtime.serialization.json.dll",
        dotnet_context_data = context_data,
        ref = "@Mono.ReferenceAssemblies.v4.5//:build/.NETFramework/v4.5/Facades/System.Runtime.Serialization.Json.dll",
        deps = [
            ":mscorlib.dll",
            ":system.runtime.serialization.dll",
        ]
    )
    dotnet_stdlib(
        name = "system.runtime.serialization.primitives.dll",
        dotnet_context_data = context_data,
        ref = "@Mono.ReferenceAssemblies.v4.5//:build/.NETFramework/v4.5/Facades/System.Runtime.Serialization.Primitives.dll",
        deps = [
            ":mscorlib.dll",
            ":system.runtime.serialization.dll",
        ]
    )
    dotnet_stdlib(
        name = "system.runtime.serialization.xml.dll",
        dotnet_context_data = context_data,
        ref = "@Mono.ReferenceAssemblies.v4.5//:build/.NETFramework/v4.5/Facades/System.Runtime.Serialization.Xml.dll",
        deps = [
            ":mscorlib.dll",
            ":system.runtime.serialization.dll",
        ]
    )
    dotnet_stdlib(
        name = "system.security.principal.dll",
        dotnet_context_data = context_data,
        ref = "@Mono.ReferenceAssemblies.v4.5//:build/.NETFramework/v4.5/Facades/System.Security.Principal.dll",
        deps = [
            ":mscorlib.dll",
        ]
    )
    dotnet_stdlib(
        name = "system.servicemodel.duplex.dll",
        dotnet_context_data = context_data,
        ref = "@Mono.ReferenceAssemblies.v4.5//:build/.NETFramework/v4.5/Facades/System.ServiceModel.Duplex.dll",
        deps = [
            ":mscorlib.dll",
        ]
    )
    dotnet_stdlib(
        name = "system.servicemodel.http.dll",
        dotnet_context_data = context_data,
        ref = "@Mono.ReferenceAssemblies.v4.5//:build/.NETFramework/v4.5/Facades/System.ServiceModel.Http.dll",
        deps = [
            ":mscorlib.dll",
        ]
    )
    dotnet_stdlib(
        name = "system.servicemodel.nettcp.dll",
        dotnet_context_data = context_data,
        ref = "@Mono.ReferenceAssemblies.v4.5//:build/.NETFramework/v4.5/Facades/System.ServiceModel.NetTcp.dll",
        deps = [
            ":mscorlib.dll",
        ]
    )
    dotnet_stdlib(
        name = "system.servicemodel.primitives.dll",
        dotnet_context_data = context_data,
        ref = "@Mono.ReferenceAssemblies.v4.5//:build/.NETFramework/v4.5/Facades/System.ServiceModel.Primitives.dll",
        deps = [
            ":mscorlib.dll",
        ]
    )
    dotnet_stdlib(
        name = "system.servicemodel.security.dll",
        dotnet_context_data = context_data,
        ref = "@Mono.ReferenceAssemblies.v4.5//:build/.NETFramework/v4.5/Facades/System.ServiceModel.Security.dll",
        deps = [
            ":mscorlib.dll",
        ]
    )
    dotnet_stdlib(
        name = "system.text.encoding.dll",
        dotnet_context_data = context_data,
        ref = "@Mono.ReferenceAssemblies.v4.5//:build/.NETFramework/v4.5/Facades/System.Text.Encoding.dll",
        deps = [
            ":mscorlib.dll",
        ]
    )
    dotnet_stdlib(
        name = "system.text.encoding.extensions.dll",
        dotnet_context_data = context_data,
        ref = "@Mono.ReferenceAssemblies.v4.5//:build/.NETFramework/v4.5/Facades/System.Text.Encoding.Extensions.dll",
        deps = [
            ":mscorlib.dll",
        ]
    )
    dotnet_stdlib(
        name = "system.text.regularexpressions.dll",
        dotnet_context_data = context_data,
        ref = "@Mono.ReferenceAssemblies.v4.5//:build/.NETFramework/v4.5/Facades/System.Text.RegularExpressions.dll",
        deps = [
            ":mscorlib.dll",
            ":system.dll",
        ]
    )
    dotnet_stdlib(
        name = "system.threading.dll",
        dotnet_context_data = context_data,
        ref = "@Mono.ReferenceAssemblies.v4.5//:build/.NETFramework/v4.5/Facades/System.Threading.dll",
        deps = [
            ":mscorlib.dll",
            ":system.dll",
            ":system.core.dll",
        ]
    )
    dotnet_stdlib(
        name = "system.threading.tasks.dll",
        dotnet_context_data = context_data,
        ref = "@Mono.ReferenceAssemblies.v4.5//:build/.NETFramework/v4.5/Facades/System.Threading.Tasks.dll",
        deps = [
            ":mscorlib.dll",
            ":system.core.dll",
        ]
    )
    dotnet_stdlib(
        name = "system.threading.tasks.parallel.dll",
        dotnet_context_data = context_data,
        ref = "@Mono.ReferenceAssemblies.v4.5//:build/.NETFramework/v4.5/Facades/System.Threading.Tasks.Parallel.dll",
        deps = [
            ":mscorlib.dll",
        ]
    )
    dotnet_stdlib(
        name = "system.xml.readerwriter.dll",
        dotnet_context_data = context_data,
        ref = "@Mono.ReferenceAssemblies.v4.5//:build/.NETFramework/v4.5/Facades/System.Xml.ReaderWriter.dll",
        deps = [
            ":mscorlib.dll",
        ]
    )
    dotnet_stdlib(
        name = "system.xml.xdocument.dll",
        dotnet_context_data = context_data,
        ref = "@Mono.ReferenceAssemblies.v4.5//:build/.NETFramework/v4.5/Facades/System.Xml.XDocument.dll",
        deps = [
            ":mscorlib.dll",
            ":system.xml.linq.dll",
        ]
    )
    dotnet_stdlib(
        name = "system.xml.xmlserializer.dll",
        dotnet_context_data = context_data,
        ref = "@Mono.ReferenceAssemblies.v4.5//:build/.NETFramework/v4.5/Facades/System.Xml.XmlSerializer.dll",
        deps = [
            ":mscorlib.dll",
        ]
    )
