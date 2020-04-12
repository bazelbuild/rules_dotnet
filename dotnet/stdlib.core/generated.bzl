load("@io_bazel_rules_dotnet//dotnet/private:rules/stdlib.bzl", "core_stdlib")
load("@io_bazel_rules_dotnet//dotnet/private:rules/libraryset.bzl", "core_libraryset")

def define_stdlib(context_data):
    core_libraryset(
        name = "Microsoft.AspNetCore.App",
        dotnet_context_data = context_data,
        deps = [
            ":p0_microsoft.aspnetcore.antiforgery.dll",
            ":p0_microsoft.aspnetcore.authentication.abstractions.dll",
            ":p0_microsoft.aspnetcore.authentication.cookies.dll",
            ":p0_microsoft.aspnetcore.authentication.core.dll",
            ":p0_microsoft.aspnetcore.authentication.dll",
            ":p0_microsoft.aspnetcore.authentication.oauth.dll",
            ":p0_microsoft.aspnetcore.authorization.dll",
            ":p0_microsoft.aspnetcore.authorization.policy.dll",
            ":p0_microsoft.aspnetcore.components.authorization.dll",
            ":p0_microsoft.aspnetcore.components.dll",
            ":p0_microsoft.aspnetcore.components.forms.dll",
            ":p0_microsoft.aspnetcore.components.server.dll",
            ":p0_microsoft.aspnetcore.components.web.dll",
            ":p0_microsoft.aspnetcore.connections.abstractions.dll",
            ":p0_microsoft.aspnetcore.cookiepolicy.dll",
            ":p0_microsoft.aspnetcore.cors.dll",
            ":p0_microsoft.aspnetcore.cryptography.internal.dll",
            ":p0_microsoft.aspnetcore.cryptography.keyderivation.dll",
            ":p0_microsoft.aspnetcore.dataprotection.abstractions.dll",
            ":p0_microsoft.aspnetcore.dataprotection.dll",
            ":p0_microsoft.aspnetcore.dataprotection.extensions.dll",
            ":p0_microsoft.aspnetcore.diagnostics.abstractions.dll",
            ":p0_microsoft.aspnetcore.diagnostics.dll",
            ":p0_microsoft.aspnetcore.diagnostics.healthchecks.dll",
            ":p0_microsoft.aspnetcore.dll",
            ":p0_microsoft.aspnetcore.hostfiltering.dll",
            ":p0_microsoft.aspnetcore.hosting.abstractions.dll",
            ":p0_microsoft.aspnetcore.hosting.dll",
            ":p0_microsoft.aspnetcore.hosting.server.abstractions.dll",
            ":p0_microsoft.aspnetcore.html.abstractions.dll",
            ":p0_microsoft.aspnetcore.http.abstractions.dll",
            ":p0_microsoft.aspnetcore.http.connections.common.dll",
            ":p0_microsoft.aspnetcore.http.connections.dll",
            ":p0_microsoft.aspnetcore.http.dll",
            ":p0_microsoft.aspnetcore.http.extensions.dll",
            ":p0_microsoft.aspnetcore.http.features.dll",
            ":p0_microsoft.aspnetcore.httpoverrides.dll",
            ":p0_microsoft.aspnetcore.httpspolicy.dll",
            ":p0_microsoft.aspnetcore.identity.dll",
            ":p0_microsoft.aspnetcore.localization.dll",
            ":p0_microsoft.aspnetcore.localization.routing.dll",
            ":p0_microsoft.aspnetcore.metadata.dll",
            ":p0_microsoft.aspnetcore.mvc.abstractions.dll",
            ":p0_microsoft.aspnetcore.mvc.apiexplorer.dll",
            ":p0_microsoft.aspnetcore.mvc.core.dll",
            ":p0_microsoft.aspnetcore.mvc.cors.dll",
            ":p0_microsoft.aspnetcore.mvc.dataannotations.dll",
            ":p0_microsoft.aspnetcore.mvc.dll",
            ":p0_microsoft.aspnetcore.mvc.formatters.json.dll",
            ":p0_microsoft.aspnetcore.mvc.formatters.xml.dll",
            ":p0_microsoft.aspnetcore.mvc.localization.dll",
            ":p0_microsoft.aspnetcore.mvc.razor.dll",
            ":p0_microsoft.aspnetcore.mvc.razorpages.dll",
            ":p0_microsoft.aspnetcore.mvc.taghelpers.dll",
            ":p0_microsoft.aspnetcore.mvc.viewfeatures.dll",
            ":p0_microsoft.aspnetcore.razor.dll",
            ":p0_microsoft.aspnetcore.razor.runtime.dll",
            ":p0_microsoft.aspnetcore.responsecaching.abstractions.dll",
            ":p0_microsoft.aspnetcore.responsecaching.dll",
            ":p0_microsoft.aspnetcore.responsecompression.dll",
            ":p0_microsoft.aspnetcore.rewrite.dll",
            ":p0_microsoft.aspnetcore.routing.abstractions.dll",
            ":p0_microsoft.aspnetcore.routing.dll",
            ":p0_microsoft.aspnetcore.server.httpsys.dll",
            ":p0_microsoft.aspnetcore.server.iis.dll",
            ":p0_microsoft.aspnetcore.server.iisintegration.dll",
            ":p0_microsoft.aspnetcore.server.kestrel.core.dll",
            ":p0_microsoft.aspnetcore.server.kestrel.dll",
            ":p0_microsoft.aspnetcore.server.kestrel.transport.sockets.dll",
            ":p0_microsoft.aspnetcore.session.dll",
            ":p0_microsoft.aspnetcore.signalr.common.dll",
            ":p0_microsoft.aspnetcore.signalr.core.dll",
            ":p0_microsoft.aspnetcore.signalr.dll",
            ":p0_microsoft.aspnetcore.signalr.protocols.json.dll",
            ":p0_microsoft.aspnetcore.staticfiles.dll",
            ":p0_microsoft.aspnetcore.websockets.dll",
            ":p0_microsoft.aspnetcore.webutilities.dll",
            ":p0_microsoft.extensions.caching.abstractions.dll",
            ":p0_microsoft.extensions.caching.memory.dll",
            ":p0_microsoft.extensions.configuration.abstractions.dll",
            ":p0_microsoft.extensions.configuration.binder.dll",
            ":p0_microsoft.extensions.configuration.commandline.dll",
            ":p0_microsoft.extensions.configuration.dll",
            ":p0_microsoft.extensions.configuration.environmentvariables.dll",
            ":p0_microsoft.extensions.configuration.fileextensions.dll",
            ":p0_microsoft.extensions.configuration.ini.dll",
            ":p0_microsoft.extensions.configuration.json.dll",
            ":p0_microsoft.extensions.configuration.keyperfile.dll",
            ":p0_microsoft.extensions.configuration.usersecrets.dll",
            ":p0_microsoft.extensions.configuration.xml.dll",
            ":p0_microsoft.extensions.dependencyinjection.abstractions.dll",
            ":p0_microsoft.extensions.dependencyinjection.dll",
            ":p0_microsoft.extensions.diagnostics.healthchecks.abstractions.dll",
            ":p0_microsoft.extensions.diagnostics.healthchecks.dll",
            ":p0_microsoft.extensions.fileproviders.abstractions.dll",
            ":p0_microsoft.extensions.fileproviders.composite.dll",
            ":p0_microsoft.extensions.fileproviders.embedded.dll",
            ":p0_microsoft.extensions.fileproviders.physical.dll",
            ":p0_microsoft.extensions.filesystemglobbing.dll",
            ":p0_microsoft.extensions.hosting.abstractions.dll",
            ":p0_microsoft.extensions.hosting.dll",
            ":p0_microsoft.extensions.http.dll",
            ":p0_microsoft.extensions.identity.core.dll",
            ":p0_microsoft.extensions.identity.stores.dll",
            ":p0_microsoft.extensions.localization.abstractions.dll",
            ":p0_microsoft.extensions.localization.dll",
            ":p0_microsoft.extensions.logging.abstractions.dll",
            ":p0_microsoft.extensions.logging.configuration.dll",
            ":p0_microsoft.extensions.logging.console.dll",
            ":p0_microsoft.extensions.logging.debug.dll",
            ":p0_microsoft.extensions.logging.dll",
            ":p0_microsoft.extensions.logging.eventlog.dll",
            ":p0_microsoft.extensions.logging.eventsource.dll",
            ":p0_microsoft.extensions.logging.tracesource.dll",
            ":p0_microsoft.extensions.objectpool.dll",
            ":p0_microsoft.extensions.options.configurationextensions.dll",
            ":p0_microsoft.extensions.options.dataannotations.dll",
            ":p0_microsoft.extensions.options.dll",
            ":p0_microsoft.extensions.primitives.dll",
            ":p0_microsoft.extensions.webencoders.dll",
            ":p0_microsoft.jsinterop.dll",
            ":p0_microsoft.net.http.headers.dll",
            ":p0_microsoft.win32.registry.dll",
            ":p0_system.diagnostics.eventlog.dll",
            ":p0_system.io.pipelines.dll",
            ":p0_system.security.accesscontrol.dll",
            ":p0_system.security.cryptography.cng.dll",
            ":p0_system.security.cryptography.xml.dll",
            ":p0_system.security.permissions.dll",
            ":p0_system.security.principal.windows.dll",
            ":p0_system.windows.extensions.dll",
        ],
    )
    core_stdlib(
        name = "p0_microsoft.aspnetcore.antiforgery.dll",
        dotnet_context_data = context_data,
        ref = "@core_sdk//:core/packs/Microsoft.AspNetCore.App.Ref/3.1.0/ref/netcoreapp3.1/Microsoft.AspNetCore.Antiforgery.dll",
        stdlib_path = "@core_sdk//:core/shared/Microsoft.AspNetCore.App/3.1.0/Microsoft.AspNetCore.Antiforgery.dll",
        deps = [
            ":p0_microsoft.extensions.dependencyinjection.abstractions.dll",
            ":p0_microsoft.aspnetcore.http.abstractions.dll",
        ]
    )
    core_stdlib(
        name = "p0_microsoft.aspnetcore.authentication.abstractions.dll",
        dotnet_context_data = context_data,
        ref = "@core_sdk//:core/packs/Microsoft.AspNetCore.App.Ref/3.1.0/ref/netcoreapp3.1/Microsoft.AspNetCore.Authentication.Abstractions.dll",
        stdlib_path = "@core_sdk//:core/shared/Microsoft.AspNetCore.App/3.1.0/Microsoft.AspNetCore.Authentication.Abstractions.dll",
        deps = [
            ":p0_microsoft.aspnetcore.http.abstractions.dll",
        ]
    )
    core_stdlib(
        name = "p0_microsoft.aspnetcore.authentication.cookies.dll",
        dotnet_context_data = context_data,
        ref = "@core_sdk//:core/packs/Microsoft.AspNetCore.App.Ref/3.1.0/ref/netcoreapp3.1/Microsoft.AspNetCore.Authentication.Cookies.dll",
        stdlib_path = "@core_sdk//:core/shared/Microsoft.AspNetCore.App/3.1.0/Microsoft.AspNetCore.Authentication.Cookies.dll",
        deps = [
            ":p0_microsoft.aspnetcore.authentication.dll",
            ":p0_microsoft.aspnetcore.http.abstractions.dll",
            ":p0_microsoft.aspnetcore.http.features.dll",
            ":p0_microsoft.extensions.options.dll",
            ":p0_microsoft.extensions.logging.abstractions.dll",
            ":p0_microsoft.aspnetcore.authentication.abstractions.dll",
            ":p0_microsoft.aspnetcore.dataprotection.abstractions.dll",
        ]
    )
    core_stdlib(
        name = "p0_microsoft.aspnetcore.authentication.core.dll",
        dotnet_context_data = context_data,
        ref = "@core_sdk//:core/packs/Microsoft.AspNetCore.App.Ref/3.1.0/ref/netcoreapp3.1/Microsoft.AspNetCore.Authentication.Core.dll",
        stdlib_path = "@core_sdk//:core/shared/Microsoft.AspNetCore.App/3.1.0/Microsoft.AspNetCore.Authentication.Core.dll",
        deps = [
            ":p0_microsoft.extensions.dependencyinjection.abstractions.dll",
            ":p0_microsoft.aspnetcore.authentication.abstractions.dll",
            ":p0_microsoft.aspnetcore.http.abstractions.dll",
            ":p0_microsoft.extensions.options.dll",
        ]
    )
    core_stdlib(
        name = "p0_microsoft.aspnetcore.authentication.dll",
        dotnet_context_data = context_data,
        ref = "@core_sdk//:core/packs/Microsoft.AspNetCore.App.Ref/3.1.0/ref/netcoreapp3.1/Microsoft.AspNetCore.Authentication.dll",
        stdlib_path = "@core_sdk//:core/shared/Microsoft.AspNetCore.App/3.1.0/Microsoft.AspNetCore.Authentication.dll",
        deps = [
            ":p0_microsoft.extensions.dependencyinjection.abstractions.dll",
            ":p0_microsoft.aspnetcore.authentication.abstractions.dll",
            ":p0_microsoft.aspnetcore.http.abstractions.dll",
            ":p0_microsoft.extensions.options.dll",
            ":p0_microsoft.extensions.logging.abstractions.dll",
            ":p0_microsoft.aspnetcore.dataprotection.abstractions.dll",
            ":p0_microsoft.aspnetcore.http.features.dll",
        ]
    )
    core_stdlib(
        name = "p0_microsoft.aspnetcore.authentication.oauth.dll",
        dotnet_context_data = context_data,
        ref = "@core_sdk//:core/packs/Microsoft.AspNetCore.App.Ref/3.1.0/ref/netcoreapp3.1/Microsoft.AspNetCore.Authentication.OAuth.dll",
        stdlib_path = "@core_sdk//:core/shared/Microsoft.AspNetCore.App/3.1.0/Microsoft.AspNetCore.Authentication.OAuth.dll",
        deps = [
            ":p0_microsoft.aspnetcore.authentication.dll",
            ":p0_microsoft.extensions.options.dll",
            ":p0_microsoft.aspnetcore.dataprotection.abstractions.dll",
            ":p0_microsoft.aspnetcore.authentication.abstractions.dll",
            ":p0_microsoft.aspnetcore.http.abstractions.dll",
            ":p0_microsoft.extensions.logging.abstractions.dll",
        ]
    )
    core_stdlib(
        name = "p0_microsoft.aspnetcore.authorization.dll",
        dotnet_context_data = context_data,
        ref = "@core_sdk//:core/packs/Microsoft.AspNetCore.App.Ref/3.1.0/ref/netcoreapp3.1/Microsoft.AspNetCore.Authorization.dll",
        stdlib_path = "@core_sdk//:core/shared/Microsoft.AspNetCore.App/3.1.0/Microsoft.AspNetCore.Authorization.dll",
        deps = [
            ":p0_microsoft.extensions.dependencyinjection.abstractions.dll",
            ":p0_microsoft.aspnetcore.metadata.dll",
            ":p0_microsoft.extensions.options.dll",
            ":p0_microsoft.extensions.logging.abstractions.dll",
        ]
    )
    core_stdlib(
        name = "p0_microsoft.aspnetcore.authorization.policy.dll",
        dotnet_context_data = context_data,
        ref = "@core_sdk//:core/packs/Microsoft.AspNetCore.App.Ref/3.1.0/ref/netcoreapp3.1/Microsoft.AspNetCore.Authorization.Policy.dll",
        stdlib_path = "@core_sdk//:core/shared/Microsoft.AspNetCore.App/3.1.0/Microsoft.AspNetCore.Authorization.Policy.dll",
        deps = [
            ":p0_microsoft.extensions.dependencyinjection.abstractions.dll",
            ":p0_microsoft.aspnetcore.authorization.dll",
            ":p0_microsoft.aspnetcore.http.abstractions.dll",
            ":p0_microsoft.aspnetcore.metadata.dll",
            ":p0_microsoft.aspnetcore.authentication.abstractions.dll",
        ]
    )
    core_stdlib(
        name = "p0_microsoft.aspnetcore.components.authorization.dll",
        dotnet_context_data = context_data,
        ref = "@core_sdk//:core/packs/Microsoft.AspNetCore.App.Ref/3.1.0/ref/netcoreapp3.1/Microsoft.AspNetCore.Components.Authorization.dll",
        stdlib_path = "@core_sdk//:core/shared/Microsoft.AspNetCore.App/3.1.0/Microsoft.AspNetCore.Components.Authorization.dll",
        deps = [
            ":p0_microsoft.aspnetcore.components.dll",
            ":p0_microsoft.aspnetcore.metadata.dll",
        ]
    )
    core_stdlib(
        name = "p0_microsoft.aspnetcore.components.dll",
        dotnet_context_data = context_data,
        ref = "@core_sdk//:core/packs/Microsoft.AspNetCore.App.Ref/3.1.0/ref/netcoreapp3.1/Microsoft.AspNetCore.Components.dll",
        stdlib_path = "@core_sdk//:core/shared/Microsoft.AspNetCore.App/3.1.0/Microsoft.AspNetCore.Components.dll",
        deps = [
            ":p0_microsoft.extensions.logging.abstractions.dll",
        ]
    )
    core_stdlib(
        name = "p0_microsoft.aspnetcore.components.forms.dll",
        dotnet_context_data = context_data,
        ref = "@core_sdk//:core/packs/Microsoft.AspNetCore.App.Ref/3.1.0/ref/netcoreapp3.1/Microsoft.AspNetCore.Components.Forms.dll",
        stdlib_path = "@core_sdk//:core/shared/Microsoft.AspNetCore.App/3.1.0/Microsoft.AspNetCore.Components.Forms.dll",
        deps = [
            ":p0_microsoft.aspnetcore.components.dll",
        ]
    )
    core_stdlib(
        name = "p0_microsoft.aspnetcore.components.server.dll",
        dotnet_context_data = context_data,
        ref = "@core_sdk//:core/packs/Microsoft.AspNetCore.App.Ref/3.1.0/ref/netcoreapp3.1/Microsoft.AspNetCore.Components.Server.dll",
        stdlib_path = "@core_sdk//:core/shared/Microsoft.AspNetCore.App/3.1.0/Microsoft.AspNetCore.Components.Server.dll",
        deps = [
            ":p0_microsoft.extensions.dependencyinjection.abstractions.dll",
            ":p0_microsoft.aspnetcore.signalr.core.dll",
            ":p0_microsoft.extensions.logging.abstractions.dll",
            ":p0_microsoft.aspnetcore.components.authorization.dll",
            ":p0_microsoft.aspnetcore.http.abstractions.dll",
            ":p0_microsoft.aspnetcore.signalr.dll",
            ":p0_microsoft.aspnetcore.routing.dll",
            ":p0_microsoft.aspnetcore.http.connections.dll",
        ]
    )
    core_stdlib(
        name = "p0_microsoft.aspnetcore.components.web.dll",
        dotnet_context_data = context_data,
        ref = "@core_sdk//:core/packs/Microsoft.AspNetCore.App.Ref/3.1.0/ref/netcoreapp3.1/Microsoft.AspNetCore.Components.Web.dll",
        stdlib_path = "@core_sdk//:core/shared/Microsoft.AspNetCore.App/3.1.0/Microsoft.AspNetCore.Components.Web.dll",
        deps = [
            ":p0_microsoft.aspnetcore.components.dll",
            ":p0_microsoft.aspnetcore.components.forms.dll",
        ]
    )
    core_stdlib(
        name = "p0_microsoft.aspnetcore.connections.abstractions.dll",
        dotnet_context_data = context_data,
        ref = "@core_sdk//:core/packs/Microsoft.AspNetCore.App.Ref/3.1.0/ref/netcoreapp3.1/Microsoft.AspNetCore.Connections.Abstractions.dll",
        stdlib_path = "@core_sdk//:core/shared/Microsoft.AspNetCore.App/3.1.0/Microsoft.AspNetCore.Connections.Abstractions.dll",
        deps = [
            ":p0_microsoft.aspnetcore.http.features.dll",
            ":p0_system.io.pipelines.dll",
        ]
    )
    core_stdlib(
        name = "p0_microsoft.aspnetcore.cookiepolicy.dll",
        dotnet_context_data = context_data,
        ref = "@core_sdk//:core/packs/Microsoft.AspNetCore.App.Ref/3.1.0/ref/netcoreapp3.1/Microsoft.AspNetCore.CookiePolicy.dll",
        stdlib_path = "@core_sdk//:core/shared/Microsoft.AspNetCore.App/3.1.0/Microsoft.AspNetCore.CookiePolicy.dll",
        deps = [
            ":p0_microsoft.aspnetcore.http.abstractions.dll",
            ":p0_microsoft.aspnetcore.http.features.dll",
            ":p0_microsoft.extensions.options.dll",
            ":p0_microsoft.extensions.logging.abstractions.dll",
        ]
    )
    core_stdlib(
        name = "p0_microsoft.aspnetcore.cors.dll",
        dotnet_context_data = context_data,
        ref = "@core_sdk//:core/packs/Microsoft.AspNetCore.App.Ref/3.1.0/ref/netcoreapp3.1/Microsoft.AspNetCore.Cors.dll",
        stdlib_path = "@core_sdk//:core/shared/Microsoft.AspNetCore.App/3.1.0/Microsoft.AspNetCore.Cors.dll",
        deps = [
            ":p0_microsoft.extensions.dependencyinjection.abstractions.dll",
            ":p0_microsoft.aspnetcore.http.abstractions.dll",
            ":p0_microsoft.extensions.logging.abstractions.dll",
            ":p0_microsoft.extensions.options.dll",
        ]
    )
    core_stdlib(
        name = "p0_microsoft.aspnetcore.cryptography.internal.dll",
        dotnet_context_data = context_data,
        ref = "@core_sdk//:core/packs/Microsoft.AspNetCore.App.Ref/3.1.0/ref/netcoreapp3.1/Microsoft.AspNetCore.Cryptography.Internal.dll",
        stdlib_path = "@core_sdk//:core/shared/Microsoft.AspNetCore.App/3.1.0/Microsoft.AspNetCore.Cryptography.Internal.dll",
        deps = [
        ]
    )
    core_stdlib(
        name = "p0_microsoft.aspnetcore.cryptography.keyderivation.dll",
        dotnet_context_data = context_data,
        ref = "@core_sdk//:core/packs/Microsoft.AspNetCore.App.Ref/3.1.0/ref/netcoreapp3.1/Microsoft.AspNetCore.Cryptography.KeyDerivation.dll",
        stdlib_path = "@core_sdk//:core/shared/Microsoft.AspNetCore.App/3.1.0/Microsoft.AspNetCore.Cryptography.KeyDerivation.dll",
        deps = [
        ]
    )
    core_stdlib(
        name = "p0_microsoft.aspnetcore.dataprotection.abstractions.dll",
        dotnet_context_data = context_data,
        ref = "@core_sdk//:core/packs/Microsoft.AspNetCore.App.Ref/3.1.0/ref/netcoreapp3.1/Microsoft.AspNetCore.DataProtection.Abstractions.dll",
        stdlib_path = "@core_sdk//:core/shared/Microsoft.AspNetCore.App/3.1.0/Microsoft.AspNetCore.DataProtection.Abstractions.dll",
        deps = [
        ]
    )
    core_stdlib(
        name = "p0_microsoft.aspnetcore.dataprotection.dll",
        dotnet_context_data = context_data,
        ref = "@core_sdk//:core/packs/Microsoft.AspNetCore.App.Ref/3.1.0/ref/netcoreapp3.1/Microsoft.AspNetCore.DataProtection.dll",
        stdlib_path = "@core_sdk//:core/shared/Microsoft.AspNetCore.App/3.1.0/Microsoft.AspNetCore.DataProtection.dll",
        deps = [
            ":p0_microsoft.extensions.dependencyinjection.abstractions.dll",
            ":p0_microsoft.win32.registry.dll",
            ":p0_microsoft.aspnetcore.dataprotection.abstractions.dll",
            ":p0_microsoft.extensions.logging.abstractions.dll",
            ":p0_microsoft.extensions.options.dll",
        ]
    )
    core_stdlib(
        name = "p0_microsoft.aspnetcore.dataprotection.extensions.dll",
        dotnet_context_data = context_data,
        ref = "@core_sdk//:core/packs/Microsoft.AspNetCore.App.Ref/3.1.0/ref/netcoreapp3.1/Microsoft.AspNetCore.DataProtection.Extensions.dll",
        stdlib_path = "@core_sdk//:core/shared/Microsoft.AspNetCore.App/3.1.0/Microsoft.AspNetCore.DataProtection.Extensions.dll",
        deps = [
            ":p0_microsoft.aspnetcore.dataprotection.abstractions.dll",
            ":p0_microsoft.aspnetcore.dataprotection.dll",
        ]
    )
    core_stdlib(
        name = "p0_microsoft.aspnetcore.diagnostics.abstractions.dll",
        dotnet_context_data = context_data,
        ref = "@core_sdk//:core/packs/Microsoft.AspNetCore.App.Ref/3.1.0/ref/netcoreapp3.1/Microsoft.AspNetCore.Diagnostics.Abstractions.dll",
        stdlib_path = "@core_sdk//:core/shared/Microsoft.AspNetCore.App/3.1.0/Microsoft.AspNetCore.Diagnostics.Abstractions.dll",
        deps = [
            ":p0_microsoft.aspnetcore.http.abstractions.dll",
        ]
    )
    core_stdlib(
        name = "p0_microsoft.aspnetcore.diagnostics.dll",
        dotnet_context_data = context_data,
        ref = "@core_sdk//:core/packs/Microsoft.AspNetCore.App.Ref/3.1.0/ref/netcoreapp3.1/Microsoft.AspNetCore.Diagnostics.dll",
        stdlib_path = "@core_sdk//:core/shared/Microsoft.AspNetCore.App/3.1.0/Microsoft.AspNetCore.Diagnostics.dll",
        deps = [
            ":p0_microsoft.aspnetcore.http.abstractions.dll",
            ":p0_microsoft.extensions.options.dll",
            ":p0_microsoft.extensions.logging.abstractions.dll",
            ":p0_microsoft.aspnetcore.hosting.abstractions.dll",
            ":p0_microsoft.aspnetcore.diagnostics.abstractions.dll",
            ":p0_microsoft.extensions.fileproviders.abstractions.dll",
        ]
    )
    core_stdlib(
        name = "p0_microsoft.aspnetcore.diagnostics.healthchecks.dll",
        dotnet_context_data = context_data,
        ref = "@core_sdk//:core/packs/Microsoft.AspNetCore.App.Ref/3.1.0/ref/netcoreapp3.1/Microsoft.AspNetCore.Diagnostics.HealthChecks.dll",
        stdlib_path = "@core_sdk//:core/shared/Microsoft.AspNetCore.App/3.1.0/Microsoft.AspNetCore.Diagnostics.HealthChecks.dll",
        deps = [
            ":p0_microsoft.aspnetcore.http.abstractions.dll",
            ":p0_microsoft.extensions.options.dll",
            ":p0_microsoft.extensions.diagnostics.healthchecks.dll",
            ":p0_microsoft.extensions.diagnostics.healthchecks.abstractions.dll",
            ":p0_microsoft.aspnetcore.routing.dll",
        ]
    )
    core_stdlib(
        name = "p0_microsoft.aspnetcore.dll",
        dotnet_context_data = context_data,
        ref = "@core_sdk//:core/packs/Microsoft.AspNetCore.App.Ref/3.1.0/ref/netcoreapp3.1/Microsoft.AspNetCore.dll",
        stdlib_path = "@core_sdk//:core/shared/Microsoft.AspNetCore.App/3.1.0/Microsoft.AspNetCore.dll",
        deps = [
            ":p0_microsoft.extensions.hosting.abstractions.dll",
            ":p0_microsoft.aspnetcore.hosting.abstractions.dll",
            ":p0_microsoft.aspnetcore.http.abstractions.dll",
            ":p0_microsoft.aspnetcore.routing.dll",
        ]
    )
    core_stdlib(
        name = "p0_microsoft.aspnetcore.hostfiltering.dll",
        dotnet_context_data = context_data,
        ref = "@core_sdk//:core/packs/Microsoft.AspNetCore.App.Ref/3.1.0/ref/netcoreapp3.1/Microsoft.AspNetCore.HostFiltering.dll",
        stdlib_path = "@core_sdk//:core/shared/Microsoft.AspNetCore.App/3.1.0/Microsoft.AspNetCore.HostFiltering.dll",
        deps = [
            ":p0_microsoft.aspnetcore.http.abstractions.dll",
            ":p0_microsoft.extensions.logging.abstractions.dll",
            ":p0_microsoft.extensions.options.dll",
            ":p0_microsoft.extensions.dependencyinjection.abstractions.dll",
        ]
    )
    core_stdlib(
        name = "p0_microsoft.aspnetcore.hosting.abstractions.dll",
        dotnet_context_data = context_data,
        ref = "@core_sdk//:core/packs/Microsoft.AspNetCore.App.Ref/3.1.0/ref/netcoreapp3.1/Microsoft.AspNetCore.Hosting.Abstractions.dll",
        stdlib_path = "@core_sdk//:core/shared/Microsoft.AspNetCore.App/3.1.0/Microsoft.AspNetCore.Hosting.Abstractions.dll",
        deps = [
            ":p0_microsoft.extensions.configuration.abstractions.dll",
            ":p0_microsoft.aspnetcore.hosting.server.abstractions.dll",
            ":p0_microsoft.extensions.fileproviders.abstractions.dll",
            ":p0_microsoft.aspnetcore.http.abstractions.dll",
            ":p0_microsoft.extensions.dependencyinjection.abstractions.dll",
            ":p0_microsoft.aspnetcore.http.features.dll",
            ":p0_microsoft.extensions.hosting.abstractions.dll",
        ]
    )
    core_stdlib(
        name = "p0_microsoft.aspnetcore.hosting.dll",
        dotnet_context_data = context_data,
        ref = "@core_sdk//:core/packs/Microsoft.AspNetCore.App.Ref/3.1.0/ref/netcoreapp3.1/Microsoft.AspNetCore.Hosting.dll",
        stdlib_path = "@core_sdk//:core/shared/Microsoft.AspNetCore.App/3.1.0/Microsoft.AspNetCore.Hosting.dll",
        deps = [
            ":p0_microsoft.aspnetcore.http.abstractions.dll",
            ":p0_microsoft.aspnetcore.http.features.dll",
            ":p0_microsoft.extensions.dependencyinjection.abstractions.dll",
            ":p0_microsoft.aspnetcore.hosting.abstractions.dll",
            ":p0_microsoft.extensions.configuration.abstractions.dll",
            ":p0_microsoft.extensions.logging.dll",
            ":p0_microsoft.extensions.dependencyinjection.dll",
            ":p0_microsoft.aspnetcore.hosting.server.abstractions.dll",
            ":p0_microsoft.extensions.hosting.abstractions.dll",
        ]
    )
    core_stdlib(
        name = "p0_microsoft.aspnetcore.hosting.server.abstractions.dll",
        dotnet_context_data = context_data,
        ref = "@core_sdk//:core/packs/Microsoft.AspNetCore.App.Ref/3.1.0/ref/netcoreapp3.1/Microsoft.AspNetCore.Hosting.Server.Abstractions.dll",
        stdlib_path = "@core_sdk//:core/shared/Microsoft.AspNetCore.App/3.1.0/Microsoft.AspNetCore.Hosting.Server.Abstractions.dll",
        deps = [
            ":p0_microsoft.aspnetcore.http.features.dll",
        ]
    )
    core_stdlib(
        name = "p0_microsoft.aspnetcore.html.abstractions.dll",
        dotnet_context_data = context_data,
        ref = "@core_sdk//:core/packs/Microsoft.AspNetCore.App.Ref/3.1.0/ref/netcoreapp3.1/Microsoft.AspNetCore.Html.Abstractions.dll",
        stdlib_path = "@core_sdk//:core/shared/Microsoft.AspNetCore.App/3.1.0/Microsoft.AspNetCore.Html.Abstractions.dll",
        deps = [
        ]
    )
    core_stdlib(
        name = "p0_microsoft.aspnetcore.http.abstractions.dll",
        dotnet_context_data = context_data,
        ref = "@core_sdk//:core/packs/Microsoft.AspNetCore.App.Ref/3.1.0/ref/netcoreapp3.1/Microsoft.AspNetCore.Http.Abstractions.dll",
        stdlib_path = "@core_sdk//:core/shared/Microsoft.AspNetCore.App/3.1.0/Microsoft.AspNetCore.Http.Abstractions.dll",
        deps = [
            ":p0_microsoft.aspnetcore.http.features.dll",
            ":p0_microsoft.extensions.primitives.dll",
            ":p0_system.io.pipelines.dll",
        ]
    )
    core_stdlib(
        name = "p0_microsoft.aspnetcore.http.connections.common.dll",
        dotnet_context_data = context_data,
        ref = "@core_sdk//:core/packs/Microsoft.AspNetCore.App.Ref/3.1.0/ref/netcoreapp3.1/Microsoft.AspNetCore.Http.Connections.Common.dll",
        stdlib_path = "@core_sdk//:core/shared/Microsoft.AspNetCore.App/3.1.0/Microsoft.AspNetCore.Http.Connections.Common.dll",
        deps = [
        ]
    )
    core_stdlib(
        name = "p0_microsoft.aspnetcore.http.connections.dll",
        dotnet_context_data = context_data,
        ref = "@core_sdk//:core/packs/Microsoft.AspNetCore.App.Ref/3.1.0/ref/netcoreapp3.1/Microsoft.AspNetCore.Http.Connections.dll",
        stdlib_path = "@core_sdk//:core/shared/Microsoft.AspNetCore.App/3.1.0/Microsoft.AspNetCore.Http.Connections.dll",
        deps = [
            ":p0_microsoft.extensions.options.dll",
            ":p0_microsoft.aspnetcore.connections.abstractions.dll",
            ":p0_microsoft.aspnetcore.http.abstractions.dll",
            ":p0_microsoft.aspnetcore.metadata.dll",
            ":p0_microsoft.aspnetcore.http.connections.common.dll",
            ":p0_microsoft.aspnetcore.routing.dll",
            ":p0_microsoft.extensions.dependencyinjection.abstractions.dll",
        ]
    )
    core_stdlib(
        name = "p0_microsoft.aspnetcore.http.dll",
        dotnet_context_data = context_data,
        ref = "@core_sdk//:core/packs/Microsoft.AspNetCore.App.Ref/3.1.0/ref/netcoreapp3.1/Microsoft.AspNetCore.Http.dll",
        stdlib_path = "@core_sdk//:core/shared/Microsoft.AspNetCore.App/3.1.0/Microsoft.AspNetCore.Http.dll",
        deps = [
            ":p0_microsoft.extensions.dependencyinjection.abstractions.dll",
            ":p0_microsoft.aspnetcore.http.abstractions.dll",
            ":p0_microsoft.aspnetcore.http.features.dll",
            ":p0_microsoft.extensions.primitives.dll",
            ":p0_microsoft.extensions.options.dll",
            ":p0_system.io.pipelines.dll",
            ":p0_microsoft.extensions.objectpool.dll",
        ]
    )
    core_stdlib(
        name = "p0_microsoft.aspnetcore.http.extensions.dll",
        dotnet_context_data = context_data,
        ref = "@core_sdk//:core/packs/Microsoft.AspNetCore.App.Ref/3.1.0/ref/netcoreapp3.1/Microsoft.AspNetCore.Http.Extensions.dll",
        stdlib_path = "@core_sdk//:core/shared/Microsoft.AspNetCore.App/3.1.0/Microsoft.AspNetCore.Http.Extensions.dll",
        deps = [
            ":p0_microsoft.aspnetcore.http.features.dll",
            ":p0_microsoft.aspnetcore.http.abstractions.dll",
            ":p0_microsoft.extensions.fileproviders.abstractions.dll",
            ":p0_microsoft.net.http.headers.dll",
        ]
    )
    core_stdlib(
        name = "p0_microsoft.aspnetcore.http.features.dll",
        dotnet_context_data = context_data,
        ref = "@core_sdk//:core/packs/Microsoft.AspNetCore.App.Ref/3.1.0/ref/netcoreapp3.1/Microsoft.AspNetCore.Http.Features.dll",
        stdlib_path = "@core_sdk//:core/shared/Microsoft.AspNetCore.App/3.1.0/Microsoft.AspNetCore.Http.Features.dll",
        deps = [
            ":p0_microsoft.extensions.primitives.dll",
            ":p0_system.io.pipelines.dll",
        ]
    )
    core_stdlib(
        name = "p0_microsoft.aspnetcore.httpoverrides.dll",
        dotnet_context_data = context_data,
        ref = "@core_sdk//:core/packs/Microsoft.AspNetCore.App.Ref/3.1.0/ref/netcoreapp3.1/Microsoft.AspNetCore.HttpOverrides.dll",
        stdlib_path = "@core_sdk//:core/shared/Microsoft.AspNetCore.App/3.1.0/Microsoft.AspNetCore.HttpOverrides.dll",
        deps = [
            ":p0_microsoft.extensions.dependencyinjection.abstractions.dll",
            ":p0_microsoft.aspnetcore.http.abstractions.dll",
            ":p0_microsoft.extensions.logging.abstractions.dll",
            ":p0_microsoft.extensions.options.dll",
        ]
    )
    core_stdlib(
        name = "p0_microsoft.aspnetcore.httpspolicy.dll",
        dotnet_context_data = context_data,
        ref = "@core_sdk//:core/packs/Microsoft.AspNetCore.App.Ref/3.1.0/ref/netcoreapp3.1/Microsoft.AspNetCore.HttpsPolicy.dll",
        stdlib_path = "@core_sdk//:core/shared/Microsoft.AspNetCore.App/3.1.0/Microsoft.AspNetCore.HttpsPolicy.dll",
        deps = [
            ":p0_microsoft.aspnetcore.http.abstractions.dll",
            ":p0_microsoft.extensions.options.dll",
            ":p0_microsoft.extensions.logging.abstractions.dll",
            ":p0_microsoft.extensions.configuration.abstractions.dll",
            ":p0_microsoft.aspnetcore.hosting.server.abstractions.dll",
            ":p0_microsoft.extensions.dependencyinjection.abstractions.dll",
        ]
    )
    core_stdlib(
        name = "p0_microsoft.aspnetcore.identity.dll",
        dotnet_context_data = context_data,
        ref = "@core_sdk//:core/packs/Microsoft.AspNetCore.App.Ref/3.1.0/ref/netcoreapp3.1/Microsoft.AspNetCore.Identity.dll",
        stdlib_path = "@core_sdk//:core/shared/Microsoft.AspNetCore.App/3.1.0/Microsoft.AspNetCore.Identity.dll",
        deps = [
            ":p0_microsoft.extensions.identity.core.dll",
            ":p0_microsoft.extensions.dependencyinjection.abstractions.dll",
            ":p0_microsoft.aspnetcore.authentication.cookies.dll",
            ":p0_microsoft.extensions.logging.abstractions.dll",
            ":p0_microsoft.aspnetcore.http.abstractions.dll",
            ":p0_microsoft.extensions.options.dll",
            ":p0_microsoft.aspnetcore.dataprotection.abstractions.dll",
            ":p0_microsoft.aspnetcore.authentication.abstractions.dll",
            ":p0_microsoft.aspnetcore.authentication.dll",
        ]
    )
    core_stdlib(
        name = "p0_microsoft.aspnetcore.localization.dll",
        dotnet_context_data = context_data,
        ref = "@core_sdk//:core/packs/Microsoft.AspNetCore.App.Ref/3.1.0/ref/netcoreapp3.1/Microsoft.AspNetCore.Localization.dll",
        stdlib_path = "@core_sdk//:core/shared/Microsoft.AspNetCore.App/3.1.0/Microsoft.AspNetCore.Localization.dll",
        deps = [
            ":p0_microsoft.aspnetcore.http.abstractions.dll",
            ":p0_microsoft.extensions.primitives.dll",
            ":p0_microsoft.extensions.options.dll",
            ":p0_microsoft.extensions.dependencyinjection.abstractions.dll",
            ":p0_microsoft.extensions.logging.abstractions.dll",
        ]
    )
    core_stdlib(
        name = "p0_microsoft.aspnetcore.localization.routing.dll",
        dotnet_context_data = context_data,
        ref = "@core_sdk//:core/packs/Microsoft.AspNetCore.App.Ref/3.1.0/ref/netcoreapp3.1/Microsoft.AspNetCore.Localization.Routing.dll",
        stdlib_path = "@core_sdk//:core/shared/Microsoft.AspNetCore.App/3.1.0/Microsoft.AspNetCore.Localization.Routing.dll",
        deps = [
            ":p0_microsoft.aspnetcore.localization.dll",
            ":p0_microsoft.aspnetcore.http.abstractions.dll",
        ]
    )
    core_stdlib(
        name = "p0_microsoft.aspnetcore.metadata.dll",
        dotnet_context_data = context_data,
        ref = "@core_sdk//:core/packs/Microsoft.AspNetCore.App.Ref/3.1.0/ref/netcoreapp3.1/Microsoft.AspNetCore.Metadata.dll",
        stdlib_path = "@core_sdk//:core/shared/Microsoft.AspNetCore.App/3.1.0/Microsoft.AspNetCore.Metadata.dll",
        deps = [
        ]
    )
    core_stdlib(
        name = "p0_microsoft.aspnetcore.mvc.abstractions.dll",
        dotnet_context_data = context_data,
        ref = "@core_sdk//:core/packs/Microsoft.AspNetCore.App.Ref/3.1.0/ref/netcoreapp3.1/Microsoft.AspNetCore.Mvc.Abstractions.dll",
        stdlib_path = "@core_sdk//:core/shared/Microsoft.AspNetCore.App/3.1.0/Microsoft.AspNetCore.Mvc.Abstractions.dll",
        deps = [
            ":p0_microsoft.aspnetcore.http.abstractions.dll",
            ":p0_microsoft.aspnetcore.routing.abstractions.dll",
            ":p0_microsoft.extensions.primitives.dll",
        ]
    )
    core_stdlib(
        name = "p0_microsoft.aspnetcore.mvc.apiexplorer.dll",
        dotnet_context_data = context_data,
        ref = "@core_sdk//:core/packs/Microsoft.AspNetCore.App.Ref/3.1.0/ref/netcoreapp3.1/Microsoft.AspNetCore.Mvc.ApiExplorer.dll",
        stdlib_path = "@core_sdk//:core/shared/Microsoft.AspNetCore.App/3.1.0/Microsoft.AspNetCore.Mvc.ApiExplorer.dll",
        deps = [
            ":p0_microsoft.aspnetcore.mvc.core.dll",
            ":p0_microsoft.aspnetcore.mvc.abstractions.dll",
            ":p0_microsoft.extensions.options.dll",
            ":p0_microsoft.aspnetcore.routing.dll",
        ]
    )
    core_stdlib(
        name = "p0_microsoft.aspnetcore.mvc.core.dll",
        dotnet_context_data = context_data,
        ref = "@core_sdk//:core/packs/Microsoft.AspNetCore.App.Ref/3.1.0/ref/netcoreapp3.1/Microsoft.AspNetCore.Mvc.Core.dll",
        stdlib_path = "@core_sdk//:core/shared/Microsoft.AspNetCore.App/3.1.0/Microsoft.AspNetCore.Mvc.Core.dll",
        deps = [
            ":p0_microsoft.aspnetcore.routing.abstractions.dll",
            ":p0_microsoft.aspnetcore.http.abstractions.dll",
            ":p0_microsoft.aspnetcore.mvc.abstractions.dll",
            ":p0_microsoft.aspnetcore.authentication.abstractions.dll",
            ":p0_microsoft.net.http.headers.dll",
            ":p0_microsoft.extensions.fileproviders.abstractions.dll",
            ":p0_microsoft.aspnetcore.http.features.dll",
            ":p0_microsoft.extensions.primitives.dll",
            ":p0_microsoft.extensions.options.dll",
            ":p0_microsoft.extensions.logging.abstractions.dll",
            ":p0_microsoft.aspnetcore.hosting.abstractions.dll",
            ":p0_microsoft.aspnetcore.authorization.dll",
            ":p0_microsoft.aspnetcore.metadata.dll",
            ":p0_microsoft.aspnetcore.routing.dll",
            ":p0_microsoft.extensions.dependencyinjection.abstractions.dll",
        ]
    )
    core_stdlib(
        name = "p0_microsoft.aspnetcore.mvc.cors.dll",
        dotnet_context_data = context_data,
        ref = "@core_sdk//:core/packs/Microsoft.AspNetCore.App.Ref/3.1.0/ref/netcoreapp3.1/Microsoft.AspNetCore.Mvc.Cors.dll",
        stdlib_path = "@core_sdk//:core/shared/Microsoft.AspNetCore.App/3.1.0/Microsoft.AspNetCore.Mvc.Cors.dll",
        deps = [
            ":p0_microsoft.aspnetcore.mvc.core.dll",
            ":p0_microsoft.aspnetcore.cors.dll",
            ":p0_microsoft.aspnetcore.mvc.abstractions.dll",
            ":p0_microsoft.extensions.logging.abstractions.dll",
        ]
    )
    core_stdlib(
        name = "p0_microsoft.aspnetcore.mvc.dataannotations.dll",
        dotnet_context_data = context_data,
        ref = "@core_sdk//:core/packs/Microsoft.AspNetCore.App.Ref/3.1.0/ref/netcoreapp3.1/Microsoft.AspNetCore.Mvc.DataAnnotations.dll",
        stdlib_path = "@core_sdk//:core/shared/Microsoft.AspNetCore.App/3.1.0/Microsoft.AspNetCore.Mvc.DataAnnotations.dll",
        deps = [
            ":p0_microsoft.aspnetcore.mvc.core.dll",
            ":p0_microsoft.aspnetcore.mvc.abstractions.dll",
            ":p0_microsoft.extensions.localization.abstractions.dll",
        ]
    )
    core_stdlib(
        name = "p0_microsoft.aspnetcore.mvc.dll",
        dotnet_context_data = context_data,
        ref = "@core_sdk//:core/packs/Microsoft.AspNetCore.App.Ref/3.1.0/ref/netcoreapp3.1/Microsoft.AspNetCore.Mvc.dll",
        stdlib_path = "@core_sdk//:core/shared/Microsoft.AspNetCore.App/3.1.0/Microsoft.AspNetCore.Mvc.dll",
        deps = [
            ":p0_microsoft.aspnetcore.mvc.core.dll",
            ":p0_microsoft.extensions.dependencyinjection.abstractions.dll",
            ":p0_microsoft.aspnetcore.mvc.razorpages.dll",
        ]
    )
    core_stdlib(
        name = "p0_microsoft.aspnetcore.mvc.formatters.json.dll",
        dotnet_context_data = context_data,
        ref = "@core_sdk//:core/packs/Microsoft.AspNetCore.App.Ref/3.1.0/ref/netcoreapp3.1/Microsoft.AspNetCore.Mvc.Formatters.Json.dll",
        stdlib_path = "@core_sdk//:core/shared/Microsoft.AspNetCore.App/3.1.0/Microsoft.AspNetCore.Mvc.Formatters.Json.dll",
        deps = [
            ":p0_microsoft.aspnetcore.mvc.core.dll",
        ]
    )
    core_stdlib(
        name = "p0_microsoft.aspnetcore.mvc.formatters.xml.dll",
        dotnet_context_data = context_data,
        ref = "@core_sdk//:core/packs/Microsoft.AspNetCore.App.Ref/3.1.0/ref/netcoreapp3.1/Microsoft.AspNetCore.Mvc.Formatters.Xml.dll",
        stdlib_path = "@core_sdk//:core/shared/Microsoft.AspNetCore.App/3.1.0/Microsoft.AspNetCore.Mvc.Formatters.Xml.dll",
        deps = [
            ":p0_microsoft.aspnetcore.mvc.core.dll",
            ":p0_microsoft.aspnetcore.mvc.abstractions.dll",
            ":p0_microsoft.extensions.logging.abstractions.dll",
        ]
    )
    core_stdlib(
        name = "p0_microsoft.aspnetcore.mvc.localization.dll",
        dotnet_context_data = context_data,
        ref = "@core_sdk//:core/packs/Microsoft.AspNetCore.App.Ref/3.1.0/ref/netcoreapp3.1/Microsoft.AspNetCore.Mvc.Localization.dll",
        stdlib_path = "@core_sdk//:core/shared/Microsoft.AspNetCore.App/3.1.0/Microsoft.AspNetCore.Mvc.Localization.dll",
        deps = [
            ":p0_microsoft.aspnetcore.mvc.core.dll",
            ":p0_microsoft.aspnetcore.mvc.razor.dll",
            ":p0_microsoft.aspnetcore.mvc.dataannotations.dll",
            ":p0_microsoft.extensions.localization.dll",
            ":p0_microsoft.extensions.localization.abstractions.dll",
            ":p0_microsoft.aspnetcore.html.abstractions.dll",
            ":p0_microsoft.aspnetcore.mvc.viewfeatures.dll",
            ":p0_microsoft.aspnetcore.hosting.abstractions.dll",
        ]
    )
    core_stdlib(
        name = "p0_microsoft.aspnetcore.mvc.razor.dll",
        dotnet_context_data = context_data,
        ref = "@core_sdk//:core/packs/Microsoft.AspNetCore.App.Ref/3.1.0/ref/netcoreapp3.1/Microsoft.AspNetCore.Mvc.Razor.dll",
        stdlib_path = "@core_sdk//:core/shared/Microsoft.AspNetCore.App/3.1.0/Microsoft.AspNetCore.Mvc.Razor.dll",
        deps = [
            ":p0_microsoft.aspnetcore.mvc.core.dll",
            ":p0_microsoft.aspnetcore.razor.dll",
            ":p0_microsoft.aspnetcore.mvc.viewfeatures.dll",
            ":p0_microsoft.aspnetcore.html.abstractions.dll",
            ":p0_microsoft.aspnetcore.mvc.abstractions.dll",
            ":p0_microsoft.aspnetcore.http.abstractions.dll",
            ":p0_microsoft.aspnetcore.razor.runtime.dll",
            ":p0_microsoft.extensions.options.dll",
            ":p0_microsoft.extensions.logging.abstractions.dll",
            ":p0_microsoft.extensions.caching.abstractions.dll",
            ":p0_microsoft.extensions.primitives.dll",
        ]
    )
    core_stdlib(
        name = "p0_microsoft.aspnetcore.mvc.razorpages.dll",
        dotnet_context_data = context_data,
        ref = "@core_sdk//:core/packs/Microsoft.AspNetCore.App.Ref/3.1.0/ref/netcoreapp3.1/Microsoft.AspNetCore.Mvc.RazorPages.dll",
        stdlib_path = "@core_sdk//:core/shared/Microsoft.AspNetCore.App/3.1.0/Microsoft.AspNetCore.Mvc.RazorPages.dll",
        deps = [
            ":p0_microsoft.aspnetcore.mvc.core.dll",
            ":p0_microsoft.aspnetcore.mvc.abstractions.dll",
            ":p0_microsoft.aspnetcore.http.abstractions.dll",
            ":p0_microsoft.aspnetcore.routing.dll",
            ":p0_microsoft.aspnetcore.mvc.viewfeatures.dll",
            ":p0_microsoft.aspnetcore.mvc.razor.dll",
            ":p0_microsoft.aspnetcore.routing.abstractions.dll",
            ":p0_microsoft.aspnetcore.authentication.abstractions.dll",
            ":p0_microsoft.net.http.headers.dll",
            ":p0_microsoft.extensions.options.dll",
            ":p0_microsoft.aspnetcore.html.abstractions.dll",
        ]
    )
    core_stdlib(
        name = "p0_microsoft.aspnetcore.mvc.taghelpers.dll",
        dotnet_context_data = context_data,
        ref = "@core_sdk//:core/packs/Microsoft.AspNetCore.App.Ref/3.1.0/ref/netcoreapp3.1/Microsoft.AspNetCore.Mvc.TagHelpers.dll",
        stdlib_path = "@core_sdk//:core/shared/Microsoft.AspNetCore.App/3.1.0/Microsoft.AspNetCore.Mvc.TagHelpers.dll",
        deps = [
            ":p0_microsoft.aspnetcore.mvc.core.dll",
            ":p0_microsoft.aspnetcore.razor.dll",
            ":p0_microsoft.aspnetcore.mvc.viewfeatures.dll",
            ":p0_microsoft.extensions.caching.abstractions.dll",
            ":p0_microsoft.extensions.options.dll",
            ":p0_microsoft.aspnetcore.hosting.abstractions.dll",
            ":p0_microsoft.extensions.fileproviders.abstractions.dll",
            ":p0_microsoft.aspnetcore.http.abstractions.dll",
            ":p0_microsoft.aspnetcore.mvc.razor.dll",
            ":p0_microsoft.extensions.dependencyinjection.abstractions.dll",
            ":p0_microsoft.aspnetcore.html.abstractions.dll",
            ":p0_microsoft.extensions.logging.abstractions.dll",
        ]
    )
    core_stdlib(
        name = "p0_microsoft.aspnetcore.mvc.viewfeatures.dll",
        dotnet_context_data = context_data,
        ref = "@core_sdk//:core/packs/Microsoft.AspNetCore.App.Ref/3.1.0/ref/netcoreapp3.1/Microsoft.AspNetCore.Mvc.ViewFeatures.dll",
        stdlib_path = "@core_sdk//:core/shared/Microsoft.AspNetCore.App/3.1.0/Microsoft.AspNetCore.Mvc.ViewFeatures.dll",
        deps = [
            ":p0_microsoft.aspnetcore.mvc.core.dll",
            ":p0_microsoft.aspnetcore.mvc.abstractions.dll",
            ":p0_microsoft.aspnetcore.http.abstractions.dll",
            ":p0_microsoft.aspnetcore.html.abstractions.dll",
            ":p0_microsoft.aspnetcore.routing.abstractions.dll",
            ":p0_microsoft.aspnetcore.antiforgery.dll",
            ":p0_microsoft.aspnetcore.dataprotection.abstractions.dll",
            ":p0_microsoft.extensions.logging.abstractions.dll",
            ":p0_microsoft.extensions.options.dll",
            ":p0_microsoft.aspnetcore.components.dll",
        ]
    )
    core_stdlib(
        name = "p0_microsoft.aspnetcore.razor.dll",
        dotnet_context_data = context_data,
        ref = "@core_sdk//:core/packs/Microsoft.AspNetCore.App.Ref/3.1.0/ref/netcoreapp3.1/Microsoft.AspNetCore.Razor.dll",
        stdlib_path = "@core_sdk//:core/shared/Microsoft.AspNetCore.App/3.1.0/Microsoft.AspNetCore.Razor.dll",
        deps = [
            ":p0_microsoft.aspnetcore.html.abstractions.dll",
        ]
    )
    core_stdlib(
        name = "p0_microsoft.aspnetcore.razor.runtime.dll",
        dotnet_context_data = context_data,
        ref = "@core_sdk//:core/packs/Microsoft.AspNetCore.App.Ref/3.1.0/ref/netcoreapp3.1/Microsoft.AspNetCore.Razor.Runtime.dll",
        stdlib_path = "@core_sdk//:core/shared/Microsoft.AspNetCore.App/3.1.0/Microsoft.AspNetCore.Razor.Runtime.dll",
        deps = [
            ":p0_microsoft.aspnetcore.razor.dll",
        ]
    )
    core_stdlib(
        name = "p0_microsoft.aspnetcore.responsecaching.abstractions.dll",
        dotnet_context_data = context_data,
        ref = "@core_sdk//:core/packs/Microsoft.AspNetCore.App.Ref/3.1.0/ref/netcoreapp3.1/Microsoft.AspNetCore.ResponseCaching.Abstractions.dll",
        stdlib_path = "@core_sdk//:core/shared/Microsoft.AspNetCore.App/3.1.0/Microsoft.AspNetCore.ResponseCaching.Abstractions.dll",
        deps = [
        ]
    )
    core_stdlib(
        name = "p0_microsoft.aspnetcore.responsecaching.dll",
        dotnet_context_data = context_data,
        ref = "@core_sdk//:core/packs/Microsoft.AspNetCore.App.Ref/3.1.0/ref/netcoreapp3.1/Microsoft.AspNetCore.ResponseCaching.dll",
        stdlib_path = "@core_sdk//:core/shared/Microsoft.AspNetCore.App/3.1.0/Microsoft.AspNetCore.ResponseCaching.dll",
        deps = [
            ":p0_microsoft.extensions.dependencyinjection.abstractions.dll",
            ":p0_microsoft.aspnetcore.responsecaching.abstractions.dll",
            ":p0_microsoft.aspnetcore.http.abstractions.dll",
            ":p0_microsoft.extensions.options.dll",
            ":p0_microsoft.extensions.logging.abstractions.dll",
            ":p0_microsoft.extensions.objectpool.dll",
        ]
    )
    core_stdlib(
        name = "p0_microsoft.aspnetcore.responsecompression.dll",
        dotnet_context_data = context_data,
        ref = "@core_sdk//:core/packs/Microsoft.AspNetCore.App.Ref/3.1.0/ref/netcoreapp3.1/Microsoft.AspNetCore.ResponseCompression.dll",
        stdlib_path = "@core_sdk//:core/shared/Microsoft.AspNetCore.App/3.1.0/Microsoft.AspNetCore.ResponseCompression.dll",
        deps = [
            ":p0_microsoft.extensions.options.dll",
            ":p0_microsoft.aspnetcore.http.abstractions.dll",
            ":p0_microsoft.extensions.dependencyinjection.abstractions.dll",
        ]
    )
    core_stdlib(
        name = "p0_microsoft.aspnetcore.rewrite.dll",
        dotnet_context_data = context_data,
        ref = "@core_sdk//:core/packs/Microsoft.AspNetCore.App.Ref/3.1.0/ref/netcoreapp3.1/Microsoft.AspNetCore.Rewrite.dll",
        stdlib_path = "@core_sdk//:core/shared/Microsoft.AspNetCore.App/3.1.0/Microsoft.AspNetCore.Rewrite.dll",
        deps = [
            ":p0_microsoft.extensions.fileproviders.abstractions.dll",
            ":p0_microsoft.aspnetcore.http.abstractions.dll",
            ":p0_microsoft.extensions.logging.abstractions.dll",
            ":p0_microsoft.aspnetcore.hosting.abstractions.dll",
            ":p0_microsoft.extensions.options.dll",
        ]
    )
    core_stdlib(
        name = "p0_microsoft.aspnetcore.routing.abstractions.dll",
        dotnet_context_data = context_data,
        ref = "@core_sdk//:core/packs/Microsoft.AspNetCore.App.Ref/3.1.0/ref/netcoreapp3.1/Microsoft.AspNetCore.Routing.Abstractions.dll",
        stdlib_path = "@core_sdk//:core/shared/Microsoft.AspNetCore.App/3.1.0/Microsoft.AspNetCore.Routing.Abstractions.dll",
        deps = [
            ":p0_microsoft.aspnetcore.http.abstractions.dll",
        ]
    )
    core_stdlib(
        name = "p0_microsoft.aspnetcore.routing.dll",
        dotnet_context_data = context_data,
        ref = "@core_sdk//:core/packs/Microsoft.AspNetCore.App.Ref/3.1.0/ref/netcoreapp3.1/Microsoft.AspNetCore.Routing.dll",
        stdlib_path = "@core_sdk//:core/shared/Microsoft.AspNetCore.App/3.1.0/Microsoft.AspNetCore.Routing.dll",
        deps = [
            ":p0_microsoft.aspnetcore.http.abstractions.dll",
            ":p0_microsoft.extensions.primitives.dll",
            ":p0_microsoft.extensions.options.dll",
            ":p0_microsoft.aspnetcore.routing.abstractions.dll",
            ":p0_microsoft.extensions.logging.abstractions.dll",
            ":p0_microsoft.extensions.dependencyinjection.abstractions.dll",
        ]
    )
    core_stdlib(
        name = "p0_microsoft.aspnetcore.server.httpsys.dll",
        dotnet_context_data = context_data,
        ref = "@core_sdk//:core/packs/Microsoft.AspNetCore.App.Ref/3.1.0/ref/netcoreapp3.1/Microsoft.AspNetCore.Server.HttpSys.dll",
        stdlib_path = "@core_sdk//:core/shared/Microsoft.AspNetCore.App/3.1.0/Microsoft.AspNetCore.Server.HttpSys.dll",
        deps = [
            ":p0_microsoft.aspnetcore.hosting.abstractions.dll",
        ]
    )
    core_stdlib(
        name = "p0_microsoft.aspnetcore.server.iis.dll",
        dotnet_context_data = context_data,
        ref = "@core_sdk//:core/packs/Microsoft.AspNetCore.App.Ref/3.1.0/ref/netcoreapp3.1/Microsoft.AspNetCore.Server.IIS.dll",
        stdlib_path = "@core_sdk//:core/shared/Microsoft.AspNetCore.App/3.1.0/Microsoft.AspNetCore.Server.IIS.dll",
        deps = [
            ":p0_microsoft.aspnetcore.http.abstractions.dll",
            ":p0_microsoft.aspnetcore.authentication.abstractions.dll",
            ":p0_microsoft.aspnetcore.hosting.abstractions.dll",
            ":p0_microsoft.aspnetcore.http.features.dll",
        ]
    )
    core_stdlib(
        name = "p0_microsoft.aspnetcore.server.iisintegration.dll",
        dotnet_context_data = context_data,
        ref = "@core_sdk//:core/packs/Microsoft.AspNetCore.App.Ref/3.1.0/ref/netcoreapp3.1/Microsoft.AspNetCore.Server.IISIntegration.dll",
        stdlib_path = "@core_sdk//:core/shared/Microsoft.AspNetCore.App/3.1.0/Microsoft.AspNetCore.Server.IISIntegration.dll",
        deps = [
            ":p0_microsoft.aspnetcore.hosting.abstractions.dll",
            ":p0_microsoft.aspnetcore.http.abstractions.dll",
            ":p0_microsoft.extensions.logging.abstractions.dll",
            ":p0_microsoft.extensions.options.dll",
            ":p0_microsoft.aspnetcore.authentication.abstractions.dll",
            ":p0_microsoft.extensions.hosting.abstractions.dll",
        ]
    )
    core_stdlib(
        name = "p0_microsoft.aspnetcore.server.kestrel.core.dll",
        dotnet_context_data = context_data,
        ref = "@core_sdk//:core/packs/Microsoft.AspNetCore.App.Ref/3.1.0/ref/netcoreapp3.1/Microsoft.AspNetCore.Server.Kestrel.Core.dll",
        stdlib_path = "@core_sdk//:core/shared/Microsoft.AspNetCore.App/3.1.0/Microsoft.AspNetCore.Server.Kestrel.Core.dll",
        deps = [
            ":p0_microsoft.extensions.configuration.abstractions.dll",
            ":p0_microsoft.aspnetcore.connections.abstractions.dll",
            ":p0_microsoft.aspnetcore.hosting.server.abstractions.dll",
            ":p0_microsoft.extensions.options.dll",
            ":p0_microsoft.extensions.logging.abstractions.dll",
            ":p0_microsoft.aspnetcore.http.features.dll",
        ]
    )
    core_stdlib(
        name = "p0_microsoft.aspnetcore.server.kestrel.dll",
        dotnet_context_data = context_data,
        ref = "@core_sdk//:core/packs/Microsoft.AspNetCore.App.Ref/3.1.0/ref/netcoreapp3.1/Microsoft.AspNetCore.Server.Kestrel.dll",
        stdlib_path = "@core_sdk//:core/shared/Microsoft.AspNetCore.App/3.1.0/Microsoft.AspNetCore.Server.Kestrel.dll",
        deps = [
            ":p0_microsoft.aspnetcore.hosting.abstractions.dll",
            ":p0_microsoft.aspnetcore.server.kestrel.core.dll",
        ]
    )
    core_stdlib(
        name = "p0_microsoft.aspnetcore.server.kestrel.transport.sockets.dll",
        dotnet_context_data = context_data,
        ref = "@core_sdk//:core/packs/Microsoft.AspNetCore.App.Ref/3.1.0/ref/netcoreapp3.1/Microsoft.AspNetCore.Server.Kestrel.Transport.Sockets.dll",
        stdlib_path = "@core_sdk//:core/shared/Microsoft.AspNetCore.App/3.1.0/Microsoft.AspNetCore.Server.Kestrel.Transport.Sockets.dll",
        deps = [
            ":p0_microsoft.aspnetcore.connections.abstractions.dll",
            ":p0_microsoft.extensions.options.dll",
            ":p0_microsoft.extensions.logging.abstractions.dll",
            ":p0_microsoft.aspnetcore.hosting.abstractions.dll",
        ]
    )
    core_stdlib(
        name = "p0_microsoft.aspnetcore.session.dll",
        dotnet_context_data = context_data,
        ref = "@core_sdk//:core/packs/Microsoft.AspNetCore.App.Ref/3.1.0/ref/netcoreapp3.1/Microsoft.AspNetCore.Session.dll",
        stdlib_path = "@core_sdk//:core/shared/Microsoft.AspNetCore.App/3.1.0/Microsoft.AspNetCore.Session.dll",
        deps = [
            ":p0_microsoft.extensions.dependencyinjection.abstractions.dll",
            ":p0_microsoft.aspnetcore.http.features.dll",
            ":p0_microsoft.extensions.caching.abstractions.dll",
            ":p0_microsoft.extensions.logging.abstractions.dll",
            ":p0_microsoft.aspnetcore.http.abstractions.dll",
            ":p0_microsoft.aspnetcore.dataprotection.abstractions.dll",
            ":p0_microsoft.extensions.options.dll",
        ]
    )
    core_stdlib(
        name = "p0_microsoft.aspnetcore.signalr.common.dll",
        dotnet_context_data = context_data,
        ref = "@core_sdk//:core/packs/Microsoft.AspNetCore.App.Ref/3.1.0/ref/netcoreapp3.1/Microsoft.AspNetCore.SignalR.Common.dll",
        stdlib_path = "@core_sdk//:core/shared/Microsoft.AspNetCore.App/3.1.0/Microsoft.AspNetCore.SignalR.Common.dll",
        deps = [
            ":p0_microsoft.extensions.dependencyinjection.abstractions.dll",
            ":p0_microsoft.aspnetcore.connections.abstractions.dll",
        ]
    )
    core_stdlib(
        name = "p0_microsoft.aspnetcore.signalr.core.dll",
        dotnet_context_data = context_data,
        ref = "@core_sdk//:core/packs/Microsoft.AspNetCore.App.Ref/3.1.0/ref/netcoreapp3.1/Microsoft.AspNetCore.SignalR.Core.dll",
        stdlib_path = "@core_sdk//:core/shared/Microsoft.AspNetCore.App/3.1.0/Microsoft.AspNetCore.SignalR.Core.dll",
        deps = [
            ":p0_microsoft.extensions.dependencyinjection.abstractions.dll",
            ":p0_microsoft.extensions.logging.abstractions.dll",
            ":p0_microsoft.aspnetcore.http.features.dll",
            ":p0_microsoft.aspnetcore.connections.abstractions.dll",
            ":p0_microsoft.aspnetcore.signalr.common.dll",
            ":p0_microsoft.extensions.options.dll",
        ]
    )
    core_stdlib(
        name = "p0_microsoft.aspnetcore.signalr.dll",
        dotnet_context_data = context_data,
        ref = "@core_sdk//:core/packs/Microsoft.AspNetCore.App.Ref/3.1.0/ref/netcoreapp3.1/Microsoft.AspNetCore.SignalR.dll",
        stdlib_path = "@core_sdk//:core/shared/Microsoft.AspNetCore.App/3.1.0/Microsoft.AspNetCore.SignalR.dll",
        deps = [
            ":p0_microsoft.aspnetcore.signalr.core.dll",
            ":p0_microsoft.extensions.dependencyinjection.abstractions.dll",
            ":p0_microsoft.aspnetcore.http.abstractions.dll",
            ":p0_microsoft.aspnetcore.http.connections.dll",
            ":p0_microsoft.aspnetcore.routing.dll",
        ]
    )
    core_stdlib(
        name = "p0_microsoft.aspnetcore.signalr.protocols.json.dll",
        dotnet_context_data = context_data,
        ref = "@core_sdk//:core/packs/Microsoft.AspNetCore.App.Ref/3.1.0/ref/netcoreapp3.1/Microsoft.AspNetCore.SignalR.Protocols.Json.dll",
        stdlib_path = "@core_sdk//:core/shared/Microsoft.AspNetCore.App/3.1.0/Microsoft.AspNetCore.SignalR.Protocols.Json.dll",
        deps = [
            ":p0_microsoft.aspnetcore.signalr.common.dll",
            ":p0_microsoft.extensions.options.dll",
            ":p0_microsoft.aspnetcore.connections.abstractions.dll",
        ]
    )
    core_stdlib(
        name = "p0_microsoft.aspnetcore.staticfiles.dll",
        dotnet_context_data = context_data,
        ref = "@core_sdk//:core/packs/Microsoft.AspNetCore.App.Ref/3.1.0/ref/netcoreapp3.1/Microsoft.AspNetCore.StaticFiles.dll",
        stdlib_path = "@core_sdk//:core/shared/Microsoft.AspNetCore.App/3.1.0/Microsoft.AspNetCore.StaticFiles.dll",
        deps = [
            ":p0_microsoft.extensions.dependencyinjection.abstractions.dll",
            ":p0_microsoft.aspnetcore.http.abstractions.dll",
            ":p0_microsoft.aspnetcore.hosting.abstractions.dll",
            ":p0_microsoft.extensions.options.dll",
            ":p0_microsoft.extensions.fileproviders.abstractions.dll",
            ":p0_microsoft.extensions.logging.abstractions.dll",
            ":p0_microsoft.aspnetcore.http.features.dll",
            ":p0_microsoft.aspnetcore.routing.dll",
        ]
    )
    core_stdlib(
        name = "p0_microsoft.aspnetcore.websockets.dll",
        dotnet_context_data = context_data,
        ref = "@core_sdk//:core/packs/Microsoft.AspNetCore.App.Ref/3.1.0/ref/netcoreapp3.1/Microsoft.AspNetCore.WebSockets.dll",
        stdlib_path = "@core_sdk//:core/shared/Microsoft.AspNetCore.App/3.1.0/Microsoft.AspNetCore.WebSockets.dll",
        deps = [
            ":p0_microsoft.aspnetcore.http.features.dll",
            ":p0_microsoft.aspnetcore.http.abstractions.dll",
            ":p0_microsoft.extensions.options.dll",
            ":p0_microsoft.extensions.logging.abstractions.dll",
            ":p0_microsoft.extensions.dependencyinjection.abstractions.dll",
        ]
    )
    core_stdlib(
        name = "p0_microsoft.aspnetcore.webutilities.dll",
        dotnet_context_data = context_data,
        ref = "@core_sdk//:core/packs/Microsoft.AspNetCore.App.Ref/3.1.0/ref/netcoreapp3.1/Microsoft.AspNetCore.WebUtilities.dll",
        stdlib_path = "@core_sdk//:core/shared/Microsoft.AspNetCore.App/3.1.0/Microsoft.AspNetCore.WebUtilities.dll",
        deps = [
            ":p0_microsoft.net.http.headers.dll",
            ":p0_system.io.pipelines.dll",
            ":p0_microsoft.extensions.primitives.dll",
        ]
    )
    core_stdlib(
        name = "p0_microsoft.extensions.caching.abstractions.dll",
        dotnet_context_data = context_data,
        ref = "@core_sdk//:core/packs/Microsoft.AspNetCore.App.Ref/3.1.0/ref/netcoreapp3.1/Microsoft.Extensions.Caching.Abstractions.dll",
        stdlib_path = "@core_sdk//:core/shared/Microsoft.AspNetCore.App/3.1.0/Microsoft.Extensions.Caching.Abstractions.dll",
        deps = [
            ":p0_microsoft.extensions.primitives.dll",
        ]
    )
    core_stdlib(
        name = "p0_microsoft.extensions.caching.memory.dll",
        dotnet_context_data = context_data,
        ref = "@core_sdk//:core/packs/Microsoft.AspNetCore.App.Ref/3.1.0/ref/netcoreapp3.1/Microsoft.Extensions.Caching.Memory.dll",
        stdlib_path = "@core_sdk//:core/shared/Microsoft.AspNetCore.App/3.1.0/Microsoft.Extensions.Caching.Memory.dll",
        deps = [
            ":p0_microsoft.extensions.dependencyinjection.abstractions.dll",
            ":p0_microsoft.extensions.caching.abstractions.dll",
            ":p0_microsoft.extensions.options.dll",
            ":p0_microsoft.extensions.logging.abstractions.dll",
        ]
    )
    core_stdlib(
        name = "p0_microsoft.extensions.configuration.abstractions.dll",
        dotnet_context_data = context_data,
        ref = "@core_sdk//:core/packs/Microsoft.AspNetCore.App.Ref/3.1.0/ref/netcoreapp3.1/Microsoft.Extensions.Configuration.Abstractions.dll",
        stdlib_path = "@core_sdk//:core/shared/Microsoft.AspNetCore.App/3.1.0/Microsoft.Extensions.Configuration.Abstractions.dll",
        deps = [
            ":p0_microsoft.extensions.primitives.dll",
        ]
    )
    core_stdlib(
        name = "p0_microsoft.extensions.configuration.binder.dll",
        dotnet_context_data = context_data,
        ref = "@core_sdk//:core/packs/Microsoft.AspNetCore.App.Ref/3.1.0/ref/netcoreapp3.1/Microsoft.Extensions.Configuration.Binder.dll",
        stdlib_path = "@core_sdk//:core/shared/Microsoft.AspNetCore.App/3.1.0/Microsoft.Extensions.Configuration.Binder.dll",
        deps = [
            ":p0_microsoft.extensions.configuration.abstractions.dll",
        ]
    )
    core_stdlib(
        name = "p0_microsoft.extensions.configuration.commandline.dll",
        dotnet_context_data = context_data,
        ref = "@core_sdk//:core/packs/Microsoft.AspNetCore.App.Ref/3.1.0/ref/netcoreapp3.1/Microsoft.Extensions.Configuration.CommandLine.dll",
        stdlib_path = "@core_sdk//:core/shared/Microsoft.AspNetCore.App/3.1.0/Microsoft.Extensions.Configuration.CommandLine.dll",
        deps = [
            ":p0_microsoft.extensions.configuration.abstractions.dll",
            ":p0_microsoft.extensions.configuration.dll",
        ]
    )
    core_stdlib(
        name = "p0_microsoft.extensions.configuration.dll",
        dotnet_context_data = context_data,
        ref = "@core_sdk//:core/packs/Microsoft.AspNetCore.App.Ref/3.1.0/ref/netcoreapp3.1/Microsoft.Extensions.Configuration.dll",
        stdlib_path = "@core_sdk//:core/shared/Microsoft.AspNetCore.App/3.1.0/Microsoft.Extensions.Configuration.dll",
        deps = [
            ":p0_microsoft.extensions.configuration.abstractions.dll",
            ":p0_microsoft.extensions.primitives.dll",
        ]
    )
    core_stdlib(
        name = "p0_microsoft.extensions.configuration.environmentvariables.dll",
        dotnet_context_data = context_data,
        ref = "@core_sdk//:core/packs/Microsoft.AspNetCore.App.Ref/3.1.0/ref/netcoreapp3.1/Microsoft.Extensions.Configuration.EnvironmentVariables.dll",
        stdlib_path = "@core_sdk//:core/shared/Microsoft.AspNetCore.App/3.1.0/Microsoft.Extensions.Configuration.EnvironmentVariables.dll",
        deps = [
            ":p0_microsoft.extensions.configuration.abstractions.dll",
            ":p0_microsoft.extensions.configuration.dll",
        ]
    )
    core_stdlib(
        name = "p0_microsoft.extensions.configuration.fileextensions.dll",
        dotnet_context_data = context_data,
        ref = "@core_sdk//:core/packs/Microsoft.AspNetCore.App.Ref/3.1.0/ref/netcoreapp3.1/Microsoft.Extensions.Configuration.FileExtensions.dll",
        stdlib_path = "@core_sdk//:core/shared/Microsoft.AspNetCore.App/3.1.0/Microsoft.Extensions.Configuration.FileExtensions.dll",
        deps = [
            ":p0_microsoft.extensions.configuration.abstractions.dll",
            ":p0_microsoft.extensions.fileproviders.abstractions.dll",
            ":p0_microsoft.extensions.configuration.dll",
        ]
    )
    core_stdlib(
        name = "p0_microsoft.extensions.configuration.ini.dll",
        dotnet_context_data = context_data,
        ref = "@core_sdk//:core/packs/Microsoft.AspNetCore.App.Ref/3.1.0/ref/netcoreapp3.1/Microsoft.Extensions.Configuration.Ini.dll",
        stdlib_path = "@core_sdk//:core/shared/Microsoft.AspNetCore.App/3.1.0/Microsoft.Extensions.Configuration.Ini.dll",
        deps = [
            ":p0_microsoft.extensions.configuration.abstractions.dll",
            ":p0_microsoft.extensions.fileproviders.abstractions.dll",
            ":p0_microsoft.extensions.configuration.fileextensions.dll",
            ":p0_microsoft.extensions.configuration.dll",
        ]
    )
    core_stdlib(
        name = "p0_microsoft.extensions.configuration.json.dll",
        dotnet_context_data = context_data,
        ref = "@core_sdk//:core/packs/Microsoft.AspNetCore.App.Ref/3.1.0/ref/netcoreapp3.1/Microsoft.Extensions.Configuration.Json.dll",
        stdlib_path = "@core_sdk//:core/shared/Microsoft.AspNetCore.App/3.1.0/Microsoft.Extensions.Configuration.Json.dll",
        deps = [
            ":p0_microsoft.extensions.configuration.abstractions.dll",
            ":p0_microsoft.extensions.fileproviders.abstractions.dll",
            ":p0_microsoft.extensions.configuration.fileextensions.dll",
            ":p0_microsoft.extensions.configuration.dll",
        ]
    )
    core_stdlib(
        name = "p0_microsoft.extensions.configuration.keyperfile.dll",
        dotnet_context_data = context_data,
        ref = "@core_sdk//:core/packs/Microsoft.AspNetCore.App.Ref/3.1.0/ref/netcoreapp3.1/Microsoft.Extensions.Configuration.KeyPerFile.dll",
        stdlib_path = "@core_sdk//:core/shared/Microsoft.AspNetCore.App/3.1.0/Microsoft.Extensions.Configuration.KeyPerFile.dll",
        deps = [
            ":p0_microsoft.extensions.configuration.abstractions.dll",
            ":p0_microsoft.extensions.configuration.dll",
            ":p0_microsoft.extensions.fileproviders.abstractions.dll",
        ]
    )
    core_stdlib(
        name = "p0_microsoft.extensions.configuration.usersecrets.dll",
        dotnet_context_data = context_data,
        ref = "@core_sdk//:core/packs/Microsoft.AspNetCore.App.Ref/3.1.0/ref/netcoreapp3.1/Microsoft.Extensions.Configuration.UserSecrets.dll",
        stdlib_path = "@core_sdk//:core/shared/Microsoft.AspNetCore.App/3.1.0/Microsoft.Extensions.Configuration.UserSecrets.dll",
        deps = [
            ":p0_microsoft.extensions.configuration.abstractions.dll",
        ]
    )
    core_stdlib(
        name = "p0_microsoft.extensions.configuration.xml.dll",
        dotnet_context_data = context_data,
        ref = "@core_sdk//:core/packs/Microsoft.AspNetCore.App.Ref/3.1.0/ref/netcoreapp3.1/Microsoft.Extensions.Configuration.Xml.dll",
        stdlib_path = "@core_sdk//:core/shared/Microsoft.AspNetCore.App/3.1.0/Microsoft.Extensions.Configuration.Xml.dll",
        deps = [
            ":p0_microsoft.extensions.configuration.abstractions.dll",
            ":p0_microsoft.extensions.fileproviders.abstractions.dll",
            ":p0_microsoft.extensions.configuration.fileextensions.dll",
            ":p0_microsoft.extensions.configuration.dll",
        ]
    )
    core_stdlib(
        name = "p0_microsoft.extensions.dependencyinjection.abstractions.dll",
        dotnet_context_data = context_data,
        ref = "@core_sdk//:core/packs/Microsoft.AspNetCore.App.Ref/3.1.0/ref/netcoreapp3.1/Microsoft.Extensions.DependencyInjection.Abstractions.dll",
        stdlib_path = "@core_sdk//:core/shared/Microsoft.AspNetCore.App/3.1.0/Microsoft.Extensions.DependencyInjection.Abstractions.dll",
        deps = [
        ]
    )
    core_stdlib(
        name = "p0_microsoft.extensions.dependencyinjection.dll",
        dotnet_context_data = context_data,
        ref = "@core_sdk//:core/packs/Microsoft.AspNetCore.App.Ref/3.1.0/ref/netcoreapp3.1/Microsoft.Extensions.DependencyInjection.dll",
        stdlib_path = "@core_sdk//:core/shared/Microsoft.AspNetCore.App/3.1.0/Microsoft.Extensions.DependencyInjection.dll",
        deps = [
            ":p0_microsoft.extensions.dependencyinjection.abstractions.dll",
        ]
    )
    core_stdlib(
        name = "p0_microsoft.extensions.diagnostics.healthchecks.abstractions.dll",
        dotnet_context_data = context_data,
        ref = "@core_sdk//:core/packs/Microsoft.AspNetCore.App.Ref/3.1.0/ref/netcoreapp3.1/Microsoft.Extensions.Diagnostics.HealthChecks.Abstractions.dll",
        stdlib_path = "@core_sdk//:core/shared/Microsoft.AspNetCore.App/3.1.0/Microsoft.Extensions.Diagnostics.HealthChecks.Abstractions.dll",
        deps = [
        ]
    )
    core_stdlib(
        name = "p0_microsoft.extensions.diagnostics.healthchecks.dll",
        dotnet_context_data = context_data,
        ref = "@core_sdk//:core/packs/Microsoft.AspNetCore.App.Ref/3.1.0/ref/netcoreapp3.1/Microsoft.Extensions.Diagnostics.HealthChecks.dll",
        stdlib_path = "@core_sdk//:core/shared/Microsoft.AspNetCore.App/3.1.0/Microsoft.Extensions.Diagnostics.HealthChecks.dll",
        deps = [
            ":p0_microsoft.extensions.diagnostics.healthchecks.abstractions.dll",
            ":p0_microsoft.extensions.dependencyinjection.abstractions.dll",
        ]
    )
    core_stdlib(
        name = "p0_microsoft.extensions.fileproviders.abstractions.dll",
        dotnet_context_data = context_data,
        ref = "@core_sdk//:core/packs/Microsoft.AspNetCore.App.Ref/3.1.0/ref/netcoreapp3.1/Microsoft.Extensions.FileProviders.Abstractions.dll",
        stdlib_path = "@core_sdk//:core/shared/Microsoft.AspNetCore.App/3.1.0/Microsoft.Extensions.FileProviders.Abstractions.dll",
        deps = [
            ":p0_microsoft.extensions.primitives.dll",
        ]
    )
    core_stdlib(
        name = "p0_microsoft.extensions.fileproviders.composite.dll",
        dotnet_context_data = context_data,
        ref = "@core_sdk//:core/packs/Microsoft.AspNetCore.App.Ref/3.1.0/ref/netcoreapp3.1/Microsoft.Extensions.FileProviders.Composite.dll",
        stdlib_path = "@core_sdk//:core/shared/Microsoft.AspNetCore.App/3.1.0/Microsoft.Extensions.FileProviders.Composite.dll",
        deps = [
            ":p0_microsoft.extensions.fileproviders.abstractions.dll",
            ":p0_microsoft.extensions.primitives.dll",
        ]
    )
    core_stdlib(
        name = "p0_microsoft.extensions.fileproviders.embedded.dll",
        dotnet_context_data = context_data,
        ref = "@core_sdk//:core/packs/Microsoft.AspNetCore.App.Ref/3.1.0/ref/netcoreapp3.1/Microsoft.Extensions.FileProviders.Embedded.dll",
        stdlib_path = "@core_sdk//:core/shared/Microsoft.AspNetCore.App/3.1.0/Microsoft.Extensions.FileProviders.Embedded.dll",
        deps = [
            ":p0_microsoft.extensions.fileproviders.abstractions.dll",
            ":p0_microsoft.extensions.primitives.dll",
        ]
    )
    core_stdlib(
        name = "p0_microsoft.extensions.fileproviders.physical.dll",
        dotnet_context_data = context_data,
        ref = "@core_sdk//:core/packs/Microsoft.AspNetCore.App.Ref/3.1.0/ref/netcoreapp3.1/Microsoft.Extensions.FileProviders.Physical.dll",
        stdlib_path = "@core_sdk//:core/shared/Microsoft.AspNetCore.App/3.1.0/Microsoft.Extensions.FileProviders.Physical.dll",
        deps = [
            ":p0_microsoft.extensions.fileproviders.abstractions.dll",
            ":p0_microsoft.extensions.primitives.dll",
        ]
    )
    core_stdlib(
        name = "p0_microsoft.extensions.filesystemglobbing.dll",
        dotnet_context_data = context_data,
        ref = "@core_sdk//:core/packs/Microsoft.AspNetCore.App.Ref/3.1.0/ref/netcoreapp3.1/Microsoft.Extensions.FileSystemGlobbing.dll",
        stdlib_path = "@core_sdk//:core/shared/Microsoft.AspNetCore.App/3.1.0/Microsoft.Extensions.FileSystemGlobbing.dll",
        deps = [
        ]
    )
    core_stdlib(
        name = "p0_microsoft.extensions.hosting.abstractions.dll",
        dotnet_context_data = context_data,
        ref = "@core_sdk//:core/packs/Microsoft.AspNetCore.App.Ref/3.1.0/ref/netcoreapp3.1/Microsoft.Extensions.Hosting.Abstractions.dll",
        stdlib_path = "@core_sdk//:core/shared/Microsoft.AspNetCore.App/3.1.0/Microsoft.Extensions.Hosting.Abstractions.dll",
        deps = [
            ":p0_microsoft.extensions.configuration.abstractions.dll",
            ":p0_microsoft.extensions.dependencyinjection.abstractions.dll",
            ":p0_microsoft.extensions.fileproviders.abstractions.dll",
        ]
    )
    core_stdlib(
        name = "p0_microsoft.extensions.hosting.dll",
        dotnet_context_data = context_data,
        ref = "@core_sdk//:core/packs/Microsoft.AspNetCore.App.Ref/3.1.0/ref/netcoreapp3.1/Microsoft.Extensions.Hosting.dll",
        stdlib_path = "@core_sdk//:core/shared/Microsoft.AspNetCore.App/3.1.0/Microsoft.Extensions.Hosting.dll",
        deps = [
            ":p0_microsoft.extensions.hosting.abstractions.dll",
            ":p0_microsoft.extensions.configuration.abstractions.dll",
            ":p0_microsoft.extensions.dependencyinjection.abstractions.dll",
            ":p0_microsoft.extensions.logging.dll",
            ":p0_microsoft.extensions.dependencyinjection.dll",
            ":p0_microsoft.extensions.logging.abstractions.dll",
            ":p0_microsoft.extensions.options.dll",
            ":p0_microsoft.extensions.fileproviders.abstractions.dll",
        ]
    )
    core_stdlib(
        name = "p0_microsoft.extensions.http.dll",
        dotnet_context_data = context_data,
        ref = "@core_sdk//:core/packs/Microsoft.AspNetCore.App.Ref/3.1.0/ref/netcoreapp3.1/Microsoft.Extensions.Http.dll",
        stdlib_path = "@core_sdk//:core/shared/Microsoft.AspNetCore.App/3.1.0/Microsoft.Extensions.Http.dll",
        deps = [
            ":p0_microsoft.extensions.logging.abstractions.dll",
            ":p0_microsoft.extensions.dependencyinjection.abstractions.dll",
        ]
    )
    core_stdlib(
        name = "p0_microsoft.extensions.identity.core.dll",
        dotnet_context_data = context_data,
        ref = "@core_sdk//:core/packs/Microsoft.AspNetCore.App.Ref/3.1.0/ref/netcoreapp3.1/Microsoft.Extensions.Identity.Core.dll",
        stdlib_path = "@core_sdk//:core/shared/Microsoft.AspNetCore.App/3.1.0/Microsoft.Extensions.Identity.Core.dll",
        deps = [
            ":p0_microsoft.extensions.dependencyinjection.abstractions.dll",
            ":p0_microsoft.extensions.options.dll",
            ":p0_microsoft.extensions.logging.abstractions.dll",
        ]
    )
    core_stdlib(
        name = "p0_microsoft.extensions.identity.stores.dll",
        dotnet_context_data = context_data,
        ref = "@core_sdk//:core/packs/Microsoft.AspNetCore.App.Ref/3.1.0/ref/netcoreapp3.1/Microsoft.Extensions.Identity.Stores.dll",
        stdlib_path = "@core_sdk//:core/shared/Microsoft.AspNetCore.App/3.1.0/Microsoft.Extensions.Identity.Stores.dll",
        deps = [
            ":p0_microsoft.extensions.identity.core.dll",
        ]
    )
    core_stdlib(
        name = "p0_microsoft.extensions.localization.abstractions.dll",
        dotnet_context_data = context_data,
        ref = "@core_sdk//:core/packs/Microsoft.AspNetCore.App.Ref/3.1.0/ref/netcoreapp3.1/Microsoft.Extensions.Localization.Abstractions.dll",
        stdlib_path = "@core_sdk//:core/shared/Microsoft.AspNetCore.App/3.1.0/Microsoft.Extensions.Localization.Abstractions.dll",
        deps = [
        ]
    )
    core_stdlib(
        name = "p0_microsoft.extensions.localization.dll",
        dotnet_context_data = context_data,
        ref = "@core_sdk//:core/packs/Microsoft.AspNetCore.App.Ref/3.1.0/ref/netcoreapp3.1/Microsoft.Extensions.Localization.dll",
        stdlib_path = "@core_sdk//:core/shared/Microsoft.AspNetCore.App/3.1.0/Microsoft.Extensions.Localization.dll",
        deps = [
            ":p0_microsoft.extensions.localization.abstractions.dll",
            ":p0_microsoft.extensions.logging.abstractions.dll",
            ":p0_microsoft.extensions.options.dll",
            ":p0_microsoft.extensions.dependencyinjection.abstractions.dll",
        ]
    )
    core_stdlib(
        name = "p0_microsoft.extensions.logging.abstractions.dll",
        dotnet_context_data = context_data,
        ref = "@core_sdk//:core/packs/Microsoft.AspNetCore.App.Ref/3.1.0/ref/netcoreapp3.1/Microsoft.Extensions.Logging.Abstractions.dll",
        stdlib_path = "@core_sdk//:core/shared/Microsoft.AspNetCore.App/3.1.0/Microsoft.Extensions.Logging.Abstractions.dll",
        deps = [
        ]
    )
    core_stdlib(
        name = "p0_microsoft.extensions.logging.configuration.dll",
        dotnet_context_data = context_data,
        ref = "@core_sdk//:core/packs/Microsoft.AspNetCore.App.Ref/3.1.0/ref/netcoreapp3.1/Microsoft.Extensions.Logging.Configuration.dll",
        stdlib_path = "@core_sdk//:core/shared/Microsoft.AspNetCore.App/3.1.0/Microsoft.Extensions.Logging.Configuration.dll",
        deps = [
            ":p0_microsoft.extensions.logging.dll",
            ":p0_microsoft.extensions.configuration.abstractions.dll",
            ":p0_microsoft.extensions.dependencyinjection.abstractions.dll",
            ":p0_microsoft.extensions.options.configurationextensions.dll",
        ]
    )
    core_stdlib(
        name = "p0_microsoft.extensions.logging.console.dll",
        dotnet_context_data = context_data,
        ref = "@core_sdk//:core/packs/Microsoft.AspNetCore.App.Ref/3.1.0/ref/netcoreapp3.1/Microsoft.Extensions.Logging.Console.dll",
        stdlib_path = "@core_sdk//:core/shared/Microsoft.AspNetCore.App/3.1.0/Microsoft.Extensions.Logging.Console.dll",
        deps = [
            ":p0_microsoft.extensions.logging.dll",
            ":p0_microsoft.extensions.logging.abstractions.dll",
            ":p0_microsoft.extensions.options.dll",
        ]
    )
    core_stdlib(
        name = "p0_microsoft.extensions.logging.debug.dll",
        dotnet_context_data = context_data,
        ref = "@core_sdk//:core/packs/Microsoft.AspNetCore.App.Ref/3.1.0/ref/netcoreapp3.1/Microsoft.Extensions.Logging.Debug.dll",
        stdlib_path = "@core_sdk//:core/shared/Microsoft.AspNetCore.App/3.1.0/Microsoft.Extensions.Logging.Debug.dll",
        deps = [
            ":p0_microsoft.extensions.logging.dll",
            ":p0_microsoft.extensions.logging.abstractions.dll",
        ]
    )
    core_stdlib(
        name = "p0_microsoft.extensions.logging.dll",
        dotnet_context_data = context_data,
        ref = "@core_sdk//:core/packs/Microsoft.AspNetCore.App.Ref/3.1.0/ref/netcoreapp3.1/Microsoft.Extensions.Logging.dll",
        stdlib_path = "@core_sdk//:core/shared/Microsoft.AspNetCore.App/3.1.0/Microsoft.Extensions.Logging.dll",
        deps = [
            ":p0_microsoft.extensions.logging.abstractions.dll",
            ":p0_microsoft.extensions.dependencyinjection.abstractions.dll",
            ":p0_microsoft.extensions.options.dll",
        ]
    )
    core_stdlib(
        name = "p0_microsoft.extensions.logging.eventlog.dll",
        dotnet_context_data = context_data,
        ref = "@core_sdk//:core/packs/Microsoft.AspNetCore.App.Ref/3.1.0/ref/netcoreapp3.1/Microsoft.Extensions.Logging.EventLog.dll",
        stdlib_path = "@core_sdk//:core/shared/Microsoft.AspNetCore.App/3.1.0/Microsoft.Extensions.Logging.EventLog.dll",
        deps = [
            ":p0_microsoft.extensions.logging.dll",
            ":p0_microsoft.extensions.logging.abstractions.dll",
            ":p0_microsoft.extensions.options.dll",
        ]
    )
    core_stdlib(
        name = "p0_microsoft.extensions.logging.eventsource.dll",
        dotnet_context_data = context_data,
        ref = "@core_sdk//:core/packs/Microsoft.AspNetCore.App.Ref/3.1.0/ref/netcoreapp3.1/Microsoft.Extensions.Logging.EventSource.dll",
        stdlib_path = "@core_sdk//:core/shared/Microsoft.AspNetCore.App/3.1.0/Microsoft.Extensions.Logging.EventSource.dll",
        deps = [
            ":p0_microsoft.extensions.logging.dll",
            ":p0_microsoft.extensions.logging.abstractions.dll",
        ]
    )
    core_stdlib(
        name = "p0_microsoft.extensions.logging.tracesource.dll",
        dotnet_context_data = context_data,
        ref = "@core_sdk//:core/packs/Microsoft.AspNetCore.App.Ref/3.1.0/ref/netcoreapp3.1/Microsoft.Extensions.Logging.TraceSource.dll",
        stdlib_path = "@core_sdk//:core/shared/Microsoft.AspNetCore.App/3.1.0/Microsoft.Extensions.Logging.TraceSource.dll",
        deps = [
            ":p0_microsoft.extensions.logging.dll",
            ":p0_microsoft.extensions.logging.abstractions.dll",
        ]
    )
    core_stdlib(
        name = "p0_microsoft.extensions.objectpool.dll",
        dotnet_context_data = context_data,
        ref = "@core_sdk//:core/packs/Microsoft.AspNetCore.App.Ref/3.1.0/ref/netcoreapp3.1/Microsoft.Extensions.ObjectPool.dll",
        stdlib_path = "@core_sdk//:core/shared/Microsoft.AspNetCore.App/3.1.0/Microsoft.Extensions.ObjectPool.dll",
        deps = [
        ]
    )
    core_stdlib(
        name = "p0_microsoft.extensions.options.configurationextensions.dll",
        dotnet_context_data = context_data,
        ref = "@core_sdk//:core/packs/Microsoft.AspNetCore.App.Ref/3.1.0/ref/netcoreapp3.1/Microsoft.Extensions.Options.ConfigurationExtensions.dll",
        stdlib_path = "@core_sdk//:core/shared/Microsoft.AspNetCore.App/3.1.0/Microsoft.Extensions.Options.ConfigurationExtensions.dll",
        deps = [
            ":p0_microsoft.extensions.options.dll",
            ":p0_microsoft.extensions.configuration.abstractions.dll",
            ":p0_microsoft.extensions.primitives.dll",
            ":p0_microsoft.extensions.configuration.binder.dll",
            ":p0_microsoft.extensions.dependencyinjection.abstractions.dll",
        ]
    )
    core_stdlib(
        name = "p0_microsoft.extensions.options.dataannotations.dll",
        dotnet_context_data = context_data,
        ref = "@core_sdk//:core/packs/Microsoft.AspNetCore.App.Ref/3.1.0/ref/netcoreapp3.1/Microsoft.Extensions.Options.DataAnnotations.dll",
        stdlib_path = "@core_sdk//:core/shared/Microsoft.AspNetCore.App/3.1.0/Microsoft.Extensions.Options.DataAnnotations.dll",
        deps = [
            ":p0_microsoft.extensions.options.dll",
        ]
    )
    core_stdlib(
        name = "p0_microsoft.extensions.options.dll",
        dotnet_context_data = context_data,
        ref = "@core_sdk//:core/packs/Microsoft.AspNetCore.App.Ref/3.1.0/ref/netcoreapp3.1/Microsoft.Extensions.Options.dll",
        stdlib_path = "@core_sdk//:core/shared/Microsoft.AspNetCore.App/3.1.0/Microsoft.Extensions.Options.dll",
        deps = [
            ":p0_microsoft.extensions.primitives.dll",
            ":p0_microsoft.extensions.dependencyinjection.abstractions.dll",
        ]
    )
    core_stdlib(
        name = "p0_microsoft.extensions.primitives.dll",
        dotnet_context_data = context_data,
        ref = "@core_sdk//:core/packs/Microsoft.AspNetCore.App.Ref/3.1.0/ref/netcoreapp3.1/Microsoft.Extensions.Primitives.dll",
        stdlib_path = "@core_sdk//:core/shared/Microsoft.AspNetCore.App/3.1.0/Microsoft.Extensions.Primitives.dll",
        deps = [
        ]
    )
    core_stdlib(
        name = "p0_microsoft.extensions.webencoders.dll",
        dotnet_context_data = context_data,
        ref = "@core_sdk//:core/packs/Microsoft.AspNetCore.App.Ref/3.1.0/ref/netcoreapp3.1/Microsoft.Extensions.WebEncoders.dll",
        stdlib_path = "@core_sdk//:core/shared/Microsoft.AspNetCore.App/3.1.0/Microsoft.Extensions.WebEncoders.dll",
        deps = [
            ":p0_microsoft.extensions.dependencyinjection.abstractions.dll",
        ]
    )
    core_stdlib(
        name = "p0_microsoft.jsinterop.dll",
        dotnet_context_data = context_data,
        ref = "@core_sdk//:core/packs/Microsoft.AspNetCore.App.Ref/3.1.0/ref/netcoreapp3.1/Microsoft.JSInterop.dll",
        stdlib_path = "@core_sdk//:core/shared/Microsoft.AspNetCore.App/3.1.0/Microsoft.JSInterop.dll",
        deps = [
        ]
    )
    core_stdlib(
        name = "p0_microsoft.net.http.headers.dll",
        dotnet_context_data = context_data,
        ref = "@core_sdk//:core/packs/Microsoft.AspNetCore.App.Ref/3.1.0/ref/netcoreapp3.1/Microsoft.Net.Http.Headers.dll",
        stdlib_path = "@core_sdk//:core/shared/Microsoft.AspNetCore.App/3.1.0/Microsoft.Net.Http.Headers.dll",
        deps = [
            ":p0_microsoft.extensions.primitives.dll",
        ]
    )
    core_stdlib(
        name = "p0_microsoft.win32.registry.dll",
        dotnet_context_data = context_data,
        ref = "@core_sdk//:core/packs/Microsoft.AspNetCore.App.Ref/3.1.0/ref/netcoreapp3.1/Microsoft.Win32.Registry.dll",
        stdlib_path = "@core_sdk//:core/shared/Microsoft.NETCore.App/3.1.0/Microsoft.Win32.Registry.dll",
        deps = [
            ":p0_system.security.accesscontrol.dll",
            ":p0_system.security.principal.windows.dll",
        ]
    )
    core_stdlib(
        name = "p0_system.diagnostics.eventlog.dll",
        dotnet_context_data = context_data,
        ref = "@core_sdk//:core/packs/Microsoft.AspNetCore.App.Ref/3.1.0/ref/netcoreapp3.1/System.Diagnostics.EventLog.dll",
        stdlib_path = "@core_sdk//:core/shared/Microsoft.AspNetCore.App/3.1.0/System.Diagnostics.EventLog.dll",
        deps = [
            ":p0_system.security.principal.windows.dll",
        ]
    )
    core_stdlib(
        name = "p0_system.io.pipelines.dll",
        dotnet_context_data = context_data,
        ref = "@core_sdk//:core/packs/Microsoft.AspNetCore.App.Ref/3.1.0/ref/netcoreapp3.1/System.IO.Pipelines.dll",
        stdlib_path = "@core_sdk//:core/shared/Microsoft.AspNetCore.App/3.1.0/System.IO.Pipelines.dll",
        deps = [
        ]
    )
    core_stdlib(
        name = "p0_system.security.accesscontrol.dll",
        dotnet_context_data = context_data,
        ref = "@core_sdk//:core/packs/Microsoft.AspNetCore.App.Ref/3.1.0/ref/netcoreapp3.1/System.Security.AccessControl.dll",
        stdlib_path = "@core_sdk//:core/shared/Microsoft.NETCore.App/3.1.0/System.Security.AccessControl.dll",
        deps = [
            ":p0_system.security.principal.windows.dll",
        ]
    )
    core_stdlib(
        name = "p0_system.security.cryptography.cng.dll",
        dotnet_context_data = context_data,
        ref = "@core_sdk//:core/packs/Microsoft.AspNetCore.App.Ref/3.1.0/ref/netcoreapp3.1/System.Security.Cryptography.Cng.dll",
        stdlib_path = "@core_sdk//:core/shared/Microsoft.NETCore.App/3.1.0/System.Security.Cryptography.Cng.dll",
        deps = [
        ]
    )
    core_stdlib(
        name = "p0_system.security.cryptography.xml.dll",
        dotnet_context_data = context_data,
        ref = "@core_sdk//:core/packs/Microsoft.AspNetCore.App.Ref/3.1.0/ref/netcoreapp3.1/System.Security.Cryptography.Xml.dll",
        stdlib_path = "@core_sdk//:core/shared/Microsoft.AspNetCore.App/3.1.0/System.Security.Cryptography.Xml.dll",
        deps = [
            ":p0_system.security.permissions.dll",
        ]
    )
    core_stdlib(
        name = "p0_system.security.permissions.dll",
        dotnet_context_data = context_data,
        ref = "@core_sdk//:core/packs/Microsoft.AspNetCore.App.Ref/3.1.0/ref/netcoreapp3.1/System.Security.Permissions.dll",
        stdlib_path = "@core_sdk//:core/shared/Microsoft.AspNetCore.App/3.1.0/System.Security.Permissions.dll",
        deps = [
            ":p0_system.windows.extensions.dll",
            ":p0_system.security.accesscontrol.dll",
        ]
    )
    core_stdlib(
        name = "p0_system.security.principal.windows.dll",
        dotnet_context_data = context_data,
        ref = "@core_sdk//:core/packs/Microsoft.AspNetCore.App.Ref/3.1.0/ref/netcoreapp3.1/System.Security.Principal.Windows.dll",
        stdlib_path = "@core_sdk//:core/shared/Microsoft.NETCore.App/3.1.0/System.Security.Principal.Windows.dll",
        deps = [
        ]
    )
    core_stdlib(
        name = "p0_system.windows.extensions.dll",
        dotnet_context_data = context_data,
        ref = "@core_sdk//:core/packs/Microsoft.AspNetCore.App.Ref/3.1.0/ref/netcoreapp3.1/System.Windows.Extensions.dll",
        stdlib_path = "@core_sdk//:core/shared/Microsoft.AspNetCore.App/3.1.0/System.Windows.Extensions.dll",
        deps = [
        ]
    )
    core_libraryset(
        name = "libraryset",
        dotnet_context_data = context_data,
        deps = [
            ":p1_microsoft.csharp.dll",
            ":p1_microsoft.visualbasic.core.dll",
            ":p1_microsoft.visualbasic.dll",
            ":p1_microsoft.win32.primitives.dll",
            ":p1_mscorlib.dll",
            ":p1_netstandard.dll",
            ":p1_system.appcontext.dll",
            ":p1_system.buffers.dll",
            ":p1_system.collections.concurrent.dll",
            ":p1_system.collections.dll",
            ":p1_system.collections.immutable.dll",
            ":p1_system.collections.nongeneric.dll",
            ":p1_system.collections.specialized.dll",
            ":p1_system.componentmodel.annotations.dll",
            ":p1_system.componentmodel.dataannotations.dll",
            ":p1_system.componentmodel.dll",
            ":p1_system.componentmodel.eventbasedasync.dll",
            ":p1_system.componentmodel.primitives.dll",
            ":p1_system.componentmodel.typeconverter.dll",
            ":p1_system.configuration.dll",
            ":p1_system.console.dll",
            ":p1_system.core.dll",
            ":p1_system.data.common.dll",
            ":p1_system.data.datasetextensions.dll",
            ":p1_system.data.dll",
            ":p1_system.diagnostics.contracts.dll",
            ":p1_system.diagnostics.debug.dll",
            ":p1_system.diagnostics.diagnosticsource.dll",
            ":p1_system.diagnostics.fileversioninfo.dll",
            ":p1_system.diagnostics.process.dll",
            ":p1_system.diagnostics.stacktrace.dll",
            ":p1_system.diagnostics.textwritertracelistener.dll",
            ":p1_system.diagnostics.tools.dll",
            ":p1_system.diagnostics.tracesource.dll",
            ":p1_system.diagnostics.tracing.dll",
            ":p1_system.dll",
            ":p1_system.drawing.dll",
            ":p1_system.drawing.primitives.dll",
            ":p1_system.dynamic.runtime.dll",
            ":p1_system.globalization.calendars.dll",
            ":p1_system.globalization.dll",
            ":p1_system.globalization.extensions.dll",
            ":p1_system.io.compression.brotli.dll",
            ":p1_system.io.compression.dll",
            ":p1_system.io.compression.filesystem.dll",
            ":p1_system.io.compression.zipfile.dll",
            ":p1_system.io.dll",
            ":p1_system.io.filesystem.dll",
            ":p1_system.io.filesystem.driveinfo.dll",
            ":p1_system.io.filesystem.primitives.dll",
            ":p1_system.io.filesystem.watcher.dll",
            ":p1_system.io.isolatedstorage.dll",
            ":p1_system.io.memorymappedfiles.dll",
            ":p1_system.io.pipes.dll",
            ":p1_system.io.unmanagedmemorystream.dll",
            ":p1_system.linq.dll",
            ":p1_system.linq.expressions.dll",
            ":p1_system.linq.parallel.dll",
            ":p1_system.linq.queryable.dll",
            ":p1_system.memory.dll",
            ":p1_system.net.dll",
            ":p1_system.net.http.dll",
            ":p1_system.net.httplistener.dll",
            ":p1_system.net.mail.dll",
            ":p1_system.net.nameresolution.dll",
            ":p1_system.net.networkinformation.dll",
            ":p1_system.net.ping.dll",
            ":p1_system.net.primitives.dll",
            ":p1_system.net.requests.dll",
            ":p1_system.net.security.dll",
            ":p1_system.net.servicepoint.dll",
            ":p1_system.net.sockets.dll",
            ":p1_system.net.webclient.dll",
            ":p1_system.net.webheadercollection.dll",
            ":p1_system.net.webproxy.dll",
            ":p1_system.net.websockets.client.dll",
            ":p1_system.net.websockets.dll",
            ":p1_system.numerics.dll",
            ":p1_system.numerics.vectors.dll",
            ":p1_system.objectmodel.dll",
            ":p1_system.reflection.dispatchproxy.dll",
            ":p1_system.reflection.dll",
            ":p1_system.reflection.emit.dll",
            ":p1_system.reflection.emit.ilgeneration.dll",
            ":p1_system.reflection.emit.lightweight.dll",
            ":p1_system.reflection.extensions.dll",
            ":p1_system.reflection.metadata.dll",
            ":p1_system.reflection.primitives.dll",
            ":p1_system.reflection.typeextensions.dll",
            ":p1_system.resources.reader.dll",
            ":p1_system.resources.resourcemanager.dll",
            ":p1_system.resources.writer.dll",
            ":p1_system.runtime.compilerservices.unsafe.dll",
            ":p1_system.runtime.compilerservices.visualc.dll",
            ":p1_system.runtime.dll",
            ":p1_system.runtime.extensions.dll",
            ":p1_system.runtime.handles.dll",
            ":p1_system.runtime.interopservices.dll",
            ":p1_system.runtime.interopservices.runtimeinformation.dll",
            ":p1_system.runtime.interopservices.windowsruntime.dll",
            ":p1_system.runtime.intrinsics.dll",
            ":p1_system.runtime.loader.dll",
            ":p1_system.runtime.numerics.dll",
            ":p1_system.runtime.serialization.dll",
            ":p1_system.runtime.serialization.formatters.dll",
            ":p1_system.runtime.serialization.json.dll",
            ":p1_system.runtime.serialization.primitives.dll",
            ":p1_system.runtime.serialization.xml.dll",
            ":p1_system.security.claims.dll",
            ":p1_system.security.cryptography.algorithms.dll",
            ":p1_system.security.cryptography.csp.dll",
            ":p1_system.security.cryptography.encoding.dll",
            ":p1_system.security.cryptography.primitives.dll",
            ":p1_system.security.cryptography.x509certificates.dll",
            ":p1_system.security.dll",
            ":p1_system.security.principal.dll",
            ":p1_system.security.securestring.dll",
            ":p1_system.servicemodel.web.dll",
            ":p1_system.serviceprocess.dll",
            ":p1_system.text.encoding.codepages.dll",
            ":p1_system.text.encoding.dll",
            ":p1_system.text.encoding.extensions.dll",
            ":p1_system.text.encodings.web.dll",
            ":p1_system.text.json.dll",
            ":p1_system.text.regularexpressions.dll",
            ":p1_system.threading.channels.dll",
            ":p1_system.threading.dll",
            ":p1_system.threading.overlapped.dll",
            ":p1_system.threading.tasks.dataflow.dll",
            ":p1_system.threading.tasks.dll",
            ":p1_system.threading.tasks.extensions.dll",
            ":p1_system.threading.tasks.parallel.dll",
            ":p1_system.threading.thread.dll",
            ":p1_system.threading.threadpool.dll",
            ":p1_system.threading.timer.dll",
            ":p1_system.transactions.dll",
            ":p1_system.transactions.local.dll",
            ":p1_system.valuetuple.dll",
            ":p1_system.web.dll",
            ":p1_system.web.httputility.dll",
            ":p1_system.windows.dll",
            ":p1_system.xml.dll",
            ":p1_system.xml.linq.dll",
            ":p1_system.xml.readerwriter.dll",
            ":p1_system.xml.serialization.dll",
            ":p1_system.xml.xdocument.dll",
            ":p1_system.xml.xmldocument.dll",
            ":p1_system.xml.xmlserializer.dll",
            ":p1_system.xml.xpath.dll",
            ":p1_system.xml.xpath.xdocument.dll",
            ":p1_windowsbase.dll",
        ],
    )
    core_stdlib(
        name = "p1_microsoft.csharp.dll",
        dotnet_context_data = context_data,
        ref = "@core_sdk//:core/packs/Microsoft.NETCore.App.Ref/3.1.0/ref/netcoreapp3.1/Microsoft.CSharp.dll",
        stdlib_path = "@core_sdk//:core/shared/Microsoft.NETCore.App/3.1.0/Microsoft.CSharp.dll",
        deps = [
            ":p1_netstandard.dll",
        ]
    )
    core_stdlib(
        name = "p1_microsoft.visualbasic.core.dll",
        dotnet_context_data = context_data,
        ref = "@core_sdk//:core/packs/Microsoft.NETCore.App.Ref/3.1.0/ref/netcoreapp3.1/Microsoft.VisualBasic.Core.dll",
        stdlib_path = "@core_sdk//:core/shared/Microsoft.NETCore.App/3.1.0/Microsoft.VisualBasic.Core.dll",
        deps = [
            ":p1_system.runtime.dll",
            ":p1_system.runtime.interopservices.dll",
            ":p1_system.io.filesystem.driveinfo.dll",
            ":p1_system.io.filesystem.dll",
            ":p1_system.runtime.extensions.dll",
            ":p1_system.diagnostics.debug.dll",
        ]
    )
    core_stdlib(
        name = "p1_microsoft.visualbasic.dll",
        dotnet_context_data = context_data,
        ref = "@core_sdk//:core/packs/Microsoft.NETCore.App.Ref/3.1.0/ref/netcoreapp3.1/Microsoft.VisualBasic.dll",
        stdlib_path = "@core_sdk//:core/shared/Microsoft.NETCore.App/3.1.0/Microsoft.VisualBasic.dll",
        deps = [
            ":p1_system.runtime.dll",
            ":p1_microsoft.visualbasic.core.dll",
        ]
    )
    core_stdlib(
        name = "p1_microsoft.win32.primitives.dll",
        dotnet_context_data = context_data,
        ref = "@core_sdk//:core/packs/Microsoft.NETCore.App.Ref/3.1.0/ref/netcoreapp3.1/Microsoft.Win32.Primitives.dll",
        stdlib_path = "@core_sdk//:core/shared/Microsoft.NETCore.App/3.1.0/Microsoft.Win32.Primitives.dll",
        deps = [
            ":p1_system.runtime.dll",
        ]
    )
    core_stdlib(
        name = "p1_mscorlib.dll",
        dotnet_context_data = context_data,
        ref = "@core_sdk//:core/packs/Microsoft.NETCore.App.Ref/3.1.0/ref/netcoreapp3.1/mscorlib.dll",
        stdlib_path = "@core_sdk//:core/shared/Microsoft.NETCore.App/3.1.0/mscorlib.dll",
        deps = [
            ":p1_system.runtime.dll",
            ":p1_system.runtime.extensions.dll",
            ":p1_system.collections.dll",
            ":p1_system.collections.nongeneric.dll",
            ":p1_system.collections.concurrent.dll",
            ":p1_system.objectmodel.dll",
            ":p1_system.console.dll",
            ":p1_system.runtime.interopservices.dll",
            ":p1_system.diagnostics.tools.dll",
            ":p1_system.diagnostics.contracts.dll",
            ":p1_system.diagnostics.debug.dll",
            ":p1_system.diagnostics.stacktrace.dll",
            ":p1_system.diagnostics.tracing.dll",
            ":p1_system.io.filesystem.dll",
            ":p1_system.io.filesystem.driveinfo.dll",
            ":p1_system.io.isolatedstorage.dll",
            ":p1_system.componentmodel.dll",
            ":p1_system.threading.thread.dll",
            ":p1_system.threading.tasks.dll",
            ":p1_system.reflection.emit.dll",
            ":p1_system.reflection.emit.ilgeneration.dll",
            ":p1_system.reflection.emit.lightweight.dll",
            ":p1_system.reflection.primitives.dll",
            ":p1_system.resources.resourcemanager.dll",
            ":p1_system.resources.writer.dll",
            ":p1_system.runtime.compilerservices.visualc.dll",
            ":p1_system.runtime.interopservices.runtimeinformation.dll",
            ":p1_system.runtime.interopservices.windowsruntime.dll",
            ":p1_system.runtime.serialization.formatters.dll",
            ":p1_system.security.claims.dll",
            ":p1_system.security.cryptography.algorithms.dll",
            ":p1_system.security.cryptography.primitives.dll",
            ":p1_system.security.cryptography.csp.dll",
            ":p1_system.security.cryptography.encoding.dll",
            ":p1_system.security.cryptography.x509certificates.dll",
            ":p1_system.security.principal.dll",
            ":p1_system.text.encoding.extensions.dll",
            ":p1_system.threading.dll",
            ":p1_system.threading.overlapped.dll",
            ":p1_system.threading.threadpool.dll",
            ":p1_system.threading.tasks.parallel.dll",
            ":p1_system.threading.timer.dll",
        ]
    )
    core_stdlib(
        name = "p1_netstandard.dll",
        dotnet_context_data = context_data,
        ref = "@core_sdk//:core/packs/Microsoft.NETCore.App.Ref/3.1.0/ref/netcoreapp3.1/netstandard.dll",
        stdlib_path = "@core_sdk//:core/shared/Microsoft.NETCore.App/3.1.0/netstandard.dll",
        deps = [
            ":p1_system.runtime.dll",
            ":p1_system.io.memorymappedfiles.dll",
            ":p1_system.io.pipes.dll",
            ":p1_system.diagnostics.process.dll",
            ":p1_system.security.cryptography.x509certificates.dll",
            ":p1_system.runtime.extensions.dll",
            ":p1_system.memory.dll",
            ":p1_system.buffers.dll",
            ":p1_system.diagnostics.tools.dll",
            ":p1_system.collections.dll",
            ":p1_system.collections.nongeneric.dll",
            ":p1_system.collections.concurrent.dll",
            ":p1_system.objectmodel.dll",
            ":p1_system.collections.specialized.dll",
            ":p1_system.componentmodel.typeconverter.dll",
            ":p1_system.componentmodel.eventbasedasync.dll",
            ":p1_system.componentmodel.primitives.dll",
            ":p1_system.componentmodel.dll",
            ":p1_microsoft.win32.primitives.dll",
            ":p1_system.console.dll",
            ":p1_system.data.common.dll",
            ":p1_system.runtime.interopservices.dll",
            ":p1_system.diagnostics.tracesource.dll",
            ":p1_system.diagnostics.contracts.dll",
            ":p1_system.diagnostics.debug.dll",
            ":p1_system.diagnostics.textwritertracelistener.dll",
            ":p1_system.diagnostics.fileversioninfo.dll",
            ":p1_system.diagnostics.stacktrace.dll",
            ":p1_system.diagnostics.tracing.dll",
            ":p1_system.drawing.primitives.dll",
            ":p1_system.linq.expressions.dll",
            ":p1_system.io.compression.brotli.dll",
            ":p1_system.io.compression.dll",
            ":p1_system.io.compression.zipfile.dll",
            ":p1_system.io.filesystem.dll",
            ":p1_system.io.filesystem.driveinfo.dll",
            ":p1_system.io.filesystem.watcher.dll",
            ":p1_system.io.isolatedstorage.dll",
            ":p1_system.linq.dll",
            ":p1_system.linq.queryable.dll",
            ":p1_system.linq.parallel.dll",
            ":p1_system.threading.thread.dll",
            ":p1_system.net.requests.dll",
            ":p1_system.net.primitives.dll",
            ":p1_system.net.httplistener.dll",
            ":p1_system.net.servicepoint.dll",
            ":p1_system.net.nameresolution.dll",
            ":p1_system.net.webclient.dll",
            ":p1_system.net.http.dll",
            ":p1_system.net.webheadercollection.dll",
            ":p1_system.net.webproxy.dll",
            ":p1_system.net.mail.dll",
            ":p1_system.net.networkinformation.dll",
            ":p1_system.net.ping.dll",
            ":p1_system.net.security.dll",
            ":p1_system.net.sockets.dll",
            ":p1_system.net.websockets.client.dll",
            ":p1_system.net.websockets.dll",
            ":p1_system.runtime.numerics.dll",
            ":p1_system.numerics.vectors.dll",
            ":p1_system.threading.tasks.dll",
            ":p1_system.reflection.dispatchproxy.dll",
            ":p1_system.reflection.emit.dll",
            ":p1_system.reflection.emit.ilgeneration.dll",
            ":p1_system.reflection.emit.lightweight.dll",
            ":p1_system.reflection.primitives.dll",
            ":p1_system.resources.resourcemanager.dll",
            ":p1_system.resources.writer.dll",
            ":p1_system.runtime.compilerservices.visualc.dll",
            ":p1_system.runtime.interopservices.runtimeinformation.dll",
            ":p1_system.runtime.serialization.primitives.dll",
            ":p1_system.runtime.serialization.xml.dll",
            ":p1_system.runtime.serialization.json.dll",
            ":p1_system.runtime.serialization.formatters.dll",
            ":p1_system.security.claims.dll",
            ":p1_system.security.cryptography.algorithms.dll",
            ":p1_system.security.cryptography.csp.dll",
            ":p1_system.security.cryptography.encoding.dll",
            ":p1_system.security.cryptography.primitives.dll",
            ":p1_system.security.principal.dll",
            ":p1_system.text.encoding.extensions.dll",
            ":p1_system.text.regularexpressions.dll",
            ":p1_system.threading.dll",
            ":p1_system.threading.overlapped.dll",
            ":p1_system.threading.threadpool.dll",
            ":p1_system.threading.tasks.parallel.dll",
            ":p1_system.threading.timer.dll",
            ":p1_system.transactions.local.dll",
            ":p1_system.web.httputility.dll",
            ":p1_system.xml.readerwriter.dll",
            ":p1_system.xml.xdocument.dll",
            ":p1_system.xml.xmlserializer.dll",
            ":p1_system.xml.xpath.xdocument.dll",
            ":p1_system.xml.xpath.dll",
        ]
    )
    core_stdlib(
        name = "p1_system.appcontext.dll",
        dotnet_context_data = context_data,
        ref = "@core_sdk//:core/packs/Microsoft.NETCore.App.Ref/3.1.0/ref/netcoreapp3.1/System.AppContext.dll",
        stdlib_path = "@core_sdk//:core/shared/Microsoft.NETCore.App/3.1.0/System.AppContext.dll",
        deps = [
            ":p1_system.runtime.dll",
        ]
    )
    core_stdlib(
        name = "p1_system.buffers.dll",
        dotnet_context_data = context_data,
        ref = "@core_sdk//:core/packs/Microsoft.NETCore.App.Ref/3.1.0/ref/netcoreapp3.1/System.Buffers.dll",
        stdlib_path = "@core_sdk//:core/shared/Microsoft.NETCore.App/3.1.0/System.Buffers.dll",
        deps = [
            ":p1_system.runtime.dll",
        ]
    )
    core_stdlib(
        name = "p1_system.collections.concurrent.dll",
        dotnet_context_data = context_data,
        ref = "@core_sdk//:core/packs/Microsoft.NETCore.App.Ref/3.1.0/ref/netcoreapp3.1/System.Collections.Concurrent.dll",
        stdlib_path = "@core_sdk//:core/shared/Microsoft.NETCore.App/3.1.0/System.Collections.Concurrent.dll",
        deps = [
            ":p1_system.runtime.dll",
        ]
    )
    core_stdlib(
        name = "p1_system.collections.dll",
        dotnet_context_data = context_data,
        ref = "@core_sdk//:core/packs/Microsoft.NETCore.App.Ref/3.1.0/ref/netcoreapp3.1/System.Collections.dll",
        stdlib_path = "@core_sdk//:core/shared/Microsoft.NETCore.App/3.1.0/System.Collections.dll",
        deps = [
            ":p1_system.runtime.dll",
        ]
    )
    core_stdlib(
        name = "p1_system.collections.immutable.dll",
        dotnet_context_data = context_data,
        ref = "@core_sdk//:core/packs/Microsoft.NETCore.App.Ref/3.1.0/ref/netcoreapp3.1/System.Collections.Immutable.dll",
        stdlib_path = "@core_sdk//:core/shared/Microsoft.NETCore.App/3.1.0/System.Collections.Immutable.dll",
        deps = [
            ":p1_system.runtime.dll",
            ":p1_system.runtime.interopservices.dll",
            ":p1_system.collections.dll",
        ]
    )
    core_stdlib(
        name = "p1_system.collections.nongeneric.dll",
        dotnet_context_data = context_data,
        ref = "@core_sdk//:core/packs/Microsoft.NETCore.App.Ref/3.1.0/ref/netcoreapp3.1/System.Collections.NonGeneric.dll",
        stdlib_path = "@core_sdk//:core/shared/Microsoft.NETCore.App/3.1.0/System.Collections.NonGeneric.dll",
        deps = [
            ":p1_system.runtime.dll",
            ":p1_system.runtime.extensions.dll",
        ]
    )
    core_stdlib(
        name = "p1_system.collections.specialized.dll",
        dotnet_context_data = context_data,
        ref = "@core_sdk//:core/packs/Microsoft.NETCore.App.Ref/3.1.0/ref/netcoreapp3.1/System.Collections.Specialized.dll",
        stdlib_path = "@core_sdk//:core/shared/Microsoft.NETCore.App/3.1.0/System.Collections.Specialized.dll",
        deps = [
            ":p1_system.runtime.dll",
            ":p1_system.runtime.extensions.dll",
        ]
    )
    core_stdlib(
        name = "p1_system.componentmodel.annotations.dll",
        dotnet_context_data = context_data,
        ref = "@core_sdk//:core/packs/Microsoft.NETCore.App.Ref/3.1.0/ref/netcoreapp3.1/System.ComponentModel.Annotations.dll",
        stdlib_path = "@core_sdk//:core/shared/Microsoft.NETCore.App/3.1.0/System.ComponentModel.Annotations.dll",
        deps = [
            ":p1_netstandard.dll",
        ]
    )
    core_stdlib(
        name = "p1_system.componentmodel.dataannotations.dll",
        dotnet_context_data = context_data,
        ref = "@core_sdk//:core/packs/Microsoft.NETCore.App.Ref/3.1.0/ref/netcoreapp3.1/System.ComponentModel.DataAnnotations.dll",
        stdlib_path = "@core_sdk//:core/shared/Microsoft.NETCore.App/3.1.0/System.ComponentModel.DataAnnotations.dll",
        deps = [
            ":p1_system.runtime.dll",
            ":p1_system.componentmodel.annotations.dll",
        ]
    )
    core_stdlib(
        name = "p1_system.componentmodel.dll",
        dotnet_context_data = context_data,
        ref = "@core_sdk//:core/packs/Microsoft.NETCore.App.Ref/3.1.0/ref/netcoreapp3.1/System.ComponentModel.dll",
        stdlib_path = "@core_sdk//:core/shared/Microsoft.NETCore.App/3.1.0/System.ComponentModel.dll",
        deps = [
            ":p1_system.runtime.dll",
        ]
    )
    core_stdlib(
        name = "p1_system.componentmodel.eventbasedasync.dll",
        dotnet_context_data = context_data,
        ref = "@core_sdk//:core/packs/Microsoft.NETCore.App.Ref/3.1.0/ref/netcoreapp3.1/System.ComponentModel.EventBasedAsync.dll",
        stdlib_path = "@core_sdk//:core/shared/Microsoft.NETCore.App/3.1.0/System.ComponentModel.EventBasedAsync.dll",
        deps = [
            ":p1_system.runtime.dll",
            ":p1_system.threading.dll",
            ":p1_system.componentmodel.primitives.dll",
            ":p1_system.componentmodel.dll",
        ]
    )
    core_stdlib(
        name = "p1_system.componentmodel.primitives.dll",
        dotnet_context_data = context_data,
        ref = "@core_sdk//:core/packs/Microsoft.NETCore.App.Ref/3.1.0/ref/netcoreapp3.1/System.ComponentModel.Primitives.dll",
        stdlib_path = "@core_sdk//:core/shared/Microsoft.NETCore.App/3.1.0/System.ComponentModel.Primitives.dll",
        deps = [
            ":p1_system.runtime.dll",
            ":p1_system.collections.nongeneric.dll",
            ":p1_system.componentmodel.dll",
        ]
    )
    core_stdlib(
        name = "p1_system.componentmodel.typeconverter.dll",
        dotnet_context_data = context_data,
        ref = "@core_sdk//:core/packs/Microsoft.NETCore.App.Ref/3.1.0/ref/netcoreapp3.1/System.ComponentModel.TypeConverter.dll",
        stdlib_path = "@core_sdk//:core/shared/Microsoft.NETCore.App/3.1.0/System.ComponentModel.TypeConverter.dll",
        deps = [
            ":p1_system.runtime.dll",
            ":p1_system.componentmodel.primitives.dll",
            ":p1_system.componentmodel.dll",
            ":p1_system.resources.resourcemanager.dll",
            ":p1_system.objectmodel.dll",
            ":p1_system.runtime.extensions.dll",
            ":p1_system.collections.nongeneric.dll",
            ":p1_system.resources.writer.dll",
        ]
    )
    core_stdlib(
        name = "p1_system.configuration.dll",
        dotnet_context_data = context_data,
        ref = "@core_sdk//:core/packs/Microsoft.NETCore.App.Ref/3.1.0/ref/netcoreapp3.1/System.Configuration.dll",
        stdlib_path = "@core_sdk//:core/shared/Microsoft.NETCore.App/3.1.0/System.Configuration.dll",
        deps = [
            ":p1_system.runtime.dll",
        ]
    )
    core_stdlib(
        name = "p1_system.console.dll",
        dotnet_context_data = context_data,
        ref = "@core_sdk//:core/packs/Microsoft.NETCore.App.Ref/3.1.0/ref/netcoreapp3.1/System.Console.dll",
        stdlib_path = "@core_sdk//:core/shared/Microsoft.NETCore.App/3.1.0/System.Console.dll",
        deps = [
            ":p1_system.runtime.dll",
            ":p1_system.runtime.extensions.dll",
        ]
    )
    core_stdlib(
        name = "p1_system.core.dll",
        dotnet_context_data = context_data,
        ref = "@core_sdk//:core/packs/Microsoft.NETCore.App.Ref/3.1.0/ref/netcoreapp3.1/System.Core.dll",
        stdlib_path = "@core_sdk//:core/shared/Microsoft.NETCore.App/3.1.0/System.Core.dll",
        deps = [
            ":p1_system.runtime.dll",
            ":p1_system.io.memorymappedfiles.dll",
            ":p1_system.io.pipes.dll",
            ":p1_system.collections.dll",
            ":p1_system.linq.expressions.dll",
            ":p1_system.linq.dll",
            ":p1_system.linq.queryable.dll",
            ":p1_system.linq.parallel.dll",
            ":p1_system.runtime.interopservices.dll",
            ":p1_system.security.cryptography.algorithms.dll",
            ":p1_system.security.cryptography.csp.dll",
            ":p1_system.security.cryptography.x509certificates.dll",
            ":p1_system.threading.dll",
            ":p1_system.threading.tasks.dll",
        ]
    )
    core_stdlib(
        name = "p1_system.data.common.dll",
        dotnet_context_data = context_data,
        ref = "@core_sdk//:core/packs/Microsoft.NETCore.App.Ref/3.1.0/ref/netcoreapp3.1/System.Data.Common.dll",
        stdlib_path = "@core_sdk//:core/shared/Microsoft.NETCore.App/3.1.0/System.Data.Common.dll",
        deps = [
            ":p1_system.runtime.dll",
            ":p1_system.xml.readerwriter.dll",
            ":p1_system.runtime.extensions.dll",
            ":p1_system.componentmodel.typeconverter.dll",
            ":p1_system.objectmodel.dll",
            ":p1_system.componentmodel.primitives.dll",
            ":p1_system.componentmodel.dll",
            ":p1_system.transactions.local.dll",
        ]
    )
    core_stdlib(
        name = "p1_system.data.datasetextensions.dll",
        dotnet_context_data = context_data,
        ref = "@core_sdk//:core/packs/Microsoft.NETCore.App.Ref/3.1.0/ref/netcoreapp3.1/System.Data.DataSetExtensions.dll",
        stdlib_path = "@core_sdk//:core/shared/Microsoft.NETCore.App/3.1.0/System.Data.DataSetExtensions.dll",
        deps = [
            ":p1_system.runtime.dll",
            ":p1_system.data.common.dll",
        ]
    )
    core_stdlib(
        name = "p1_system.data.dll",
        dotnet_context_data = context_data,
        ref = "@core_sdk//:core/packs/Microsoft.NETCore.App.Ref/3.1.0/ref/netcoreapp3.1/System.Data.dll",
        stdlib_path = "@core_sdk//:core/shared/Microsoft.NETCore.App/3.1.0/System.Data.dll",
        deps = [
            ":p1_system.runtime.dll",
            ":p1_system.data.common.dll",
        ]
    )
    core_stdlib(
        name = "p1_system.diagnostics.contracts.dll",
        dotnet_context_data = context_data,
        ref = "@core_sdk//:core/packs/Microsoft.NETCore.App.Ref/3.1.0/ref/netcoreapp3.1/System.Diagnostics.Contracts.dll",
        stdlib_path = "@core_sdk//:core/shared/Microsoft.NETCore.App/3.1.0/System.Diagnostics.Contracts.dll",
        deps = [
            ":p1_system.runtime.dll",
        ]
    )
    core_stdlib(
        name = "p1_system.diagnostics.debug.dll",
        dotnet_context_data = context_data,
        ref = "@core_sdk//:core/packs/Microsoft.NETCore.App.Ref/3.1.0/ref/netcoreapp3.1/System.Diagnostics.Debug.dll",
        stdlib_path = "@core_sdk//:core/shared/Microsoft.NETCore.App/3.1.0/System.Diagnostics.Debug.dll",
        deps = [
            ":p1_system.runtime.dll",
        ]
    )
    core_stdlib(
        name = "p1_system.diagnostics.diagnosticsource.dll",
        dotnet_context_data = context_data,
        ref = "@core_sdk//:core/packs/Microsoft.NETCore.App.Ref/3.1.0/ref/netcoreapp3.1/System.Diagnostics.DiagnosticSource.dll",
        stdlib_path = "@core_sdk//:core/shared/Microsoft.NETCore.App/3.1.0/System.Diagnostics.DiagnosticSource.dll",
        deps = [
            ":p1_netstandard.dll",
            ":p1_system.memory.dll",
        ]
    )
    core_stdlib(
        name = "p1_system.diagnostics.fileversioninfo.dll",
        dotnet_context_data = context_data,
        ref = "@core_sdk//:core/packs/Microsoft.NETCore.App.Ref/3.1.0/ref/netcoreapp3.1/System.Diagnostics.FileVersionInfo.dll",
        stdlib_path = "@core_sdk//:core/shared/Microsoft.NETCore.App/3.1.0/System.Diagnostics.FileVersionInfo.dll",
        deps = [
            ":p1_system.runtime.dll",
        ]
    )
    core_stdlib(
        name = "p1_system.diagnostics.process.dll",
        dotnet_context_data = context_data,
        ref = "@core_sdk//:core/packs/Microsoft.NETCore.App.Ref/3.1.0/ref/netcoreapp3.1/System.Diagnostics.Process.dll",
        stdlib_path = "@core_sdk//:core/shared/Microsoft.NETCore.App/3.1.0/System.Diagnostics.Process.dll",
        deps = [
            ":p1_system.runtime.dll",
            ":p1_system.runtime.interopservices.dll",
            ":p1_system.componentmodel.primitives.dll",
            ":p1_system.runtime.extensions.dll",
            ":p1_system.diagnostics.fileversioninfo.dll",
            ":p1_system.collections.nongeneric.dll",
            ":p1_system.collections.specialized.dll",
        ]
    )
    core_stdlib(
        name = "p1_system.diagnostics.stacktrace.dll",
        dotnet_context_data = context_data,
        ref = "@core_sdk//:core/packs/Microsoft.NETCore.App.Ref/3.1.0/ref/netcoreapp3.1/System.Diagnostics.StackTrace.dll",
        stdlib_path = "@core_sdk//:core/shared/Microsoft.NETCore.App/3.1.0/System.Diagnostics.StackTrace.dll",
        deps = [
            ":p1_system.runtime.dll",
        ]
    )
    core_stdlib(
        name = "p1_system.diagnostics.textwritertracelistener.dll",
        dotnet_context_data = context_data,
        ref = "@core_sdk//:core/packs/Microsoft.NETCore.App.Ref/3.1.0/ref/netcoreapp3.1/System.Diagnostics.TextWriterTraceListener.dll",
        stdlib_path = "@core_sdk//:core/shared/Microsoft.NETCore.App/3.1.0/System.Diagnostics.TextWriterTraceListener.dll",
        deps = [
            ":p1_system.runtime.dll",
            ":p1_system.runtime.extensions.dll",
            ":p1_system.diagnostics.tracesource.dll",
        ]
    )
    core_stdlib(
        name = "p1_system.diagnostics.tools.dll",
        dotnet_context_data = context_data,
        ref = "@core_sdk//:core/packs/Microsoft.NETCore.App.Ref/3.1.0/ref/netcoreapp3.1/System.Diagnostics.Tools.dll",
        stdlib_path = "@core_sdk//:core/shared/Microsoft.NETCore.App/3.1.0/System.Diagnostics.Tools.dll",
        deps = [
            ":p1_system.runtime.dll",
        ]
    )
    core_stdlib(
        name = "p1_system.diagnostics.tracesource.dll",
        dotnet_context_data = context_data,
        ref = "@core_sdk//:core/packs/Microsoft.NETCore.App.Ref/3.1.0/ref/netcoreapp3.1/System.Diagnostics.TraceSource.dll",
        stdlib_path = "@core_sdk//:core/shared/Microsoft.NETCore.App/3.1.0/System.Diagnostics.TraceSource.dll",
        deps = [
            ":p1_system.runtime.dll",
            ":p1_system.collections.nongeneric.dll",
            ":p1_system.collections.specialized.dll",
        ]
    )
    core_stdlib(
        name = "p1_system.diagnostics.tracing.dll",
        dotnet_context_data = context_data,
        ref = "@core_sdk//:core/packs/Microsoft.NETCore.App.Ref/3.1.0/ref/netcoreapp3.1/System.Diagnostics.Tracing.dll",
        stdlib_path = "@core_sdk//:core/shared/Microsoft.NETCore.App/3.1.0/System.Diagnostics.Tracing.dll",
        deps = [
            ":p1_system.runtime.dll",
        ]
    )
    core_stdlib(
        name = "p1_system.dll",
        dotnet_context_data = context_data,
        ref = "@core_sdk//:core/packs/Microsoft.NETCore.App.Ref/3.1.0/ref/netcoreapp3.1/System.dll",
        stdlib_path = "@core_sdk//:core/shared/Microsoft.NETCore.App/3.1.0/System.dll",
        deps = [
            ":p1_system.runtime.dll",
            ":p1_system.diagnostics.process.dll",
            ":p1_system.security.cryptography.x509certificates.dll",
            ":p1_system.diagnostics.tools.dll",
            ":p1_system.runtime.extensions.dll",
            ":p1_system.collections.concurrent.dll",
            ":p1_system.collections.dll",
            ":p1_system.objectmodel.dll",
            ":p1_system.collections.specialized.dll",
            ":p1_system.collections.nongeneric.dll",
            ":p1_system.componentmodel.typeconverter.dll",
            ":p1_system.componentmodel.eventbasedasync.dll",
            ":p1_system.componentmodel.primitives.dll",
            ":p1_system.componentmodel.dll",
            ":p1_microsoft.win32.primitives.dll",
            ":p1_system.diagnostics.tracesource.dll",
            ":p1_system.diagnostics.textwritertracelistener.dll",
            ":p1_system.diagnostics.debug.dll",
            ":p1_system.diagnostics.fileversioninfo.dll",
            ":p1_system.diagnostics.stacktrace.dll",
            ":p1_system.io.compression.dll",
            ":p1_system.io.filesystem.watcher.dll",
            ":p1_system.net.requests.dll",
            ":p1_system.net.primitives.dll",
            ":p1_system.net.httplistener.dll",
            ":p1_system.net.servicepoint.dll",
            ":p1_system.net.nameresolution.dll",
            ":p1_system.net.webclient.dll",
            ":p1_system.net.webheadercollection.dll",
            ":p1_system.net.webproxy.dll",
            ":p1_system.net.mail.dll",
            ":p1_system.net.networkinformation.dll",
            ":p1_system.net.ping.dll",
            ":p1_system.net.security.dll",
            ":p1_system.net.sockets.dll",
            ":p1_system.net.websockets.client.dll",
            ":p1_system.net.websockets.dll",
            ":p1_system.runtime.interopservices.dll",
            ":p1_system.security.cryptography.encoding.dll",
            ":p1_system.text.regularexpressions.dll",
            ":p1_system.threading.dll",
            ":p1_system.threading.thread.dll",
        ]
    )
    core_stdlib(
        name = "p1_system.drawing.dll",
        dotnet_context_data = context_data,
        ref = "@core_sdk//:core/packs/Microsoft.NETCore.App.Ref/3.1.0/ref/netcoreapp3.1/System.Drawing.dll",
        stdlib_path = "@core_sdk//:core/shared/Microsoft.NETCore.App/3.1.0/System.Drawing.dll",
        deps = [
            ":p1_system.runtime.dll",
            ":p1_system.drawing.primitives.dll",
            ":p1_system.componentmodel.typeconverter.dll",
        ]
    )
    core_stdlib(
        name = "p1_system.drawing.primitives.dll",
        dotnet_context_data = context_data,
        ref = "@core_sdk//:core/packs/Microsoft.NETCore.App.Ref/3.1.0/ref/netcoreapp3.1/System.Drawing.Primitives.dll",
        stdlib_path = "@core_sdk//:core/shared/Microsoft.NETCore.App/3.1.0/System.Drawing.Primitives.dll",
        deps = [
            ":p1_system.runtime.dll",
            ":p1_system.componentmodel.primitives.dll",
        ]
    )
    core_stdlib(
        name = "p1_system.dynamic.runtime.dll",
        dotnet_context_data = context_data,
        ref = "@core_sdk//:core/packs/Microsoft.NETCore.App.Ref/3.1.0/ref/netcoreapp3.1/System.Dynamic.Runtime.dll",
        stdlib_path = "@core_sdk//:core/shared/Microsoft.NETCore.App/3.1.0/System.Dynamic.Runtime.dll",
        deps = [
            ":p1_system.runtime.dll",
            ":p1_system.linq.expressions.dll",
        ]
    )
    core_stdlib(
        name = "p1_system.globalization.calendars.dll",
        dotnet_context_data = context_data,
        ref = "@core_sdk//:core/packs/Microsoft.NETCore.App.Ref/3.1.0/ref/netcoreapp3.1/System.Globalization.Calendars.dll",
        stdlib_path = "@core_sdk//:core/shared/Microsoft.NETCore.App/3.1.0/System.Globalization.Calendars.dll",
        deps = [
            ":p1_system.runtime.dll",
        ]
    )
    core_stdlib(
        name = "p1_system.globalization.dll",
        dotnet_context_data = context_data,
        ref = "@core_sdk//:core/packs/Microsoft.NETCore.App.Ref/3.1.0/ref/netcoreapp3.1/System.Globalization.dll",
        stdlib_path = "@core_sdk//:core/shared/Microsoft.NETCore.App/3.1.0/System.Globalization.dll",
        deps = [
            ":p1_system.runtime.dll",
        ]
    )
    core_stdlib(
        name = "p1_system.globalization.extensions.dll",
        dotnet_context_data = context_data,
        ref = "@core_sdk//:core/packs/Microsoft.NETCore.App.Ref/3.1.0/ref/netcoreapp3.1/System.Globalization.Extensions.dll",
        stdlib_path = "@core_sdk//:core/shared/Microsoft.NETCore.App/3.1.0/System.Globalization.Extensions.dll",
        deps = [
            ":p1_system.runtime.dll",
            ":p1_system.runtime.extensions.dll",
        ]
    )
    core_stdlib(
        name = "p1_system.io.compression.brotli.dll",
        dotnet_context_data = context_data,
        ref = "@core_sdk//:core/packs/Microsoft.NETCore.App.Ref/3.1.0/ref/netcoreapp3.1/System.IO.Compression.Brotli.dll",
        stdlib_path = "@core_sdk//:core/shared/Microsoft.NETCore.App/3.1.0/System.IO.Compression.Brotli.dll",
        deps = [
            ":p1_system.runtime.dll",
            ":p1_system.io.compression.dll",
        ]
    )
    core_stdlib(
        name = "p1_system.io.compression.dll",
        dotnet_context_data = context_data,
        ref = "@core_sdk//:core/packs/Microsoft.NETCore.App.Ref/3.1.0/ref/netcoreapp3.1/System.IO.Compression.dll",
        stdlib_path = "@core_sdk//:core/shared/Microsoft.NETCore.App/3.1.0/System.IO.Compression.dll",
        deps = [
            ":p1_system.runtime.dll",
        ]
    )
    core_stdlib(
        name = "p1_system.io.compression.filesystem.dll",
        dotnet_context_data = context_data,
        ref = "@core_sdk//:core/packs/Microsoft.NETCore.App.Ref/3.1.0/ref/netcoreapp3.1/System.IO.Compression.FileSystem.dll",
        stdlib_path = "@core_sdk//:core/shared/Microsoft.NETCore.App/3.1.0/System.IO.Compression.FileSystem.dll",
        deps = [
            ":p1_system.runtime.dll",
            ":p1_system.io.compression.zipfile.dll",
        ]
    )
    core_stdlib(
        name = "p1_system.io.compression.zipfile.dll",
        dotnet_context_data = context_data,
        ref = "@core_sdk//:core/packs/Microsoft.NETCore.App.Ref/3.1.0/ref/netcoreapp3.1/System.IO.Compression.ZipFile.dll",
        stdlib_path = "@core_sdk//:core/shared/Microsoft.NETCore.App/3.1.0/System.IO.Compression.ZipFile.dll",
        deps = [
            ":p1_system.runtime.dll",
            ":p1_system.io.compression.dll",
        ]
    )
    core_stdlib(
        name = "p1_system.io.dll",
        dotnet_context_data = context_data,
        ref = "@core_sdk//:core/packs/Microsoft.NETCore.App.Ref/3.1.0/ref/netcoreapp3.1/System.IO.dll",
        stdlib_path = "@core_sdk//:core/shared/Microsoft.NETCore.App/3.1.0/System.IO.dll",
        deps = [
            ":p1_system.runtime.dll",
            ":p1_system.runtime.extensions.dll",
        ]
    )
    core_stdlib(
        name = "p1_system.io.filesystem.dll",
        dotnet_context_data = context_data,
        ref = "@core_sdk//:core/packs/Microsoft.NETCore.App.Ref/3.1.0/ref/netcoreapp3.1/System.IO.FileSystem.dll",
        stdlib_path = "@core_sdk//:core/shared/Microsoft.NETCore.App/3.1.0/System.IO.FileSystem.dll",
        deps = [
            ":p1_system.runtime.dll",
            ":p1_system.runtime.extensions.dll",
        ]
    )
    core_stdlib(
        name = "p1_system.io.filesystem.driveinfo.dll",
        dotnet_context_data = context_data,
        ref = "@core_sdk//:core/packs/Microsoft.NETCore.App.Ref/3.1.0/ref/netcoreapp3.1/System.IO.FileSystem.DriveInfo.dll",
        stdlib_path = "@core_sdk//:core/shared/Microsoft.NETCore.App/3.1.0/System.IO.FileSystem.DriveInfo.dll",
        deps = [
            ":p1_system.runtime.dll",
            ":p1_system.io.filesystem.dll",
        ]
    )
    core_stdlib(
        name = "p1_system.io.filesystem.primitives.dll",
        dotnet_context_data = context_data,
        ref = "@core_sdk//:core/packs/Microsoft.NETCore.App.Ref/3.1.0/ref/netcoreapp3.1/System.IO.FileSystem.Primitives.dll",
        stdlib_path = "@core_sdk//:core/shared/Microsoft.NETCore.App/3.1.0/System.IO.FileSystem.Primitives.dll",
        deps = [
            ":p1_system.runtime.dll",
        ]
    )
    core_stdlib(
        name = "p1_system.io.filesystem.watcher.dll",
        dotnet_context_data = context_data,
        ref = "@core_sdk//:core/packs/Microsoft.NETCore.App.Ref/3.1.0/ref/netcoreapp3.1/System.IO.FileSystem.Watcher.dll",
        stdlib_path = "@core_sdk//:core/shared/Microsoft.NETCore.App/3.1.0/System.IO.FileSystem.Watcher.dll",
        deps = [
            ":p1_system.runtime.dll",
            ":p1_system.componentmodel.primitives.dll",
        ]
    )
    core_stdlib(
        name = "p1_system.io.isolatedstorage.dll",
        dotnet_context_data = context_data,
        ref = "@core_sdk//:core/packs/Microsoft.NETCore.App.Ref/3.1.0/ref/netcoreapp3.1/System.IO.IsolatedStorage.dll",
        stdlib_path = "@core_sdk//:core/shared/Microsoft.NETCore.App/3.1.0/System.IO.IsolatedStorage.dll",
        deps = [
            ":p1_system.runtime.dll",
        ]
    )
    core_stdlib(
        name = "p1_system.io.memorymappedfiles.dll",
        dotnet_context_data = context_data,
        ref = "@core_sdk//:core/packs/Microsoft.NETCore.App.Ref/3.1.0/ref/netcoreapp3.1/System.IO.MemoryMappedFiles.dll",
        stdlib_path = "@core_sdk//:core/shared/Microsoft.NETCore.App/3.1.0/System.IO.MemoryMappedFiles.dll",
        deps = [
            ":p1_system.runtime.dll",
            ":p1_system.runtime.interopservices.dll",
        ]
    )
    core_stdlib(
        name = "p1_system.io.pipes.dll",
        dotnet_context_data = context_data,
        ref = "@core_sdk//:core/packs/Microsoft.NETCore.App.Ref/3.1.0/ref/netcoreapp3.1/System.IO.Pipes.dll",
        stdlib_path = "@core_sdk//:core/shared/Microsoft.NETCore.App/3.1.0/System.IO.Pipes.dll",
        deps = [
            ":p1_system.runtime.dll",
            ":p1_system.security.principal.dll",
        ]
    )
    core_stdlib(
        name = "p1_system.io.unmanagedmemorystream.dll",
        dotnet_context_data = context_data,
        ref = "@core_sdk//:core/packs/Microsoft.NETCore.App.Ref/3.1.0/ref/netcoreapp3.1/System.IO.UnmanagedMemoryStream.dll",
        stdlib_path = "@core_sdk//:core/shared/Microsoft.NETCore.App/3.1.0/System.IO.UnmanagedMemoryStream.dll",
        deps = [
            ":p1_system.runtime.dll",
            ":p1_system.runtime.interopservices.dll",
        ]
    )
    core_stdlib(
        name = "p1_system.linq.dll",
        dotnet_context_data = context_data,
        ref = "@core_sdk//:core/packs/Microsoft.NETCore.App.Ref/3.1.0/ref/netcoreapp3.1/System.Linq.dll",
        stdlib_path = "@core_sdk//:core/shared/Microsoft.NETCore.App/3.1.0/System.Linq.dll",
        deps = [
            ":p1_system.runtime.dll",
            ":p1_system.collections.dll",
        ]
    )
    core_stdlib(
        name = "p1_system.linq.expressions.dll",
        dotnet_context_data = context_data,
        ref = "@core_sdk//:core/packs/Microsoft.NETCore.App.Ref/3.1.0/ref/netcoreapp3.1/System.Linq.Expressions.dll",
        stdlib_path = "@core_sdk//:core/shared/Microsoft.NETCore.App/3.1.0/System.Linq.Expressions.dll",
        deps = [
            ":p1_system.runtime.dll",
            ":p1_system.objectmodel.dll",
        ]
    )
    core_stdlib(
        name = "p1_system.linq.parallel.dll",
        dotnet_context_data = context_data,
        ref = "@core_sdk//:core/packs/Microsoft.NETCore.App.Ref/3.1.0/ref/netcoreapp3.1/System.Linq.Parallel.dll",
        stdlib_path = "@core_sdk//:core/shared/Microsoft.NETCore.App/3.1.0/System.Linq.Parallel.dll",
        deps = [
            ":p1_system.runtime.dll",
            ":p1_system.collections.concurrent.dll",
            ":p1_system.linq.dll",
            ":p1_system.collections.dll",
        ]
    )
    core_stdlib(
        name = "p1_system.linq.queryable.dll",
        dotnet_context_data = context_data,
        ref = "@core_sdk//:core/packs/Microsoft.NETCore.App.Ref/3.1.0/ref/netcoreapp3.1/System.Linq.Queryable.dll",
        stdlib_path = "@core_sdk//:core/shared/Microsoft.NETCore.App/3.1.0/System.Linq.Queryable.dll",
        deps = [
            ":p1_system.runtime.dll",
            ":p1_system.linq.expressions.dll",
            ":p1_system.linq.dll",
        ]
    )
    core_stdlib(
        name = "p1_system.memory.dll",
        dotnet_context_data = context_data,
        ref = "@core_sdk//:core/packs/Microsoft.NETCore.App.Ref/3.1.0/ref/netcoreapp3.1/System.Memory.dll",
        stdlib_path = "@core_sdk//:core/shared/Microsoft.NETCore.App/3.1.0/System.Memory.dll",
        deps = [
            ":p1_system.runtime.dll",
            ":p1_system.runtime.interopservices.dll",
        ]
    )
    core_stdlib(
        name = "p1_system.net.dll",
        dotnet_context_data = context_data,
        ref = "@core_sdk//:core/packs/Microsoft.NETCore.App.Ref/3.1.0/ref/netcoreapp3.1/System.Net.dll",
        stdlib_path = "@core_sdk//:core/shared/Microsoft.NETCore.App/3.1.0/System.Net.dll",
        deps = [
            ":p1_system.runtime.dll",
            ":p1_system.net.primitives.dll",
            ":p1_system.net.webclient.dll",
            ":p1_system.net.webheadercollection.dll",
            ":p1_system.net.requests.dll",
            ":p1_system.net.networkinformation.dll",
            ":p1_system.net.sockets.dll",
        ]
    )
    core_stdlib(
        name = "p1_system.net.http.dll",
        dotnet_context_data = context_data,
        ref = "@core_sdk//:core/packs/Microsoft.NETCore.App.Ref/3.1.0/ref/netcoreapp3.1/System.Net.Http.dll",
        stdlib_path = "@core_sdk//:core/shared/Microsoft.NETCore.App/3.1.0/System.Net.Http.dll",
        deps = [
            ":p1_system.runtime.dll",
            ":p1_system.net.primitives.dll",
            ":p1_system.security.cryptography.x509certificates.dll",
            ":p1_system.net.security.dll",
        ]
    )
    core_stdlib(
        name = "p1_system.net.httplistener.dll",
        dotnet_context_data = context_data,
        ref = "@core_sdk//:core/packs/Microsoft.NETCore.App.Ref/3.1.0/ref/netcoreapp3.1/System.Net.HttpListener.dll",
        stdlib_path = "@core_sdk//:core/shared/Microsoft.NETCore.App/3.1.0/System.Net.HttpListener.dll",
        deps = [
            ":p1_system.runtime.dll",
            ":p1_system.net.primitives.dll",
            ":p1_system.net.security.dll",
            ":p1_system.security.claims.dll",
            ":p1_system.security.principal.dll",
            ":p1_microsoft.win32.primitives.dll",
            ":p1_system.collections.specialized.dll",
            ":p1_system.security.cryptography.x509certificates.dll",
            ":p1_system.net.webheadercollection.dll",
            ":p1_system.net.websockets.dll",
        ]
    )
    core_stdlib(
        name = "p1_system.net.mail.dll",
        dotnet_context_data = context_data,
        ref = "@core_sdk//:core/packs/Microsoft.NETCore.App.Ref/3.1.0/ref/netcoreapp3.1/System.Net.Mail.dll",
        stdlib_path = "@core_sdk//:core/shared/Microsoft.NETCore.App/3.1.0/System.Net.Mail.dll",
        deps = [
            ":p1_system.runtime.dll",
            ":p1_system.collections.specialized.dll",
            ":p1_system.componentmodel.eventbasedasync.dll",
            ":p1_system.security.cryptography.x509certificates.dll",
            ":p1_system.net.primitives.dll",
            ":p1_system.net.servicepoint.dll",
        ]
    )
    core_stdlib(
        name = "p1_system.net.nameresolution.dll",
        dotnet_context_data = context_data,
        ref = "@core_sdk//:core/packs/Microsoft.NETCore.App.Ref/3.1.0/ref/netcoreapp3.1/System.Net.NameResolution.dll",
        stdlib_path = "@core_sdk//:core/shared/Microsoft.NETCore.App/3.1.0/System.Net.NameResolution.dll",
        deps = [
            ":p1_system.runtime.dll",
            ":p1_system.net.primitives.dll",
        ]
    )
    core_stdlib(
        name = "p1_system.net.networkinformation.dll",
        dotnet_context_data = context_data,
        ref = "@core_sdk//:core/packs/Microsoft.NETCore.App.Ref/3.1.0/ref/netcoreapp3.1/System.Net.NetworkInformation.dll",
        stdlib_path = "@core_sdk//:core/shared/Microsoft.NETCore.App/3.1.0/System.Net.NetworkInformation.dll",
        deps = [
            ":p1_system.runtime.dll",
            ":p1_system.net.primitives.dll",
            ":p1_microsoft.win32.primitives.dll",
        ]
    )
    core_stdlib(
        name = "p1_system.net.ping.dll",
        dotnet_context_data = context_data,
        ref = "@core_sdk//:core/packs/Microsoft.NETCore.App.Ref/3.1.0/ref/netcoreapp3.1/System.Net.Ping.dll",
        stdlib_path = "@core_sdk//:core/shared/Microsoft.NETCore.App/3.1.0/System.Net.Ping.dll",
        deps = [
            ":p1_system.runtime.dll",
            ":p1_system.componentmodel.primitives.dll",
            ":p1_system.net.primitives.dll",
            ":p1_system.componentmodel.eventbasedasync.dll",
        ]
    )
    core_stdlib(
        name = "p1_system.net.primitives.dll",
        dotnet_context_data = context_data,
        ref = "@core_sdk//:core/packs/Microsoft.NETCore.App.Ref/3.1.0/ref/netcoreapp3.1/System.Net.Primitives.dll",
        stdlib_path = "@core_sdk//:core/shared/Microsoft.NETCore.App/3.1.0/System.Net.Primitives.dll",
        deps = [
            ":p1_system.runtime.dll",
            ":p1_system.runtime.interopservices.dll",
            ":p1_microsoft.win32.primitives.dll",
        ]
    )
    core_stdlib(
        name = "p1_system.net.requests.dll",
        dotnet_context_data = context_data,
        ref = "@core_sdk//:core/packs/Microsoft.NETCore.App.Ref/3.1.0/ref/netcoreapp3.1/System.Net.Requests.dll",
        stdlib_path = "@core_sdk//:core/shared/Microsoft.NETCore.App/3.1.0/System.Net.Requests.dll",
        deps = [
            ":p1_system.runtime.dll",
            ":p1_system.collections.specialized.dll",
            ":p1_system.net.primitives.dll",
            ":p1_system.net.webheadercollection.dll",
            ":p1_system.security.cryptography.x509certificates.dll",
            ":p1_system.net.servicepoint.dll",
            ":p1_system.net.security.dll",
            ":p1_system.security.principal.dll",
        ]
    )
    core_stdlib(
        name = "p1_system.net.security.dll",
        dotnet_context_data = context_data,
        ref = "@core_sdk//:core/packs/Microsoft.NETCore.App.Ref/3.1.0/ref/netcoreapp3.1/System.Net.Security.dll",
        stdlib_path = "@core_sdk//:core/shared/Microsoft.NETCore.App/3.1.0/System.Net.Security.dll",
        deps = [
            ":p1_system.runtime.dll",
            ":p1_system.net.primitives.dll",
            ":p1_system.collections.nongeneric.dll",
            ":p1_system.security.cryptography.x509certificates.dll",
            ":p1_system.security.principal.dll",
            ":p1_system.collections.dll",
        ]
    )
    core_stdlib(
        name = "p1_system.net.servicepoint.dll",
        dotnet_context_data = context_data,
        ref = "@core_sdk//:core/packs/Microsoft.NETCore.App.Ref/3.1.0/ref/netcoreapp3.1/System.Net.ServicePoint.dll",
        stdlib_path = "@core_sdk//:core/shared/Microsoft.NETCore.App/3.1.0/System.Net.ServicePoint.dll",
        deps = [
            ":p1_system.runtime.dll",
            ":p1_system.net.primitives.dll",
            ":p1_system.security.cryptography.x509certificates.dll",
            ":p1_system.net.security.dll",
        ]
    )
    core_stdlib(
        name = "p1_system.net.sockets.dll",
        dotnet_context_data = context_data,
        ref = "@core_sdk//:core/packs/Microsoft.NETCore.App.Ref/3.1.0/ref/netcoreapp3.1/System.Net.Sockets.dll",
        stdlib_path = "@core_sdk//:core/shared/Microsoft.NETCore.App/3.1.0/System.Net.Sockets.dll",
        deps = [
            ":p1_system.runtime.dll",
            ":p1_system.net.primitives.dll",
        ]
    )
    core_stdlib(
        name = "p1_system.net.webclient.dll",
        dotnet_context_data = context_data,
        ref = "@core_sdk//:core/packs/Microsoft.NETCore.App.Ref/3.1.0/ref/netcoreapp3.1/System.Net.WebClient.dll",
        stdlib_path = "@core_sdk//:core/shared/Microsoft.NETCore.App/3.1.0/System.Net.WebClient.dll",
        deps = [
            ":p1_system.runtime.dll",
            ":p1_system.componentmodel.eventbasedasync.dll",
            ":p1_system.componentmodel.primitives.dll",
            ":p1_system.net.primitives.dll",
            ":p1_system.net.webheadercollection.dll",
            ":p1_system.collections.specialized.dll",
            ":p1_system.net.requests.dll",
        ]
    )
    core_stdlib(
        name = "p1_system.net.webheadercollection.dll",
        dotnet_context_data = context_data,
        ref = "@core_sdk//:core/packs/Microsoft.NETCore.App.Ref/3.1.0/ref/netcoreapp3.1/System.Net.WebHeaderCollection.dll",
        stdlib_path = "@core_sdk//:core/shared/Microsoft.NETCore.App/3.1.0/System.Net.WebHeaderCollection.dll",
        deps = [
            ":p1_system.runtime.dll",
            ":p1_system.collections.specialized.dll",
        ]
    )
    core_stdlib(
        name = "p1_system.net.webproxy.dll",
        dotnet_context_data = context_data,
        ref = "@core_sdk//:core/packs/Microsoft.NETCore.App.Ref/3.1.0/ref/netcoreapp3.1/System.Net.WebProxy.dll",
        stdlib_path = "@core_sdk//:core/shared/Microsoft.NETCore.App/3.1.0/System.Net.WebProxy.dll",
        deps = [
            ":p1_system.runtime.dll",
            ":p1_system.net.primitives.dll",
            ":p1_system.runtime.extensions.dll",
        ]
    )
    core_stdlib(
        name = "p1_system.net.websockets.client.dll",
        dotnet_context_data = context_data,
        ref = "@core_sdk//:core/packs/Microsoft.NETCore.App.Ref/3.1.0/ref/netcoreapp3.1/System.Net.WebSockets.Client.dll",
        stdlib_path = "@core_sdk//:core/shared/Microsoft.NETCore.App/3.1.0/System.Net.WebSockets.Client.dll",
        deps = [
            ":p1_system.runtime.dll",
            ":p1_system.net.websockets.dll",
            ":p1_system.security.cryptography.x509certificates.dll",
            ":p1_system.net.primitives.dll",
            ":p1_system.net.security.dll",
        ]
    )
    core_stdlib(
        name = "p1_system.net.websockets.dll",
        dotnet_context_data = context_data,
        ref = "@core_sdk//:core/packs/Microsoft.NETCore.App.Ref/3.1.0/ref/netcoreapp3.1/System.Net.WebSockets.dll",
        stdlib_path = "@core_sdk//:core/shared/Microsoft.NETCore.App/3.1.0/System.Net.WebSockets.dll",
        deps = [
            ":p1_system.runtime.dll",
            ":p1_system.net.primitives.dll",
            ":p1_system.collections.specialized.dll",
            ":p1_system.security.principal.dll",
            ":p1_microsoft.win32.primitives.dll",
        ]
    )
    core_stdlib(
        name = "p1_system.numerics.dll",
        dotnet_context_data = context_data,
        ref = "@core_sdk//:core/packs/Microsoft.NETCore.App.Ref/3.1.0/ref/netcoreapp3.1/System.Numerics.dll",
        stdlib_path = "@core_sdk//:core/shared/Microsoft.NETCore.App/3.1.0/System.Numerics.dll",
        deps = [
            ":p1_system.runtime.dll",
            ":p1_system.runtime.numerics.dll",
            ":p1_system.numerics.vectors.dll",
        ]
    )
    core_stdlib(
        name = "p1_system.numerics.vectors.dll",
        dotnet_context_data = context_data,
        ref = "@core_sdk//:core/packs/Microsoft.NETCore.App.Ref/3.1.0/ref/netcoreapp3.1/System.Numerics.Vectors.dll",
        stdlib_path = "@core_sdk//:core/shared/Microsoft.NETCore.App/3.1.0/System.Numerics.Vectors.dll",
        deps = [
            ":p1_system.runtime.dll",
        ]
    )
    core_stdlib(
        name = "p1_system.objectmodel.dll",
        dotnet_context_data = context_data,
        ref = "@core_sdk//:core/packs/Microsoft.NETCore.App.Ref/3.1.0/ref/netcoreapp3.1/System.ObjectModel.dll",
        stdlib_path = "@core_sdk//:core/shared/Microsoft.NETCore.App/3.1.0/System.ObjectModel.dll",
        deps = [
            ":p1_system.runtime.dll",
            ":p1_system.collections.dll",
        ]
    )
    core_stdlib(
        name = "p1_system.reflection.dispatchproxy.dll",
        dotnet_context_data = context_data,
        ref = "@core_sdk//:core/packs/Microsoft.NETCore.App.Ref/3.1.0/ref/netcoreapp3.1/System.Reflection.DispatchProxy.dll",
        stdlib_path = "@core_sdk//:core/shared/Microsoft.NETCore.App/3.1.0/System.Reflection.DispatchProxy.dll",
        deps = [
            ":p1_system.runtime.dll",
        ]
    )
    core_stdlib(
        name = "p1_system.reflection.dll",
        dotnet_context_data = context_data,
        ref = "@core_sdk//:core/packs/Microsoft.NETCore.App.Ref/3.1.0/ref/netcoreapp3.1/System.Reflection.dll",
        stdlib_path = "@core_sdk//:core/shared/Microsoft.NETCore.App/3.1.0/System.Reflection.dll",
        deps = [
            ":p1_system.runtime.dll",
        ]
    )
    core_stdlib(
        name = "p1_system.reflection.emit.dll",
        dotnet_context_data = context_data,
        ref = "@core_sdk//:core/packs/Microsoft.NETCore.App.Ref/3.1.0/ref/netcoreapp3.1/System.Reflection.Emit.dll",
        stdlib_path = "@core_sdk//:core/shared/Microsoft.NETCore.App/3.1.0/System.Reflection.Emit.dll",
        deps = [
            ":p1_system.runtime.dll",
            ":p1_system.runtime.interopservices.dll",
            ":p1_system.reflection.emit.ilgeneration.dll",
            ":p1_system.reflection.primitives.dll",
        ]
    )
    core_stdlib(
        name = "p1_system.reflection.emit.ilgeneration.dll",
        dotnet_context_data = context_data,
        ref = "@core_sdk//:core/packs/Microsoft.NETCore.App.Ref/3.1.0/ref/netcoreapp3.1/System.Reflection.Emit.ILGeneration.dll",
        stdlib_path = "@core_sdk//:core/shared/Microsoft.NETCore.App/3.1.0/System.Reflection.Emit.ILGeneration.dll",
        deps = [
            ":p1_system.runtime.dll",
            ":p1_system.runtime.interopservices.dll",
            ":p1_system.reflection.primitives.dll",
        ]
    )
    core_stdlib(
        name = "p1_system.reflection.emit.lightweight.dll",
        dotnet_context_data = context_data,
        ref = "@core_sdk//:core/packs/Microsoft.NETCore.App.Ref/3.1.0/ref/netcoreapp3.1/System.Reflection.Emit.Lightweight.dll",
        stdlib_path = "@core_sdk//:core/shared/Microsoft.NETCore.App/3.1.0/System.Reflection.Emit.Lightweight.dll",
        deps = [
            ":p1_system.runtime.dll",
            ":p1_system.reflection.emit.ilgeneration.dll",
        ]
    )
    core_stdlib(
        name = "p1_system.reflection.extensions.dll",
        dotnet_context_data = context_data,
        ref = "@core_sdk//:core/packs/Microsoft.NETCore.App.Ref/3.1.0/ref/netcoreapp3.1/System.Reflection.Extensions.dll",
        stdlib_path = "@core_sdk//:core/shared/Microsoft.NETCore.App/3.1.0/System.Reflection.Extensions.dll",
        deps = [
            ":p1_system.runtime.dll",
        ]
    )
    core_stdlib(
        name = "p1_system.reflection.metadata.dll",
        dotnet_context_data = context_data,
        ref = "@core_sdk//:core/packs/Microsoft.NETCore.App.Ref/3.1.0/ref/netcoreapp3.1/System.Reflection.Metadata.dll",
        stdlib_path = "@core_sdk//:core/shared/Microsoft.NETCore.App/3.1.0/System.Reflection.Metadata.dll",
        deps = [
            ":p1_system.runtime.dll",
            ":p1_system.collections.immutable.dll",
        ]
    )
    core_stdlib(
        name = "p1_system.reflection.primitives.dll",
        dotnet_context_data = context_data,
        ref = "@core_sdk//:core/packs/Microsoft.NETCore.App.Ref/3.1.0/ref/netcoreapp3.1/System.Reflection.Primitives.dll",
        stdlib_path = "@core_sdk//:core/shared/Microsoft.NETCore.App/3.1.0/System.Reflection.Primitives.dll",
        deps = [
            ":p1_system.runtime.dll",
        ]
    )
    core_stdlib(
        name = "p1_system.reflection.typeextensions.dll",
        dotnet_context_data = context_data,
        ref = "@core_sdk//:core/packs/Microsoft.NETCore.App.Ref/3.1.0/ref/netcoreapp3.1/System.Reflection.TypeExtensions.dll",
        stdlib_path = "@core_sdk//:core/shared/Microsoft.NETCore.App/3.1.0/System.Reflection.TypeExtensions.dll",
        deps = [
            ":p1_netstandard.dll",
        ]
    )
    core_stdlib(
        name = "p1_system.resources.reader.dll",
        dotnet_context_data = context_data,
        ref = "@core_sdk//:core/packs/Microsoft.NETCore.App.Ref/3.1.0/ref/netcoreapp3.1/System.Resources.Reader.dll",
        stdlib_path = "@core_sdk//:core/shared/Microsoft.NETCore.App/3.1.0/System.Resources.Reader.dll",
        deps = [
            ":p1_system.runtime.dll",
            ":p1_system.resources.resourcemanager.dll",
        ]
    )
    core_stdlib(
        name = "p1_system.resources.resourcemanager.dll",
        dotnet_context_data = context_data,
        ref = "@core_sdk//:core/packs/Microsoft.NETCore.App.Ref/3.1.0/ref/netcoreapp3.1/System.Resources.ResourceManager.dll",
        stdlib_path = "@core_sdk//:core/shared/Microsoft.NETCore.App/3.1.0/System.Resources.ResourceManager.dll",
        deps = [
            ":p1_system.runtime.dll",
            ":p1_system.runtime.interopservices.dll",
        ]
    )
    core_stdlib(
        name = "p1_system.resources.writer.dll",
        dotnet_context_data = context_data,
        ref = "@core_sdk//:core/packs/Microsoft.NETCore.App.Ref/3.1.0/ref/netcoreapp3.1/System.Resources.Writer.dll",
        stdlib_path = "@core_sdk//:core/shared/Microsoft.NETCore.App/3.1.0/System.Resources.Writer.dll",
        deps = [
            ":p1_system.runtime.dll",
        ]
    )
    core_stdlib(
        name = "p1_system.runtime.compilerservices.unsafe.dll",
        dotnet_context_data = context_data,
        ref = "@core_sdk//:core/packs/Microsoft.NETCore.App.Ref/3.1.0/ref/netcoreapp3.1/System.Runtime.CompilerServices.Unsafe.dll",
        stdlib_path = "@core_sdk//:core/shared/Microsoft.NETCore.App/3.1.0/System.Runtime.CompilerServices.Unsafe.dll",
        deps = [
            ":p1_netstandard.dll",
        ]
    )
    core_stdlib(
        name = "p1_system.runtime.compilerservices.visualc.dll",
        dotnet_context_data = context_data,
        ref = "@core_sdk//:core/packs/Microsoft.NETCore.App.Ref/3.1.0/ref/netcoreapp3.1/System.Runtime.CompilerServices.VisualC.dll",
        stdlib_path = "@core_sdk//:core/shared/Microsoft.NETCore.App/3.1.0/System.Runtime.CompilerServices.VisualC.dll",
        deps = [
            ":p1_system.runtime.dll",
        ]
    )
    core_stdlib(
        name = "p1_system.runtime.dll",
        dotnet_context_data = context_data,
        ref = "@core_sdk//:core/packs/Microsoft.NETCore.App.Ref/3.1.0/ref/netcoreapp3.1/System.Runtime.dll",
        stdlib_path = "@core_sdk//:core/shared/Microsoft.NETCore.App/3.1.0/System.Runtime.dll",
        deps = [
        ]
    )
    core_stdlib(
        name = "p1_system.runtime.extensions.dll",
        dotnet_context_data = context_data,
        ref = "@core_sdk//:core/packs/Microsoft.NETCore.App.Ref/3.1.0/ref/netcoreapp3.1/System.Runtime.Extensions.dll",
        stdlib_path = "@core_sdk//:core/shared/Microsoft.NETCore.App/3.1.0/System.Runtime.Extensions.dll",
        deps = [
            ":p1_system.runtime.dll",
            ":p1_system.security.principal.dll",
        ]
    )
    core_stdlib(
        name = "p1_system.runtime.handles.dll",
        dotnet_context_data = context_data,
        ref = "@core_sdk//:core/packs/Microsoft.NETCore.App.Ref/3.1.0/ref/netcoreapp3.1/System.Runtime.Handles.dll",
        stdlib_path = "@core_sdk//:core/shared/Microsoft.NETCore.App/3.1.0/System.Runtime.Handles.dll",
        deps = [
            ":p1_system.runtime.dll",
        ]
    )
    core_stdlib(
        name = "p1_system.runtime.interopservices.dll",
        dotnet_context_data = context_data,
        ref = "@core_sdk//:core/packs/Microsoft.NETCore.App.Ref/3.1.0/ref/netcoreapp3.1/System.Runtime.InteropServices.dll",
        stdlib_path = "@core_sdk//:core/shared/Microsoft.NETCore.App/3.1.0/System.Runtime.InteropServices.dll",
        deps = [
            ":p1_system.runtime.dll",
        ]
    )
    core_stdlib(
        name = "p1_system.runtime.interopservices.runtimeinformation.dll",
        dotnet_context_data = context_data,
        ref = "@core_sdk//:core/packs/Microsoft.NETCore.App.Ref/3.1.0/ref/netcoreapp3.1/System.Runtime.InteropServices.RuntimeInformation.dll",
        stdlib_path = "@core_sdk//:core/shared/Microsoft.NETCore.App/3.1.0/System.Runtime.InteropServices.RuntimeInformation.dll",
        deps = [
            ":p1_system.runtime.dll",
        ]
    )
    core_stdlib(
        name = "p1_system.runtime.interopservices.windowsruntime.dll",
        dotnet_context_data = context_data,
        ref = "@core_sdk//:core/packs/Microsoft.NETCore.App.Ref/3.1.0/ref/netcoreapp3.1/System.Runtime.InteropServices.WindowsRuntime.dll",
        stdlib_path = "@core_sdk//:core/shared/Microsoft.NETCore.App/3.1.0/System.Runtime.InteropServices.WindowsRuntime.dll",
        deps = [
            ":p1_system.runtime.dll",
        ]
    )
    core_stdlib(
        name = "p1_system.runtime.intrinsics.dll",
        dotnet_context_data = context_data,
        ref = "@core_sdk//:core/packs/Microsoft.NETCore.App.Ref/3.1.0/ref/netcoreapp3.1/System.Runtime.Intrinsics.dll",
        stdlib_path = "@core_sdk//:core/shared/Microsoft.NETCore.App/3.1.0/System.Runtime.Intrinsics.dll",
        deps = [
            ":p1_system.runtime.dll",
        ]
    )
    core_stdlib(
        name = "p1_system.runtime.loader.dll",
        dotnet_context_data = context_data,
        ref = "@core_sdk//:core/packs/Microsoft.NETCore.App.Ref/3.1.0/ref/netcoreapp3.1/System.Runtime.Loader.dll",
        stdlib_path = "@core_sdk//:core/shared/Microsoft.NETCore.App/3.1.0/System.Runtime.Loader.dll",
        deps = [
            ":p1_system.runtime.dll",
        ]
    )
    core_stdlib(
        name = "p1_system.runtime.numerics.dll",
        dotnet_context_data = context_data,
        ref = "@core_sdk//:core/packs/Microsoft.NETCore.App.Ref/3.1.0/ref/netcoreapp3.1/System.Runtime.Numerics.dll",
        stdlib_path = "@core_sdk//:core/shared/Microsoft.NETCore.App/3.1.0/System.Runtime.Numerics.dll",
        deps = [
            ":p1_system.runtime.dll",
        ]
    )
    core_stdlib(
        name = "p1_system.runtime.serialization.dll",
        dotnet_context_data = context_data,
        ref = "@core_sdk//:core/packs/Microsoft.NETCore.App.Ref/3.1.0/ref/netcoreapp3.1/System.Runtime.Serialization.dll",
        stdlib_path = "@core_sdk//:core/shared/Microsoft.NETCore.App/3.1.0/System.Runtime.Serialization.dll",
        deps = [
            ":p1_system.runtime.dll",
            ":p1_system.runtime.serialization.primitives.dll",
            ":p1_system.runtime.serialization.xml.dll",
            ":p1_system.runtime.serialization.json.dll",
        ]
    )
    core_stdlib(
        name = "p1_system.runtime.serialization.formatters.dll",
        dotnet_context_data = context_data,
        ref = "@core_sdk//:core/packs/Microsoft.NETCore.App.Ref/3.1.0/ref/netcoreapp3.1/System.Runtime.Serialization.Formatters.dll",
        stdlib_path = "@core_sdk//:core/shared/Microsoft.NETCore.App/3.1.0/System.Runtime.Serialization.Formatters.dll",
        deps = [
            ":p1_system.runtime.dll",
            ":p1_system.collections.nongeneric.dll",
        ]
    )
    core_stdlib(
        name = "p1_system.runtime.serialization.json.dll",
        dotnet_context_data = context_data,
        ref = "@core_sdk//:core/packs/Microsoft.NETCore.App.Ref/3.1.0/ref/netcoreapp3.1/System.Runtime.Serialization.Json.dll",
        stdlib_path = "@core_sdk//:core/shared/Microsoft.NETCore.App/3.1.0/System.Runtime.Serialization.Json.dll",
        deps = [
            ":p1_system.runtime.dll",
            ":p1_system.runtime.serialization.xml.dll",
            ":p1_system.xml.readerwriter.dll",
        ]
    )
    core_stdlib(
        name = "p1_system.runtime.serialization.primitives.dll",
        dotnet_context_data = context_data,
        ref = "@core_sdk//:core/packs/Microsoft.NETCore.App.Ref/3.1.0/ref/netcoreapp3.1/System.Runtime.Serialization.Primitives.dll",
        stdlib_path = "@core_sdk//:core/shared/Microsoft.NETCore.App/3.1.0/System.Runtime.Serialization.Primitives.dll",
        deps = [
            ":p1_system.runtime.dll",
        ]
    )
    core_stdlib(
        name = "p1_system.runtime.serialization.xml.dll",
        dotnet_context_data = context_data,
        ref = "@core_sdk//:core/packs/Microsoft.NETCore.App.Ref/3.1.0/ref/netcoreapp3.1/System.Runtime.Serialization.Xml.dll",
        stdlib_path = "@core_sdk//:core/shared/Microsoft.NETCore.App/3.1.0/System.Runtime.Serialization.Xml.dll",
        deps = [
            ":p1_system.runtime.dll",
            ":p1_system.xml.readerwriter.dll",
            ":p1_system.runtime.serialization.primitives.dll",
        ]
    )
    core_stdlib(
        name = "p1_system.security.claims.dll",
        dotnet_context_data = context_data,
        ref = "@core_sdk//:core/packs/Microsoft.NETCore.App.Ref/3.1.0/ref/netcoreapp3.1/System.Security.Claims.dll",
        stdlib_path = "@core_sdk//:core/shared/Microsoft.NETCore.App/3.1.0/System.Security.Claims.dll",
        deps = [
            ":p1_system.runtime.dll",
            ":p1_system.security.principal.dll",
            ":p1_system.runtime.extensions.dll",
        ]
    )
    core_stdlib(
        name = "p1_system.security.cryptography.algorithms.dll",
        dotnet_context_data = context_data,
        ref = "@core_sdk//:core/packs/Microsoft.NETCore.App.Ref/3.1.0/ref/netcoreapp3.1/System.Security.Cryptography.Algorithms.dll",
        stdlib_path = "@core_sdk//:core/shared/Microsoft.NETCore.App/3.1.0/System.Security.Cryptography.Algorithms.dll",
        deps = [
            ":p1_system.runtime.dll",
            ":p1_system.security.cryptography.primitives.dll",
            ":p1_system.security.cryptography.encoding.dll",
            ":p1_system.runtime.extensions.dll",
        ]
    )
    core_stdlib(
        name = "p1_system.security.cryptography.csp.dll",
        dotnet_context_data = context_data,
        ref = "@core_sdk//:core/packs/Microsoft.NETCore.App.Ref/3.1.0/ref/netcoreapp3.1/System.Security.Cryptography.Csp.dll",
        stdlib_path = "@core_sdk//:core/shared/Microsoft.NETCore.App/3.1.0/System.Security.Cryptography.Csp.dll",
        deps = [
            ":p1_system.runtime.dll",
            ":p1_system.runtime.interopservices.dll",
            ":p1_system.security.cryptography.algorithms.dll",
            ":p1_system.security.cryptography.primitives.dll",
        ]
    )
    core_stdlib(
        name = "p1_system.security.cryptography.encoding.dll",
        dotnet_context_data = context_data,
        ref = "@core_sdk//:core/packs/Microsoft.NETCore.App.Ref/3.1.0/ref/netcoreapp3.1/System.Security.Cryptography.Encoding.dll",
        stdlib_path = "@core_sdk//:core/shared/Microsoft.NETCore.App/3.1.0/System.Security.Cryptography.Encoding.dll",
        deps = [
            ":p1_system.runtime.dll",
            ":p1_system.security.cryptography.primitives.dll",
        ]
    )
    core_stdlib(
        name = "p1_system.security.cryptography.primitives.dll",
        dotnet_context_data = context_data,
        ref = "@core_sdk//:core/packs/Microsoft.NETCore.App.Ref/3.1.0/ref/netcoreapp3.1/System.Security.Cryptography.Primitives.dll",
        stdlib_path = "@core_sdk//:core/shared/Microsoft.NETCore.App/3.1.0/System.Security.Cryptography.Primitives.dll",
        deps = [
            ":p1_system.runtime.dll",
        ]
    )
    core_stdlib(
        name = "p1_system.security.cryptography.x509certificates.dll",
        dotnet_context_data = context_data,
        ref = "@core_sdk//:core/packs/Microsoft.NETCore.App.Ref/3.1.0/ref/netcoreapp3.1/System.Security.Cryptography.X509Certificates.dll",
        stdlib_path = "@core_sdk//:core/shared/Microsoft.NETCore.App/3.1.0/System.Security.Cryptography.X509Certificates.dll",
        deps = [
            ":p1_system.runtime.dll",
            ":p1_system.runtime.interopservices.dll",
            ":p1_system.security.cryptography.algorithms.dll",
            ":p1_system.security.cryptography.primitives.dll",
            ":p1_system.security.cryptography.encoding.dll",
            ":p1_system.net.primitives.dll",
            ":p1_system.collections.nongeneric.dll",
        ]
    )
    core_stdlib(
        name = "p1_system.security.dll",
        dotnet_context_data = context_data,
        ref = "@core_sdk//:core/packs/Microsoft.NETCore.App.Ref/3.1.0/ref/netcoreapp3.1/System.Security.dll",
        stdlib_path = "@core_sdk//:core/shared/Microsoft.NETCore.App/3.1.0/System.Security.dll",
        deps = [
            ":p1_system.runtime.dll",
        ]
    )
    core_stdlib(
        name = "p1_system.security.principal.dll",
        dotnet_context_data = context_data,
        ref = "@core_sdk//:core/packs/Microsoft.NETCore.App.Ref/3.1.0/ref/netcoreapp3.1/System.Security.Principal.dll",
        stdlib_path = "@core_sdk//:core/shared/Microsoft.NETCore.App/3.1.0/System.Security.Principal.dll",
        deps = [
            ":p1_system.runtime.dll",
        ]
    )
    core_stdlib(
        name = "p1_system.security.securestring.dll",
        dotnet_context_data = context_data,
        ref = "@core_sdk//:core/packs/Microsoft.NETCore.App.Ref/3.1.0/ref/netcoreapp3.1/System.Security.SecureString.dll",
        stdlib_path = "@core_sdk//:core/shared/Microsoft.NETCore.App/3.1.0/System.Security.SecureString.dll",
        deps = [
            ":p1_system.runtime.dll",
            ":p1_system.runtime.interopservices.dll",
        ]
    )
    core_stdlib(
        name = "p1_system.servicemodel.web.dll",
        dotnet_context_data = context_data,
        ref = "@core_sdk//:core/packs/Microsoft.NETCore.App.Ref/3.1.0/ref/netcoreapp3.1/System.ServiceModel.Web.dll",
        stdlib_path = "@core_sdk//:core/shared/Microsoft.NETCore.App/3.1.0/System.ServiceModel.Web.dll",
        deps = [
            ":p1_system.runtime.dll",
            ":p1_system.runtime.serialization.json.dll",
        ]
    )
    core_stdlib(
        name = "p1_system.serviceprocess.dll",
        dotnet_context_data = context_data,
        ref = "@core_sdk//:core/packs/Microsoft.NETCore.App.Ref/3.1.0/ref/netcoreapp3.1/System.ServiceProcess.dll",
        stdlib_path = "@core_sdk//:core/shared/Microsoft.NETCore.App/3.1.0/System.ServiceProcess.dll",
        deps = [
            ":p1_system.runtime.dll",
        ]
    )
    core_stdlib(
        name = "p1_system.text.encoding.codepages.dll",
        dotnet_context_data = context_data,
        ref = "@core_sdk//:core/packs/Microsoft.NETCore.App.Ref/3.1.0/ref/netcoreapp3.1/System.Text.Encoding.CodePages.dll",
        stdlib_path = "@core_sdk//:core/shared/Microsoft.NETCore.App/3.1.0/System.Text.Encoding.CodePages.dll",
        deps = [
            ":p1_netstandard.dll",
        ]
    )
    core_stdlib(
        name = "p1_system.text.encoding.dll",
        dotnet_context_data = context_data,
        ref = "@core_sdk//:core/packs/Microsoft.NETCore.App.Ref/3.1.0/ref/netcoreapp3.1/System.Text.Encoding.dll",
        stdlib_path = "@core_sdk//:core/shared/Microsoft.NETCore.App/3.1.0/System.Text.Encoding.dll",
        deps = [
            ":p1_system.runtime.dll",
        ]
    )
    core_stdlib(
        name = "p1_system.text.encoding.extensions.dll",
        dotnet_context_data = context_data,
        ref = "@core_sdk//:core/packs/Microsoft.NETCore.App.Ref/3.1.0/ref/netcoreapp3.1/System.Text.Encoding.Extensions.dll",
        stdlib_path = "@core_sdk//:core/shared/Microsoft.NETCore.App/3.1.0/System.Text.Encoding.Extensions.dll",
        deps = [
            ":p1_system.runtime.dll",
        ]
    )
    core_stdlib(
        name = "p1_system.text.encodings.web.dll",
        dotnet_context_data = context_data,
        ref = "@core_sdk//:core/packs/Microsoft.NETCore.App.Ref/3.1.0/ref/netcoreapp3.1/System.Text.Encodings.Web.dll",
        stdlib_path = "@core_sdk//:core/shared/Microsoft.NETCore.App/3.1.0/System.Text.Encodings.Web.dll",
        deps = [
            ":p1_system.runtime.dll",
            ":p1_system.runtime.extensions.dll",
        ]
    )
    core_stdlib(
        name = "p1_system.text.json.dll",
        dotnet_context_data = context_data,
        ref = "@core_sdk//:core/packs/Microsoft.NETCore.App.Ref/3.1.0/ref/netcoreapp3.1/System.Text.Json.dll",
        stdlib_path = "@core_sdk//:core/shared/Microsoft.NETCore.App/3.1.0/System.Text.Json.dll",
        deps = [
            ":p1_system.runtime.dll",
            ":p1_system.memory.dll",
            ":p1_system.text.encodings.web.dll",
        ]
    )
    core_stdlib(
        name = "p1_system.text.regularexpressions.dll",
        dotnet_context_data = context_data,
        ref = "@core_sdk//:core/packs/Microsoft.NETCore.App.Ref/3.1.0/ref/netcoreapp3.1/System.Text.RegularExpressions.dll",
        stdlib_path = "@core_sdk//:core/shared/Microsoft.NETCore.App/3.1.0/System.Text.RegularExpressions.dll",
        deps = [
            ":p1_system.runtime.dll",
            ":p1_system.runtime.extensions.dll",
            ":p1_system.reflection.emit.ilgeneration.dll",
        ]
    )
    core_stdlib(
        name = "p1_system.threading.channels.dll",
        dotnet_context_data = context_data,
        ref = "@core_sdk//:core/packs/Microsoft.NETCore.App.Ref/3.1.0/ref/netcoreapp3.1/System.Threading.Channels.dll",
        stdlib_path = "@core_sdk//:core/shared/Microsoft.NETCore.App/3.1.0/System.Threading.Channels.dll",
        deps = [
            ":p1_system.runtime.dll",
        ]
    )
    core_stdlib(
        name = "p1_system.threading.dll",
        dotnet_context_data = context_data,
        ref = "@core_sdk//:core/packs/Microsoft.NETCore.App.Ref/3.1.0/ref/netcoreapp3.1/System.Threading.dll",
        stdlib_path = "@core_sdk//:core/shared/Microsoft.NETCore.App/3.1.0/System.Threading.dll",
        deps = [
            ":p1_system.runtime.dll",
        ]
    )
    core_stdlib(
        name = "p1_system.threading.overlapped.dll",
        dotnet_context_data = context_data,
        ref = "@core_sdk//:core/packs/Microsoft.NETCore.App.Ref/3.1.0/ref/netcoreapp3.1/System.Threading.Overlapped.dll",
        stdlib_path = "@core_sdk//:core/shared/Microsoft.NETCore.App/3.1.0/System.Threading.Overlapped.dll",
        deps = [
            ":p1_system.runtime.dll",
        ]
    )
    core_stdlib(
        name = "p1_system.threading.tasks.dataflow.dll",
        dotnet_context_data = context_data,
        ref = "@core_sdk//:core/packs/Microsoft.NETCore.App.Ref/3.1.0/ref/netcoreapp3.1/System.Threading.Tasks.Dataflow.dll",
        stdlib_path = "@core_sdk//:core/shared/Microsoft.NETCore.App/3.1.0/System.Threading.Tasks.Dataflow.dll",
        deps = [
            ":p1_netstandard.dll",
        ]
    )
    core_stdlib(
        name = "p1_system.threading.tasks.dll",
        dotnet_context_data = context_data,
        ref = "@core_sdk//:core/packs/Microsoft.NETCore.App.Ref/3.1.0/ref/netcoreapp3.1/System.Threading.Tasks.dll",
        stdlib_path = "@core_sdk//:core/shared/Microsoft.NETCore.App/3.1.0/System.Threading.Tasks.dll",
        deps = [
            ":p1_system.runtime.dll",
        ]
    )
    core_stdlib(
        name = "p1_system.threading.tasks.extensions.dll",
        dotnet_context_data = context_data,
        ref = "@core_sdk//:core/packs/Microsoft.NETCore.App.Ref/3.1.0/ref/netcoreapp3.1/System.Threading.Tasks.Extensions.dll",
        stdlib_path = "@core_sdk//:core/shared/Microsoft.NETCore.App/3.1.0/System.Threading.Tasks.Extensions.dll",
        deps = [
            ":p1_system.runtime.dll",
        ]
    )
    core_stdlib(
        name = "p1_system.threading.tasks.parallel.dll",
        dotnet_context_data = context_data,
        ref = "@core_sdk//:core/packs/Microsoft.NETCore.App.Ref/3.1.0/ref/netcoreapp3.1/System.Threading.Tasks.Parallel.dll",
        stdlib_path = "@core_sdk//:core/shared/Microsoft.NETCore.App/3.1.0/System.Threading.Tasks.Parallel.dll",
        deps = [
            ":p1_system.runtime.dll",
            ":p1_system.collections.concurrent.dll",
        ]
    )
    core_stdlib(
        name = "p1_system.threading.thread.dll",
        dotnet_context_data = context_data,
        ref = "@core_sdk//:core/packs/Microsoft.NETCore.App.Ref/3.1.0/ref/netcoreapp3.1/System.Threading.Thread.dll",
        stdlib_path = "@core_sdk//:core/shared/Microsoft.NETCore.App/3.1.0/System.Threading.Thread.dll",
        deps = [
            ":p1_system.runtime.dll",
            ":p1_system.threading.dll",
            ":p1_system.security.principal.dll",
            ":p1_system.runtime.extensions.dll",
        ]
    )
    core_stdlib(
        name = "p1_system.threading.threadpool.dll",
        dotnet_context_data = context_data,
        ref = "@core_sdk//:core/packs/Microsoft.NETCore.App.Ref/3.1.0/ref/netcoreapp3.1/System.Threading.ThreadPool.dll",
        stdlib_path = "@core_sdk//:core/shared/Microsoft.NETCore.App/3.1.0/System.Threading.ThreadPool.dll",
        deps = [
            ":p1_system.runtime.dll",
            ":p1_system.threading.overlapped.dll",
        ]
    )
    core_stdlib(
        name = "p1_system.threading.timer.dll",
        dotnet_context_data = context_data,
        ref = "@core_sdk//:core/packs/Microsoft.NETCore.App.Ref/3.1.0/ref/netcoreapp3.1/System.Threading.Timer.dll",
        stdlib_path = "@core_sdk//:core/shared/Microsoft.NETCore.App/3.1.0/System.Threading.Timer.dll",
        deps = [
            ":p1_system.runtime.dll",
        ]
    )
    core_stdlib(
        name = "p1_system.transactions.dll",
        dotnet_context_data = context_data,
        ref = "@core_sdk//:core/packs/Microsoft.NETCore.App.Ref/3.1.0/ref/netcoreapp3.1/System.Transactions.dll",
        stdlib_path = "@core_sdk//:core/shared/Microsoft.NETCore.App/3.1.0/System.Transactions.dll",
        deps = [
            ":p1_system.runtime.dll",
            ":p1_system.transactions.local.dll",
        ]
    )
    core_stdlib(
        name = "p1_system.transactions.local.dll",
        dotnet_context_data = context_data,
        ref = "@core_sdk//:core/packs/Microsoft.NETCore.App.Ref/3.1.0/ref/netcoreapp3.1/System.Transactions.Local.dll",
        stdlib_path = "@core_sdk//:core/shared/Microsoft.NETCore.App/3.1.0/System.Transactions.Local.dll",
        deps = [
            ":p1_system.runtime.dll",
            ":p1_system.runtime.interopservices.dll",
        ]
    )
    core_stdlib(
        name = "p1_system.valuetuple.dll",
        dotnet_context_data = context_data,
        ref = "@core_sdk//:core/packs/Microsoft.NETCore.App.Ref/3.1.0/ref/netcoreapp3.1/System.ValueTuple.dll",
        stdlib_path = "@core_sdk//:core/shared/Microsoft.NETCore.App/3.1.0/System.ValueTuple.dll",
        deps = [
            ":p1_system.runtime.dll",
        ]
    )
    core_stdlib(
        name = "p1_system.web.dll",
        dotnet_context_data = context_data,
        ref = "@core_sdk//:core/packs/Microsoft.NETCore.App.Ref/3.1.0/ref/netcoreapp3.1/System.Web.dll",
        stdlib_path = "@core_sdk//:core/shared/Microsoft.NETCore.App/3.1.0/System.Web.dll",
        deps = [
            ":p1_system.runtime.dll",
            ":p1_system.web.httputility.dll",
        ]
    )
    core_stdlib(
        name = "p1_system.web.httputility.dll",
        dotnet_context_data = context_data,
        ref = "@core_sdk//:core/packs/Microsoft.NETCore.App.Ref/3.1.0/ref/netcoreapp3.1/System.Web.HttpUtility.dll",
        stdlib_path = "@core_sdk//:core/shared/Microsoft.NETCore.App/3.1.0/System.Web.HttpUtility.dll",
        deps = [
            ":p1_system.runtime.dll",
            ":p1_system.runtime.extensions.dll",
            ":p1_system.collections.specialized.dll",
        ]
    )
    core_stdlib(
        name = "p1_system.windows.dll",
        dotnet_context_data = context_data,
        ref = "@core_sdk//:core/packs/Microsoft.NETCore.App.Ref/3.1.0/ref/netcoreapp3.1/System.Windows.dll",
        stdlib_path = "@core_sdk//:core/shared/Microsoft.NETCore.App/3.1.0/System.Windows.dll",
        deps = [
            ":p1_system.runtime.dll",
            ":p1_system.objectmodel.dll",
        ]
    )
    core_stdlib(
        name = "p1_system.xml.dll",
        dotnet_context_data = context_data,
        ref = "@core_sdk//:core/packs/Microsoft.NETCore.App.Ref/3.1.0/ref/netcoreapp3.1/System.Xml.dll",
        stdlib_path = "@core_sdk//:core/shared/Microsoft.NETCore.App/3.1.0/System.Xml.dll",
        deps = [
            ":p1_system.runtime.dll",
            ":p1_system.xml.readerwriter.dll",
            ":p1_system.xml.xmlserializer.dll",
            ":p1_system.xml.xpath.dll",
        ]
    )
    core_stdlib(
        name = "p1_system.xml.linq.dll",
        dotnet_context_data = context_data,
        ref = "@core_sdk//:core/packs/Microsoft.NETCore.App.Ref/3.1.0/ref/netcoreapp3.1/System.Xml.Linq.dll",
        stdlib_path = "@core_sdk//:core/shared/Microsoft.NETCore.App/3.1.0/System.Xml.Linq.dll",
        deps = [
            ":p1_system.runtime.dll",
            ":p1_system.xml.xdocument.dll",
            ":p1_system.xml.xpath.xdocument.dll",
        ]
    )
    core_stdlib(
        name = "p1_system.xml.readerwriter.dll",
        dotnet_context_data = context_data,
        ref = "@core_sdk//:core/packs/Microsoft.NETCore.App.Ref/3.1.0/ref/netcoreapp3.1/System.Xml.ReaderWriter.dll",
        stdlib_path = "@core_sdk//:core/shared/Microsoft.NETCore.App/3.1.0/System.Xml.ReaderWriter.dll",
        deps = [
            ":p1_system.runtime.dll",
            ":p1_system.runtime.extensions.dll",
            ":p1_system.diagnostics.debug.dll",
            ":p1_system.net.primitives.dll",
            ":p1_system.collections.nongeneric.dll",
        ]
    )
    core_stdlib(
        name = "p1_system.xml.serialization.dll",
        dotnet_context_data = context_data,
        ref = "@core_sdk//:core/packs/Microsoft.NETCore.App.Ref/3.1.0/ref/netcoreapp3.1/System.Xml.Serialization.dll",
        stdlib_path = "@core_sdk//:core/shared/Microsoft.NETCore.App/3.1.0/System.Xml.Serialization.dll",
        deps = [
            ":p1_system.runtime.dll",
            ":p1_system.xml.readerwriter.dll",
            ":p1_system.xml.xmlserializer.dll",
        ]
    )
    core_stdlib(
        name = "p1_system.xml.xdocument.dll",
        dotnet_context_data = context_data,
        ref = "@core_sdk//:core/packs/Microsoft.NETCore.App.Ref/3.1.0/ref/netcoreapp3.1/System.Xml.XDocument.dll",
        stdlib_path = "@core_sdk//:core/shared/Microsoft.NETCore.App/3.1.0/System.Xml.XDocument.dll",
        deps = [
            ":p1_system.runtime.dll",
            ":p1_system.xml.readerwriter.dll",
            ":p1_system.runtime.extensions.dll",
        ]
    )
    core_stdlib(
        name = "p1_system.xml.xmldocument.dll",
        dotnet_context_data = context_data,
        ref = "@core_sdk//:core/packs/Microsoft.NETCore.App.Ref/3.1.0/ref/netcoreapp3.1/System.Xml.XmlDocument.dll",
        stdlib_path = "@core_sdk//:core/shared/Microsoft.NETCore.App/3.1.0/System.Xml.XmlDocument.dll",
        deps = [
            ":p1_system.runtime.dll",
            ":p1_system.xml.readerwriter.dll",
        ]
    )
    core_stdlib(
        name = "p1_system.xml.xmlserializer.dll",
        dotnet_context_data = context_data,
        ref = "@core_sdk//:core/packs/Microsoft.NETCore.App.Ref/3.1.0/ref/netcoreapp3.1/System.Xml.XmlSerializer.dll",
        stdlib_path = "@core_sdk//:core/shared/Microsoft.NETCore.App/3.1.0/System.Xml.XmlSerializer.dll",
        deps = [
            ":p1_system.runtime.dll",
            ":p1_system.collections.specialized.dll",
            ":p1_system.xml.readerwriter.dll",
            ":p1_system.collections.nongeneric.dll",
            ":p1_system.runtime.extensions.dll",
        ]
    )
    core_stdlib(
        name = "p1_system.xml.xpath.dll",
        dotnet_context_data = context_data,
        ref = "@core_sdk//:core/packs/Microsoft.NETCore.App.Ref/3.1.0/ref/netcoreapp3.1/System.Xml.XPath.dll",
        stdlib_path = "@core_sdk//:core/shared/Microsoft.NETCore.App/3.1.0/System.Xml.XPath.dll",
        deps = [
            ":p1_system.runtime.dll",
            ":p1_system.xml.readerwriter.dll",
            ":p1_system.runtime.extensions.dll",
        ]
    )
    core_stdlib(
        name = "p1_system.xml.xpath.xdocument.dll",
        dotnet_context_data = context_data,
        ref = "@core_sdk//:core/packs/Microsoft.NETCore.App.Ref/3.1.0/ref/netcoreapp3.1/System.Xml.XPath.XDocument.dll",
        stdlib_path = "@core_sdk//:core/shared/Microsoft.NETCore.App/3.1.0/System.Xml.XPath.XDocument.dll",
        deps = [
            ":p1_system.runtime.dll",
            ":p1_system.xml.readerwriter.dll",
            ":p1_system.xml.xdocument.dll",
        ]
    )
    core_stdlib(
        name = "p1_windowsbase.dll",
        dotnet_context_data = context_data,
        ref = "@core_sdk//:core/packs/Microsoft.NETCore.App.Ref/3.1.0/ref/netcoreapp3.1/WindowsBase.dll",
        stdlib_path = "@core_sdk//:core/shared/Microsoft.NETCore.App/3.1.0/WindowsBase.dll",
        deps = [
            ":p1_system.runtime.dll",
            ":p1_system.objectmodel.dll",
        ]
    )
    core_libraryset(
        name = "NETStandard.Library",
        dotnet_context_data = context_data,
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
            ":p2_system.componentmodel.composition.dll",
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
    core_stdlib(
        name = "p2_microsoft.win32.primitives.dll",
        dotnet_context_data = context_data,
        ref = "@core_sdk//:core/packs/NETStandard.Library.Ref/2.1.0/ref/netstandard2.1/Microsoft.Win32.Primitives.dll",
        stdlib_path = "@core_sdk//:core/shared/Microsoft.NETCore.App/3.1.0/Microsoft.Win32.Primitives.dll",
        deps = [
            ":p2_netstandard.dll",
        ]
    )
    core_stdlib(
        name = "p2_mscorlib.dll",
        dotnet_context_data = context_data,
        ref = "@core_sdk//:core/packs/NETStandard.Library.Ref/2.1.0/ref/netstandard2.1/mscorlib.dll",
        stdlib_path = "@core_sdk//:core/shared/Microsoft.NETCore.App/3.1.0/mscorlib.dll",
        deps = [
            ":p2_netstandard.dll",
        ]
    )
    core_stdlib(
        name = "p2_netstandard.dll",
        dotnet_context_data = context_data,
        ref = "@core_sdk//:core/packs/NETStandard.Library.Ref/2.1.0/ref/netstandard2.1/netstandard.dll",
        stdlib_path = "@core_sdk//:core/shared/Microsoft.NETCore.App/3.1.0/netstandard.dll",
        deps = [
        ]
    )
    core_stdlib(
        name = "p2_system.appcontext.dll",
        dotnet_context_data = context_data,
        ref = "@core_sdk//:core/packs/NETStandard.Library.Ref/2.1.0/ref/netstandard2.1/System.AppContext.dll",
        stdlib_path = "@core_sdk//:core/shared/Microsoft.NETCore.App/3.1.0/System.AppContext.dll",
        deps = [
            ":p2_netstandard.dll",
        ]
    )
    core_stdlib(
        name = "p2_system.buffers.dll",
        dotnet_context_data = context_data,
        ref = "@core_sdk//:core/packs/NETStandard.Library.Ref/2.1.0/ref/netstandard2.1/System.Buffers.dll",
        stdlib_path = "@core_sdk//:core/shared/Microsoft.NETCore.App/3.1.0/System.Buffers.dll",
        deps = [
            ":p2_netstandard.dll",
        ]
    )
    core_stdlib(
        name = "p2_system.collections.concurrent.dll",
        dotnet_context_data = context_data,
        ref = "@core_sdk//:core/packs/NETStandard.Library.Ref/2.1.0/ref/netstandard2.1/System.Collections.Concurrent.dll",
        stdlib_path = "@core_sdk//:core/shared/Microsoft.NETCore.App/3.1.0/System.Collections.Concurrent.dll",
        deps = [
            ":p2_netstandard.dll",
        ]
    )
    core_stdlib(
        name = "p2_system.collections.dll",
        dotnet_context_data = context_data,
        ref = "@core_sdk//:core/packs/NETStandard.Library.Ref/2.1.0/ref/netstandard2.1/System.Collections.dll",
        stdlib_path = "@core_sdk//:core/shared/Microsoft.NETCore.App/3.1.0/System.Collections.dll",
        deps = [
            ":p2_netstandard.dll",
        ]
    )
    core_stdlib(
        name = "p2_system.collections.nongeneric.dll",
        dotnet_context_data = context_data,
        ref = "@core_sdk//:core/packs/NETStandard.Library.Ref/2.1.0/ref/netstandard2.1/System.Collections.NonGeneric.dll",
        stdlib_path = "@core_sdk//:core/shared/Microsoft.NETCore.App/3.1.0/System.Collections.NonGeneric.dll",
        deps = [
            ":p2_netstandard.dll",
        ]
    )
    core_stdlib(
        name = "p2_system.collections.specialized.dll",
        dotnet_context_data = context_data,
        ref = "@core_sdk//:core/packs/NETStandard.Library.Ref/2.1.0/ref/netstandard2.1/System.Collections.Specialized.dll",
        stdlib_path = "@core_sdk//:core/shared/Microsoft.NETCore.App/3.1.0/System.Collections.Specialized.dll",
        deps = [
            ":p2_netstandard.dll",
        ]
    )
    core_stdlib(
        name = "p2_system.componentmodel.composition.dll",
        dotnet_context_data = context_data,
        ref = "@core_sdk//:core/packs/NETStandard.Library.Ref/2.1.0/ref/netstandard2.1/System.ComponentModel.Composition.dll",
        deps = [
            ":p2_netstandard.dll",
        ]
    )
    core_stdlib(
        name = "p2_system.componentmodel.dll",
        dotnet_context_data = context_data,
        ref = "@core_sdk//:core/packs/NETStandard.Library.Ref/2.1.0/ref/netstandard2.1/System.ComponentModel.dll",
        stdlib_path = "@core_sdk//:core/shared/Microsoft.NETCore.App/3.1.0/System.ComponentModel.dll",
        deps = [
            ":p2_netstandard.dll",
        ]
    )
    core_stdlib(
        name = "p2_system.componentmodel.eventbasedasync.dll",
        dotnet_context_data = context_data,
        ref = "@core_sdk//:core/packs/NETStandard.Library.Ref/2.1.0/ref/netstandard2.1/System.ComponentModel.EventBasedAsync.dll",
        stdlib_path = "@core_sdk//:core/shared/Microsoft.NETCore.App/3.1.0/System.ComponentModel.EventBasedAsync.dll",
        deps = [
            ":p2_netstandard.dll",
        ]
    )
    core_stdlib(
        name = "p2_system.componentmodel.primitives.dll",
        dotnet_context_data = context_data,
        ref = "@core_sdk//:core/packs/NETStandard.Library.Ref/2.1.0/ref/netstandard2.1/System.ComponentModel.Primitives.dll",
        stdlib_path = "@core_sdk//:core/shared/Microsoft.NETCore.App/3.1.0/System.ComponentModel.Primitives.dll",
        deps = [
            ":p2_netstandard.dll",
        ]
    )
    core_stdlib(
        name = "p2_system.componentmodel.typeconverter.dll",
        dotnet_context_data = context_data,
        ref = "@core_sdk//:core/packs/NETStandard.Library.Ref/2.1.0/ref/netstandard2.1/System.ComponentModel.TypeConverter.dll",
        stdlib_path = "@core_sdk//:core/shared/Microsoft.NETCore.App/3.1.0/System.ComponentModel.TypeConverter.dll",
        deps = [
            ":p2_netstandard.dll",
        ]
    )
    core_stdlib(
        name = "p2_system.console.dll",
        dotnet_context_data = context_data,
        ref = "@core_sdk//:core/packs/NETStandard.Library.Ref/2.1.0/ref/netstandard2.1/System.Console.dll",
        stdlib_path = "@core_sdk//:core/shared/Microsoft.NETCore.App/3.1.0/System.Console.dll",
        deps = [
            ":p2_netstandard.dll",
        ]
    )
    core_stdlib(
        name = "p2_system.core.dll",
        dotnet_context_data = context_data,
        ref = "@core_sdk//:core/packs/NETStandard.Library.Ref/2.1.0/ref/netstandard2.1/System.Core.dll",
        stdlib_path = "@core_sdk//:core/shared/Microsoft.NETCore.App/3.1.0/System.Core.dll",
        deps = [
            ":p2_netstandard.dll",
        ]
    )
    core_stdlib(
        name = "p2_system.data.common.dll",
        dotnet_context_data = context_data,
        ref = "@core_sdk//:core/packs/NETStandard.Library.Ref/2.1.0/ref/netstandard2.1/System.Data.Common.dll",
        stdlib_path = "@core_sdk//:core/shared/Microsoft.NETCore.App/3.1.0/System.Data.Common.dll",
        deps = [
            ":p2_netstandard.dll",
        ]
    )
    core_stdlib(
        name = "p2_system.data.dll",
        dotnet_context_data = context_data,
        ref = "@core_sdk//:core/packs/NETStandard.Library.Ref/2.1.0/ref/netstandard2.1/System.Data.dll",
        stdlib_path = "@core_sdk//:core/shared/Microsoft.NETCore.App/3.1.0/System.Data.dll",
        deps = [
            ":p2_netstandard.dll",
        ]
    )
    core_stdlib(
        name = "p2_system.diagnostics.contracts.dll",
        dotnet_context_data = context_data,
        ref = "@core_sdk//:core/packs/NETStandard.Library.Ref/2.1.0/ref/netstandard2.1/System.Diagnostics.Contracts.dll",
        stdlib_path = "@core_sdk//:core/shared/Microsoft.NETCore.App/3.1.0/System.Diagnostics.Contracts.dll",
        deps = [
            ":p2_netstandard.dll",
        ]
    )
    core_stdlib(
        name = "p2_system.diagnostics.debug.dll",
        dotnet_context_data = context_data,
        ref = "@core_sdk//:core/packs/NETStandard.Library.Ref/2.1.0/ref/netstandard2.1/System.Diagnostics.Debug.dll",
        stdlib_path = "@core_sdk//:core/shared/Microsoft.NETCore.App/3.1.0/System.Diagnostics.Debug.dll",
        deps = [
            ":p2_netstandard.dll",
        ]
    )
    core_stdlib(
        name = "p2_system.diagnostics.fileversioninfo.dll",
        dotnet_context_data = context_data,
        ref = "@core_sdk//:core/packs/NETStandard.Library.Ref/2.1.0/ref/netstandard2.1/System.Diagnostics.FileVersionInfo.dll",
        stdlib_path = "@core_sdk//:core/shared/Microsoft.NETCore.App/3.1.0/System.Diagnostics.FileVersionInfo.dll",
        deps = [
            ":p2_netstandard.dll",
        ]
    )
    core_stdlib(
        name = "p2_system.diagnostics.process.dll",
        dotnet_context_data = context_data,
        ref = "@core_sdk//:core/packs/NETStandard.Library.Ref/2.1.0/ref/netstandard2.1/System.Diagnostics.Process.dll",
        stdlib_path = "@core_sdk//:core/shared/Microsoft.NETCore.App/3.1.0/System.Diagnostics.Process.dll",
        deps = [
            ":p2_netstandard.dll",
        ]
    )
    core_stdlib(
        name = "p2_system.diagnostics.stacktrace.dll",
        dotnet_context_data = context_data,
        ref = "@core_sdk//:core/packs/NETStandard.Library.Ref/2.1.0/ref/netstandard2.1/System.Diagnostics.StackTrace.dll",
        stdlib_path = "@core_sdk//:core/shared/Microsoft.NETCore.App/3.1.0/System.Diagnostics.StackTrace.dll",
        deps = [
            ":p2_netstandard.dll",
        ]
    )
    core_stdlib(
        name = "p2_system.diagnostics.textwritertracelistener.dll",
        dotnet_context_data = context_data,
        ref = "@core_sdk//:core/packs/NETStandard.Library.Ref/2.1.0/ref/netstandard2.1/System.Diagnostics.TextWriterTraceListener.dll",
        stdlib_path = "@core_sdk//:core/shared/Microsoft.NETCore.App/3.1.0/System.Diagnostics.TextWriterTraceListener.dll",
        deps = [
            ":p2_netstandard.dll",
        ]
    )
    core_stdlib(
        name = "p2_system.diagnostics.tools.dll",
        dotnet_context_data = context_data,
        ref = "@core_sdk//:core/packs/NETStandard.Library.Ref/2.1.0/ref/netstandard2.1/System.Diagnostics.Tools.dll",
        stdlib_path = "@core_sdk//:core/shared/Microsoft.NETCore.App/3.1.0/System.Diagnostics.Tools.dll",
        deps = [
            ":p2_netstandard.dll",
        ]
    )
    core_stdlib(
        name = "p2_system.diagnostics.tracesource.dll",
        dotnet_context_data = context_data,
        ref = "@core_sdk//:core/packs/NETStandard.Library.Ref/2.1.0/ref/netstandard2.1/System.Diagnostics.TraceSource.dll",
        stdlib_path = "@core_sdk//:core/shared/Microsoft.NETCore.App/3.1.0/System.Diagnostics.TraceSource.dll",
        deps = [
            ":p2_netstandard.dll",
        ]
    )
    core_stdlib(
        name = "p2_system.diagnostics.tracing.dll",
        dotnet_context_data = context_data,
        ref = "@core_sdk//:core/packs/NETStandard.Library.Ref/2.1.0/ref/netstandard2.1/System.Diagnostics.Tracing.dll",
        stdlib_path = "@core_sdk//:core/shared/Microsoft.NETCore.App/3.1.0/System.Diagnostics.Tracing.dll",
        deps = [
            ":p2_netstandard.dll",
        ]
    )
    core_stdlib(
        name = "p2_system.dll",
        dotnet_context_data = context_data,
        ref = "@core_sdk//:core/packs/NETStandard.Library.Ref/2.1.0/ref/netstandard2.1/System.dll",
        stdlib_path = "@core_sdk//:core/shared/Microsoft.NETCore.App/3.1.0/System.dll",
        deps = [
            ":p2_netstandard.dll",
        ]
    )
    core_stdlib(
        name = "p2_system.drawing.dll",
        dotnet_context_data = context_data,
        ref = "@core_sdk//:core/packs/NETStandard.Library.Ref/2.1.0/ref/netstandard2.1/System.Drawing.dll",
        stdlib_path = "@core_sdk//:core/shared/Microsoft.NETCore.App/3.1.0/System.Drawing.dll",
        deps = [
            ":p2_netstandard.dll",
        ]
    )
    core_stdlib(
        name = "p2_system.drawing.primitives.dll",
        dotnet_context_data = context_data,
        ref = "@core_sdk//:core/packs/NETStandard.Library.Ref/2.1.0/ref/netstandard2.1/System.Drawing.Primitives.dll",
        stdlib_path = "@core_sdk//:core/shared/Microsoft.NETCore.App/3.1.0/System.Drawing.Primitives.dll",
        deps = [
            ":p2_netstandard.dll",
        ]
    )
    core_stdlib(
        name = "p2_system.dynamic.runtime.dll",
        dotnet_context_data = context_data,
        ref = "@core_sdk//:core/packs/NETStandard.Library.Ref/2.1.0/ref/netstandard2.1/System.Dynamic.Runtime.dll",
        stdlib_path = "@core_sdk//:core/shared/Microsoft.NETCore.App/3.1.0/System.Dynamic.Runtime.dll",
        deps = [
            ":p2_netstandard.dll",
        ]
    )
    core_stdlib(
        name = "p2_system.globalization.calendars.dll",
        dotnet_context_data = context_data,
        ref = "@core_sdk//:core/packs/NETStandard.Library.Ref/2.1.0/ref/netstandard2.1/System.Globalization.Calendars.dll",
        stdlib_path = "@core_sdk//:core/shared/Microsoft.NETCore.App/3.1.0/System.Globalization.Calendars.dll",
        deps = [
            ":p2_netstandard.dll",
        ]
    )
    core_stdlib(
        name = "p2_system.globalization.dll",
        dotnet_context_data = context_data,
        ref = "@core_sdk//:core/packs/NETStandard.Library.Ref/2.1.0/ref/netstandard2.1/System.Globalization.dll",
        stdlib_path = "@core_sdk//:core/shared/Microsoft.NETCore.App/3.1.0/System.Globalization.dll",
        deps = [
            ":p2_netstandard.dll",
        ]
    )
    core_stdlib(
        name = "p2_system.globalization.extensions.dll",
        dotnet_context_data = context_data,
        ref = "@core_sdk//:core/packs/NETStandard.Library.Ref/2.1.0/ref/netstandard2.1/System.Globalization.Extensions.dll",
        stdlib_path = "@core_sdk//:core/shared/Microsoft.NETCore.App/3.1.0/System.Globalization.Extensions.dll",
        deps = [
            ":p2_netstandard.dll",
        ]
    )
    core_stdlib(
        name = "p2_system.io.compression.dll",
        dotnet_context_data = context_data,
        ref = "@core_sdk//:core/packs/NETStandard.Library.Ref/2.1.0/ref/netstandard2.1/System.IO.Compression.dll",
        stdlib_path = "@core_sdk//:core/shared/Microsoft.NETCore.App/3.1.0/System.IO.Compression.dll",
        deps = [
            ":p2_netstandard.dll",
        ]
    )
    core_stdlib(
        name = "p2_system.io.compression.filesystem.dll",
        dotnet_context_data = context_data,
        ref = "@core_sdk//:core/packs/NETStandard.Library.Ref/2.1.0/ref/netstandard2.1/System.IO.Compression.FileSystem.dll",
        stdlib_path = "@core_sdk//:core/shared/Microsoft.NETCore.App/3.1.0/System.IO.Compression.FileSystem.dll",
        deps = [
            ":p2_netstandard.dll",
        ]
    )
    core_stdlib(
        name = "p2_system.io.compression.zipfile.dll",
        dotnet_context_data = context_data,
        ref = "@core_sdk//:core/packs/NETStandard.Library.Ref/2.1.0/ref/netstandard2.1/System.IO.Compression.ZipFile.dll",
        stdlib_path = "@core_sdk//:core/shared/Microsoft.NETCore.App/3.1.0/System.IO.Compression.ZipFile.dll",
        deps = [
            ":p2_netstandard.dll",
        ]
    )
    core_stdlib(
        name = "p2_system.io.dll",
        dotnet_context_data = context_data,
        ref = "@core_sdk//:core/packs/NETStandard.Library.Ref/2.1.0/ref/netstandard2.1/System.IO.dll",
        stdlib_path = "@core_sdk//:core/shared/Microsoft.NETCore.App/3.1.0/System.IO.dll",
        deps = [
            ":p2_netstandard.dll",
        ]
    )
    core_stdlib(
        name = "p2_system.io.filesystem.dll",
        dotnet_context_data = context_data,
        ref = "@core_sdk//:core/packs/NETStandard.Library.Ref/2.1.0/ref/netstandard2.1/System.IO.FileSystem.dll",
        stdlib_path = "@core_sdk//:core/shared/Microsoft.NETCore.App/3.1.0/System.IO.FileSystem.dll",
        deps = [
            ":p2_netstandard.dll",
        ]
    )
    core_stdlib(
        name = "p2_system.io.filesystem.driveinfo.dll",
        dotnet_context_data = context_data,
        ref = "@core_sdk//:core/packs/NETStandard.Library.Ref/2.1.0/ref/netstandard2.1/System.IO.FileSystem.DriveInfo.dll",
        stdlib_path = "@core_sdk//:core/shared/Microsoft.NETCore.App/3.1.0/System.IO.FileSystem.DriveInfo.dll",
        deps = [
            ":p2_netstandard.dll",
        ]
    )
    core_stdlib(
        name = "p2_system.io.filesystem.primitives.dll",
        dotnet_context_data = context_data,
        ref = "@core_sdk//:core/packs/NETStandard.Library.Ref/2.1.0/ref/netstandard2.1/System.IO.FileSystem.Primitives.dll",
        stdlib_path = "@core_sdk//:core/shared/Microsoft.NETCore.App/3.1.0/System.IO.FileSystem.Primitives.dll",
        deps = [
            ":p2_netstandard.dll",
        ]
    )
    core_stdlib(
        name = "p2_system.io.filesystem.watcher.dll",
        dotnet_context_data = context_data,
        ref = "@core_sdk//:core/packs/NETStandard.Library.Ref/2.1.0/ref/netstandard2.1/System.IO.FileSystem.Watcher.dll",
        stdlib_path = "@core_sdk//:core/shared/Microsoft.NETCore.App/3.1.0/System.IO.FileSystem.Watcher.dll",
        deps = [
            ":p2_netstandard.dll",
        ]
    )
    core_stdlib(
        name = "p2_system.io.isolatedstorage.dll",
        dotnet_context_data = context_data,
        ref = "@core_sdk//:core/packs/NETStandard.Library.Ref/2.1.0/ref/netstandard2.1/System.IO.IsolatedStorage.dll",
        stdlib_path = "@core_sdk//:core/shared/Microsoft.NETCore.App/3.1.0/System.IO.IsolatedStorage.dll",
        deps = [
            ":p2_netstandard.dll",
        ]
    )
    core_stdlib(
        name = "p2_system.io.memorymappedfiles.dll",
        dotnet_context_data = context_data,
        ref = "@core_sdk//:core/packs/NETStandard.Library.Ref/2.1.0/ref/netstandard2.1/System.IO.MemoryMappedFiles.dll",
        stdlib_path = "@core_sdk//:core/shared/Microsoft.NETCore.App/3.1.0/System.IO.MemoryMappedFiles.dll",
        deps = [
            ":p2_netstandard.dll",
        ]
    )
    core_stdlib(
        name = "p2_system.io.pipes.dll",
        dotnet_context_data = context_data,
        ref = "@core_sdk//:core/packs/NETStandard.Library.Ref/2.1.0/ref/netstandard2.1/System.IO.Pipes.dll",
        stdlib_path = "@core_sdk//:core/shared/Microsoft.NETCore.App/3.1.0/System.IO.Pipes.dll",
        deps = [
            ":p2_netstandard.dll",
        ]
    )
    core_stdlib(
        name = "p2_system.io.unmanagedmemorystream.dll",
        dotnet_context_data = context_data,
        ref = "@core_sdk//:core/packs/NETStandard.Library.Ref/2.1.0/ref/netstandard2.1/System.IO.UnmanagedMemoryStream.dll",
        stdlib_path = "@core_sdk//:core/shared/Microsoft.NETCore.App/3.1.0/System.IO.UnmanagedMemoryStream.dll",
        deps = [
            ":p2_netstandard.dll",
        ]
    )
    core_stdlib(
        name = "p2_system.linq.dll",
        dotnet_context_data = context_data,
        ref = "@core_sdk//:core/packs/NETStandard.Library.Ref/2.1.0/ref/netstandard2.1/System.Linq.dll",
        stdlib_path = "@core_sdk//:core/shared/Microsoft.NETCore.App/3.1.0/System.Linq.dll",
        deps = [
            ":p2_netstandard.dll",
        ]
    )
    core_stdlib(
        name = "p2_system.linq.expressions.dll",
        dotnet_context_data = context_data,
        ref = "@core_sdk//:core/packs/NETStandard.Library.Ref/2.1.0/ref/netstandard2.1/System.Linq.Expressions.dll",
        stdlib_path = "@core_sdk//:core/shared/Microsoft.NETCore.App/3.1.0/System.Linq.Expressions.dll",
        deps = [
            ":p2_netstandard.dll",
        ]
    )
    core_stdlib(
        name = "p2_system.linq.parallel.dll",
        dotnet_context_data = context_data,
        ref = "@core_sdk//:core/packs/NETStandard.Library.Ref/2.1.0/ref/netstandard2.1/System.Linq.Parallel.dll",
        stdlib_path = "@core_sdk//:core/shared/Microsoft.NETCore.App/3.1.0/System.Linq.Parallel.dll",
        deps = [
            ":p2_netstandard.dll",
        ]
    )
    core_stdlib(
        name = "p2_system.linq.queryable.dll",
        dotnet_context_data = context_data,
        ref = "@core_sdk//:core/packs/NETStandard.Library.Ref/2.1.0/ref/netstandard2.1/System.Linq.Queryable.dll",
        stdlib_path = "@core_sdk//:core/shared/Microsoft.NETCore.App/3.1.0/System.Linq.Queryable.dll",
        deps = [
            ":p2_netstandard.dll",
        ]
    )
    core_stdlib(
        name = "p2_system.memory.dll",
        dotnet_context_data = context_data,
        ref = "@core_sdk//:core/packs/NETStandard.Library.Ref/2.1.0/ref/netstandard2.1/System.Memory.dll",
        stdlib_path = "@core_sdk//:core/shared/Microsoft.NETCore.App/3.1.0/System.Memory.dll",
        deps = [
            ":p2_netstandard.dll",
        ]
    )
    core_stdlib(
        name = "p2_system.net.dll",
        dotnet_context_data = context_data,
        ref = "@core_sdk//:core/packs/NETStandard.Library.Ref/2.1.0/ref/netstandard2.1/System.Net.dll",
        stdlib_path = "@core_sdk//:core/shared/Microsoft.NETCore.App/3.1.0/System.Net.dll",
        deps = [
            ":p2_netstandard.dll",
        ]
    )
    core_stdlib(
        name = "p2_system.net.http.dll",
        dotnet_context_data = context_data,
        ref = "@core_sdk//:core/packs/NETStandard.Library.Ref/2.1.0/ref/netstandard2.1/System.Net.Http.dll",
        stdlib_path = "@core_sdk//:core/shared/Microsoft.NETCore.App/3.1.0/System.Net.Http.dll",
        deps = [
            ":p2_netstandard.dll",
        ]
    )
    core_stdlib(
        name = "p2_system.net.nameresolution.dll",
        dotnet_context_data = context_data,
        ref = "@core_sdk//:core/packs/NETStandard.Library.Ref/2.1.0/ref/netstandard2.1/System.Net.NameResolution.dll",
        stdlib_path = "@core_sdk//:core/shared/Microsoft.NETCore.App/3.1.0/System.Net.NameResolution.dll",
        deps = [
            ":p2_netstandard.dll",
        ]
    )
    core_stdlib(
        name = "p2_system.net.networkinformation.dll",
        dotnet_context_data = context_data,
        ref = "@core_sdk//:core/packs/NETStandard.Library.Ref/2.1.0/ref/netstandard2.1/System.Net.NetworkInformation.dll",
        stdlib_path = "@core_sdk//:core/shared/Microsoft.NETCore.App/3.1.0/System.Net.NetworkInformation.dll",
        deps = [
            ":p2_netstandard.dll",
        ]
    )
    core_stdlib(
        name = "p2_system.net.ping.dll",
        dotnet_context_data = context_data,
        ref = "@core_sdk//:core/packs/NETStandard.Library.Ref/2.1.0/ref/netstandard2.1/System.Net.Ping.dll",
        stdlib_path = "@core_sdk//:core/shared/Microsoft.NETCore.App/3.1.0/System.Net.Ping.dll",
        deps = [
            ":p2_netstandard.dll",
        ]
    )
    core_stdlib(
        name = "p2_system.net.primitives.dll",
        dotnet_context_data = context_data,
        ref = "@core_sdk//:core/packs/NETStandard.Library.Ref/2.1.0/ref/netstandard2.1/System.Net.Primitives.dll",
        stdlib_path = "@core_sdk//:core/shared/Microsoft.NETCore.App/3.1.0/System.Net.Primitives.dll",
        deps = [
            ":p2_netstandard.dll",
        ]
    )
    core_stdlib(
        name = "p2_system.net.requests.dll",
        dotnet_context_data = context_data,
        ref = "@core_sdk//:core/packs/NETStandard.Library.Ref/2.1.0/ref/netstandard2.1/System.Net.Requests.dll",
        stdlib_path = "@core_sdk//:core/shared/Microsoft.NETCore.App/3.1.0/System.Net.Requests.dll",
        deps = [
            ":p2_netstandard.dll",
        ]
    )
    core_stdlib(
        name = "p2_system.net.security.dll",
        dotnet_context_data = context_data,
        ref = "@core_sdk//:core/packs/NETStandard.Library.Ref/2.1.0/ref/netstandard2.1/System.Net.Security.dll",
        stdlib_path = "@core_sdk//:core/shared/Microsoft.NETCore.App/3.1.0/System.Net.Security.dll",
        deps = [
            ":p2_netstandard.dll",
        ]
    )
    core_stdlib(
        name = "p2_system.net.sockets.dll",
        dotnet_context_data = context_data,
        ref = "@core_sdk//:core/packs/NETStandard.Library.Ref/2.1.0/ref/netstandard2.1/System.Net.Sockets.dll",
        stdlib_path = "@core_sdk//:core/shared/Microsoft.NETCore.App/3.1.0/System.Net.Sockets.dll",
        deps = [
            ":p2_netstandard.dll",
        ]
    )
    core_stdlib(
        name = "p2_system.net.webheadercollection.dll",
        dotnet_context_data = context_data,
        ref = "@core_sdk//:core/packs/NETStandard.Library.Ref/2.1.0/ref/netstandard2.1/System.Net.WebHeaderCollection.dll",
        stdlib_path = "@core_sdk//:core/shared/Microsoft.NETCore.App/3.1.0/System.Net.WebHeaderCollection.dll",
        deps = [
            ":p2_netstandard.dll",
        ]
    )
    core_stdlib(
        name = "p2_system.net.websockets.client.dll",
        dotnet_context_data = context_data,
        ref = "@core_sdk//:core/packs/NETStandard.Library.Ref/2.1.0/ref/netstandard2.1/System.Net.WebSockets.Client.dll",
        stdlib_path = "@core_sdk//:core/shared/Microsoft.NETCore.App/3.1.0/System.Net.WebSockets.Client.dll",
        deps = [
            ":p2_netstandard.dll",
        ]
    )
    core_stdlib(
        name = "p2_system.net.websockets.dll",
        dotnet_context_data = context_data,
        ref = "@core_sdk//:core/packs/NETStandard.Library.Ref/2.1.0/ref/netstandard2.1/System.Net.WebSockets.dll",
        stdlib_path = "@core_sdk//:core/shared/Microsoft.NETCore.App/3.1.0/System.Net.WebSockets.dll",
        deps = [
            ":p2_netstandard.dll",
        ]
    )
    core_stdlib(
        name = "p2_system.numerics.dll",
        dotnet_context_data = context_data,
        ref = "@core_sdk//:core/packs/NETStandard.Library.Ref/2.1.0/ref/netstandard2.1/System.Numerics.dll",
        stdlib_path = "@core_sdk//:core/shared/Microsoft.NETCore.App/3.1.0/System.Numerics.dll",
        deps = [
            ":p2_netstandard.dll",
        ]
    )
    core_stdlib(
        name = "p2_system.numerics.vectors.dll",
        dotnet_context_data = context_data,
        ref = "@core_sdk//:core/packs/NETStandard.Library.Ref/2.1.0/ref/netstandard2.1/System.Numerics.Vectors.dll",
        stdlib_path = "@core_sdk//:core/shared/Microsoft.NETCore.App/3.1.0/System.Numerics.Vectors.dll",
        deps = [
            ":p2_netstandard.dll",
        ]
    )
    core_stdlib(
        name = "p2_system.objectmodel.dll",
        dotnet_context_data = context_data,
        ref = "@core_sdk//:core/packs/NETStandard.Library.Ref/2.1.0/ref/netstandard2.1/System.ObjectModel.dll",
        stdlib_path = "@core_sdk//:core/shared/Microsoft.NETCore.App/3.1.0/System.ObjectModel.dll",
        deps = [
            ":p2_netstandard.dll",
        ]
    )
    core_stdlib(
        name = "p2_system.reflection.dispatchproxy.dll",
        dotnet_context_data = context_data,
        ref = "@core_sdk//:core/packs/NETStandard.Library.Ref/2.1.0/ref/netstandard2.1/System.Reflection.DispatchProxy.dll",
        stdlib_path = "@core_sdk//:core/shared/Microsoft.NETCore.App/3.1.0/System.Reflection.DispatchProxy.dll",
        deps = [
            ":p2_netstandard.dll",
        ]
    )
    core_stdlib(
        name = "p2_system.reflection.dll",
        dotnet_context_data = context_data,
        ref = "@core_sdk//:core/packs/NETStandard.Library.Ref/2.1.0/ref/netstandard2.1/System.Reflection.dll",
        stdlib_path = "@core_sdk//:core/shared/Microsoft.NETCore.App/3.1.0/System.Reflection.dll",
        deps = [
            ":p2_netstandard.dll",
        ]
    )
    core_stdlib(
        name = "p2_system.reflection.emit.dll",
        dotnet_context_data = context_data,
        ref = "@core_sdk//:core/packs/NETStandard.Library.Ref/2.1.0/ref/netstandard2.1/System.Reflection.Emit.dll",
        stdlib_path = "@core_sdk//:core/shared/Microsoft.NETCore.App/3.1.0/System.Reflection.Emit.dll",
        deps = [
            ":p2_netstandard.dll",
        ]
    )
    core_stdlib(
        name = "p2_system.reflection.emit.ilgeneration.dll",
        dotnet_context_data = context_data,
        ref = "@core_sdk//:core/packs/NETStandard.Library.Ref/2.1.0/ref/netstandard2.1/System.Reflection.Emit.ILGeneration.dll",
        stdlib_path = "@core_sdk//:core/shared/Microsoft.NETCore.App/3.1.0/System.Reflection.Emit.ILGeneration.dll",
        deps = [
            ":p2_netstandard.dll",
        ]
    )
    core_stdlib(
        name = "p2_system.reflection.emit.lightweight.dll",
        dotnet_context_data = context_data,
        ref = "@core_sdk//:core/packs/NETStandard.Library.Ref/2.1.0/ref/netstandard2.1/System.Reflection.Emit.Lightweight.dll",
        stdlib_path = "@core_sdk//:core/shared/Microsoft.NETCore.App/3.1.0/System.Reflection.Emit.Lightweight.dll",
        deps = [
            ":p2_netstandard.dll",
        ]
    )
    core_stdlib(
        name = "p2_system.reflection.extensions.dll",
        dotnet_context_data = context_data,
        ref = "@core_sdk//:core/packs/NETStandard.Library.Ref/2.1.0/ref/netstandard2.1/System.Reflection.Extensions.dll",
        stdlib_path = "@core_sdk//:core/shared/Microsoft.NETCore.App/3.1.0/System.Reflection.Extensions.dll",
        deps = [
            ":p2_netstandard.dll",
        ]
    )
    core_stdlib(
        name = "p2_system.reflection.primitives.dll",
        dotnet_context_data = context_data,
        ref = "@core_sdk//:core/packs/NETStandard.Library.Ref/2.1.0/ref/netstandard2.1/System.Reflection.Primitives.dll",
        stdlib_path = "@core_sdk//:core/shared/Microsoft.NETCore.App/3.1.0/System.Reflection.Primitives.dll",
        deps = [
            ":p2_netstandard.dll",
        ]
    )
    core_stdlib(
        name = "p2_system.resources.reader.dll",
        dotnet_context_data = context_data,
        ref = "@core_sdk//:core/packs/NETStandard.Library.Ref/2.1.0/ref/netstandard2.1/System.Resources.Reader.dll",
        stdlib_path = "@core_sdk//:core/shared/Microsoft.NETCore.App/3.1.0/System.Resources.Reader.dll",
        deps = [
            ":p2_netstandard.dll",
        ]
    )
    core_stdlib(
        name = "p2_system.resources.resourcemanager.dll",
        dotnet_context_data = context_data,
        ref = "@core_sdk//:core/packs/NETStandard.Library.Ref/2.1.0/ref/netstandard2.1/System.Resources.ResourceManager.dll",
        stdlib_path = "@core_sdk//:core/shared/Microsoft.NETCore.App/3.1.0/System.Resources.ResourceManager.dll",
        deps = [
            ":p2_netstandard.dll",
        ]
    )
    core_stdlib(
        name = "p2_system.resources.writer.dll",
        dotnet_context_data = context_data,
        ref = "@core_sdk//:core/packs/NETStandard.Library.Ref/2.1.0/ref/netstandard2.1/System.Resources.Writer.dll",
        stdlib_path = "@core_sdk//:core/shared/Microsoft.NETCore.App/3.1.0/System.Resources.Writer.dll",
        deps = [
            ":p2_netstandard.dll",
        ]
    )
    core_stdlib(
        name = "p2_system.runtime.compilerservices.visualc.dll",
        dotnet_context_data = context_data,
        ref = "@core_sdk//:core/packs/NETStandard.Library.Ref/2.1.0/ref/netstandard2.1/System.Runtime.CompilerServices.VisualC.dll",
        stdlib_path = "@core_sdk//:core/shared/Microsoft.NETCore.App/3.1.0/System.Runtime.CompilerServices.VisualC.dll",
        deps = [
            ":p2_netstandard.dll",
        ]
    )
    core_stdlib(
        name = "p2_system.runtime.dll",
        dotnet_context_data = context_data,
        ref = "@core_sdk//:core/packs/NETStandard.Library.Ref/2.1.0/ref/netstandard2.1/System.Runtime.dll",
        stdlib_path = "@core_sdk//:core/shared/Microsoft.NETCore.App/3.1.0/System.Runtime.dll",
        deps = [
            ":p2_netstandard.dll",
        ]
    )
    core_stdlib(
        name = "p2_system.runtime.extensions.dll",
        dotnet_context_data = context_data,
        ref = "@core_sdk//:core/packs/NETStandard.Library.Ref/2.1.0/ref/netstandard2.1/System.Runtime.Extensions.dll",
        stdlib_path = "@core_sdk//:core/shared/Microsoft.NETCore.App/3.1.0/System.Runtime.Extensions.dll",
        deps = [
            ":p2_netstandard.dll",
        ]
    )
    core_stdlib(
        name = "p2_system.runtime.handles.dll",
        dotnet_context_data = context_data,
        ref = "@core_sdk//:core/packs/NETStandard.Library.Ref/2.1.0/ref/netstandard2.1/System.Runtime.Handles.dll",
        stdlib_path = "@core_sdk//:core/shared/Microsoft.NETCore.App/3.1.0/System.Runtime.Handles.dll",
        deps = [
            ":p2_netstandard.dll",
        ]
    )
    core_stdlib(
        name = "p2_system.runtime.interopservices.dll",
        dotnet_context_data = context_data,
        ref = "@core_sdk//:core/packs/NETStandard.Library.Ref/2.1.0/ref/netstandard2.1/System.Runtime.InteropServices.dll",
        stdlib_path = "@core_sdk//:core/shared/Microsoft.NETCore.App/3.1.0/System.Runtime.InteropServices.dll",
        deps = [
            ":p2_netstandard.dll",
        ]
    )
    core_stdlib(
        name = "p2_system.runtime.interopservices.runtimeinformation.dll",
        dotnet_context_data = context_data,
        ref = "@core_sdk//:core/packs/NETStandard.Library.Ref/2.1.0/ref/netstandard2.1/System.Runtime.InteropServices.RuntimeInformation.dll",
        stdlib_path = "@core_sdk//:core/shared/Microsoft.NETCore.App/3.1.0/System.Runtime.InteropServices.RuntimeInformation.dll",
        deps = [
            ":p2_netstandard.dll",
        ]
    )
    core_stdlib(
        name = "p2_system.runtime.numerics.dll",
        dotnet_context_data = context_data,
        ref = "@core_sdk//:core/packs/NETStandard.Library.Ref/2.1.0/ref/netstandard2.1/System.Runtime.Numerics.dll",
        stdlib_path = "@core_sdk//:core/shared/Microsoft.NETCore.App/3.1.0/System.Runtime.Numerics.dll",
        deps = [
            ":p2_netstandard.dll",
        ]
    )
    core_stdlib(
        name = "p2_system.runtime.serialization.dll",
        dotnet_context_data = context_data,
        ref = "@core_sdk//:core/packs/NETStandard.Library.Ref/2.1.0/ref/netstandard2.1/System.Runtime.Serialization.dll",
        stdlib_path = "@core_sdk//:core/shared/Microsoft.NETCore.App/3.1.0/System.Runtime.Serialization.dll",
        deps = [
            ":p2_netstandard.dll",
        ]
    )
    core_stdlib(
        name = "p2_system.runtime.serialization.formatters.dll",
        dotnet_context_data = context_data,
        ref = "@core_sdk//:core/packs/NETStandard.Library.Ref/2.1.0/ref/netstandard2.1/System.Runtime.Serialization.Formatters.dll",
        stdlib_path = "@core_sdk//:core/shared/Microsoft.NETCore.App/3.1.0/System.Runtime.Serialization.Formatters.dll",
        deps = [
            ":p2_netstandard.dll",
        ]
    )
    core_stdlib(
        name = "p2_system.runtime.serialization.json.dll",
        dotnet_context_data = context_data,
        ref = "@core_sdk//:core/packs/NETStandard.Library.Ref/2.1.0/ref/netstandard2.1/System.Runtime.Serialization.Json.dll",
        stdlib_path = "@core_sdk//:core/shared/Microsoft.NETCore.App/3.1.0/System.Runtime.Serialization.Json.dll",
        deps = [
            ":p2_netstandard.dll",
        ]
    )
    core_stdlib(
        name = "p2_system.runtime.serialization.primitives.dll",
        dotnet_context_data = context_data,
        ref = "@core_sdk//:core/packs/NETStandard.Library.Ref/2.1.0/ref/netstandard2.1/System.Runtime.Serialization.Primitives.dll",
        stdlib_path = "@core_sdk//:core/shared/Microsoft.NETCore.App/3.1.0/System.Runtime.Serialization.Primitives.dll",
        deps = [
            ":p2_netstandard.dll",
        ]
    )
    core_stdlib(
        name = "p2_system.runtime.serialization.xml.dll",
        dotnet_context_data = context_data,
        ref = "@core_sdk//:core/packs/NETStandard.Library.Ref/2.1.0/ref/netstandard2.1/System.Runtime.Serialization.Xml.dll",
        stdlib_path = "@core_sdk//:core/shared/Microsoft.NETCore.App/3.1.0/System.Runtime.Serialization.Xml.dll",
        deps = [
            ":p2_netstandard.dll",
        ]
    )
    core_stdlib(
        name = "p2_system.security.claims.dll",
        dotnet_context_data = context_data,
        ref = "@core_sdk//:core/packs/NETStandard.Library.Ref/2.1.0/ref/netstandard2.1/System.Security.Claims.dll",
        stdlib_path = "@core_sdk//:core/shared/Microsoft.NETCore.App/3.1.0/System.Security.Claims.dll",
        deps = [
            ":p2_netstandard.dll",
        ]
    )
    core_stdlib(
        name = "p2_system.security.cryptography.algorithms.dll",
        dotnet_context_data = context_data,
        ref = "@core_sdk//:core/packs/NETStandard.Library.Ref/2.1.0/ref/netstandard2.1/System.Security.Cryptography.Algorithms.dll",
        stdlib_path = "@core_sdk//:core/shared/Microsoft.NETCore.App/3.1.0/System.Security.Cryptography.Algorithms.dll",
        deps = [
            ":p2_netstandard.dll",
        ]
    )
    core_stdlib(
        name = "p2_system.security.cryptography.csp.dll",
        dotnet_context_data = context_data,
        ref = "@core_sdk//:core/packs/NETStandard.Library.Ref/2.1.0/ref/netstandard2.1/System.Security.Cryptography.Csp.dll",
        stdlib_path = "@core_sdk//:core/shared/Microsoft.NETCore.App/3.1.0/System.Security.Cryptography.Csp.dll",
        deps = [
            ":p2_netstandard.dll",
        ]
    )
    core_stdlib(
        name = "p2_system.security.cryptography.encoding.dll",
        dotnet_context_data = context_data,
        ref = "@core_sdk//:core/packs/NETStandard.Library.Ref/2.1.0/ref/netstandard2.1/System.Security.Cryptography.Encoding.dll",
        stdlib_path = "@core_sdk//:core/shared/Microsoft.NETCore.App/3.1.0/System.Security.Cryptography.Encoding.dll",
        deps = [
            ":p2_netstandard.dll",
        ]
    )
    core_stdlib(
        name = "p2_system.security.cryptography.primitives.dll",
        dotnet_context_data = context_data,
        ref = "@core_sdk//:core/packs/NETStandard.Library.Ref/2.1.0/ref/netstandard2.1/System.Security.Cryptography.Primitives.dll",
        stdlib_path = "@core_sdk//:core/shared/Microsoft.NETCore.App/3.1.0/System.Security.Cryptography.Primitives.dll",
        deps = [
            ":p2_netstandard.dll",
        ]
    )
    core_stdlib(
        name = "p2_system.security.cryptography.x509certificates.dll",
        dotnet_context_data = context_data,
        ref = "@core_sdk//:core/packs/NETStandard.Library.Ref/2.1.0/ref/netstandard2.1/System.Security.Cryptography.X509Certificates.dll",
        stdlib_path = "@core_sdk//:core/shared/Microsoft.NETCore.App/3.1.0/System.Security.Cryptography.X509Certificates.dll",
        deps = [
            ":p2_netstandard.dll",
        ]
    )
    core_stdlib(
        name = "p2_system.security.principal.dll",
        dotnet_context_data = context_data,
        ref = "@core_sdk//:core/packs/NETStandard.Library.Ref/2.1.0/ref/netstandard2.1/System.Security.Principal.dll",
        stdlib_path = "@core_sdk//:core/shared/Microsoft.NETCore.App/3.1.0/System.Security.Principal.dll",
        deps = [
            ":p2_netstandard.dll",
        ]
    )
    core_stdlib(
        name = "p2_system.security.securestring.dll",
        dotnet_context_data = context_data,
        ref = "@core_sdk//:core/packs/NETStandard.Library.Ref/2.1.0/ref/netstandard2.1/System.Security.SecureString.dll",
        stdlib_path = "@core_sdk//:core/shared/Microsoft.NETCore.App/3.1.0/System.Security.SecureString.dll",
        deps = [
            ":p2_netstandard.dll",
        ]
    )
    core_stdlib(
        name = "p2_system.servicemodel.web.dll",
        dotnet_context_data = context_data,
        ref = "@core_sdk//:core/packs/NETStandard.Library.Ref/2.1.0/ref/netstandard2.1/System.ServiceModel.Web.dll",
        stdlib_path = "@core_sdk//:core/shared/Microsoft.NETCore.App/3.1.0/System.ServiceModel.Web.dll",
        deps = [
            ":p2_netstandard.dll",
        ]
    )
    core_stdlib(
        name = "p2_system.text.encoding.dll",
        dotnet_context_data = context_data,
        ref = "@core_sdk//:core/packs/NETStandard.Library.Ref/2.1.0/ref/netstandard2.1/System.Text.Encoding.dll",
        stdlib_path = "@core_sdk//:core/shared/Microsoft.NETCore.App/3.1.0/System.Text.Encoding.dll",
        deps = [
            ":p2_netstandard.dll",
        ]
    )
    core_stdlib(
        name = "p2_system.text.encoding.extensions.dll",
        dotnet_context_data = context_data,
        ref = "@core_sdk//:core/packs/NETStandard.Library.Ref/2.1.0/ref/netstandard2.1/System.Text.Encoding.Extensions.dll",
        stdlib_path = "@core_sdk//:core/shared/Microsoft.NETCore.App/3.1.0/System.Text.Encoding.Extensions.dll",
        deps = [
            ":p2_netstandard.dll",
        ]
    )
    core_stdlib(
        name = "p2_system.text.regularexpressions.dll",
        dotnet_context_data = context_data,
        ref = "@core_sdk//:core/packs/NETStandard.Library.Ref/2.1.0/ref/netstandard2.1/System.Text.RegularExpressions.dll",
        stdlib_path = "@core_sdk//:core/shared/Microsoft.NETCore.App/3.1.0/System.Text.RegularExpressions.dll",
        deps = [
            ":p2_netstandard.dll",
        ]
    )
    core_stdlib(
        name = "p2_system.threading.dll",
        dotnet_context_data = context_data,
        ref = "@core_sdk//:core/packs/NETStandard.Library.Ref/2.1.0/ref/netstandard2.1/System.Threading.dll",
        stdlib_path = "@core_sdk//:core/shared/Microsoft.NETCore.App/3.1.0/System.Threading.dll",
        deps = [
            ":p2_netstandard.dll",
        ]
    )
    core_stdlib(
        name = "p2_system.threading.overlapped.dll",
        dotnet_context_data = context_data,
        ref = "@core_sdk//:core/packs/NETStandard.Library.Ref/2.1.0/ref/netstandard2.1/System.Threading.Overlapped.dll",
        stdlib_path = "@core_sdk//:core/shared/Microsoft.NETCore.App/3.1.0/System.Threading.Overlapped.dll",
        deps = [
            ":p2_netstandard.dll",
        ]
    )
    core_stdlib(
        name = "p2_system.threading.tasks.dll",
        dotnet_context_data = context_data,
        ref = "@core_sdk//:core/packs/NETStandard.Library.Ref/2.1.0/ref/netstandard2.1/System.Threading.Tasks.dll",
        stdlib_path = "@core_sdk//:core/shared/Microsoft.NETCore.App/3.1.0/System.Threading.Tasks.dll",
        deps = [
            ":p2_netstandard.dll",
        ]
    )
    core_stdlib(
        name = "p2_system.threading.tasks.extensions.dll",
        dotnet_context_data = context_data,
        ref = "@core_sdk//:core/packs/NETStandard.Library.Ref/2.1.0/ref/netstandard2.1/System.Threading.Tasks.Extensions.dll",
        stdlib_path = "@core_sdk//:core/shared/Microsoft.NETCore.App/3.1.0/System.Threading.Tasks.Extensions.dll",
        deps = [
            ":p2_netstandard.dll",
        ]
    )
    core_stdlib(
        name = "p2_system.threading.tasks.parallel.dll",
        dotnet_context_data = context_data,
        ref = "@core_sdk//:core/packs/NETStandard.Library.Ref/2.1.0/ref/netstandard2.1/System.Threading.Tasks.Parallel.dll",
        stdlib_path = "@core_sdk//:core/shared/Microsoft.NETCore.App/3.1.0/System.Threading.Tasks.Parallel.dll",
        deps = [
            ":p2_netstandard.dll",
        ]
    )
    core_stdlib(
        name = "p2_system.threading.thread.dll",
        dotnet_context_data = context_data,
        ref = "@core_sdk//:core/packs/NETStandard.Library.Ref/2.1.0/ref/netstandard2.1/System.Threading.Thread.dll",
        stdlib_path = "@core_sdk//:core/shared/Microsoft.NETCore.App/3.1.0/System.Threading.Thread.dll",
        deps = [
            ":p2_netstandard.dll",
        ]
    )
    core_stdlib(
        name = "p2_system.threading.threadpool.dll",
        dotnet_context_data = context_data,
        ref = "@core_sdk//:core/packs/NETStandard.Library.Ref/2.1.0/ref/netstandard2.1/System.Threading.ThreadPool.dll",
        stdlib_path = "@core_sdk//:core/shared/Microsoft.NETCore.App/3.1.0/System.Threading.ThreadPool.dll",
        deps = [
            ":p2_netstandard.dll",
        ]
    )
    core_stdlib(
        name = "p2_system.threading.timer.dll",
        dotnet_context_data = context_data,
        ref = "@core_sdk//:core/packs/NETStandard.Library.Ref/2.1.0/ref/netstandard2.1/System.Threading.Timer.dll",
        stdlib_path = "@core_sdk//:core/shared/Microsoft.NETCore.App/3.1.0/System.Threading.Timer.dll",
        deps = [
            ":p2_netstandard.dll",
        ]
    )
    core_stdlib(
        name = "p2_system.transactions.dll",
        dotnet_context_data = context_data,
        ref = "@core_sdk//:core/packs/NETStandard.Library.Ref/2.1.0/ref/netstandard2.1/System.Transactions.dll",
        stdlib_path = "@core_sdk//:core/shared/Microsoft.NETCore.App/3.1.0/System.Transactions.dll",
        deps = [
            ":p2_netstandard.dll",
        ]
    )
    core_stdlib(
        name = "p2_system.valuetuple.dll",
        dotnet_context_data = context_data,
        ref = "@core_sdk//:core/packs/NETStandard.Library.Ref/2.1.0/ref/netstandard2.1/System.ValueTuple.dll",
        stdlib_path = "@core_sdk//:core/shared/Microsoft.NETCore.App/3.1.0/System.ValueTuple.dll",
        deps = [
            ":p2_netstandard.dll",
        ]
    )
    core_stdlib(
        name = "p2_system.web.dll",
        dotnet_context_data = context_data,
        ref = "@core_sdk//:core/packs/NETStandard.Library.Ref/2.1.0/ref/netstandard2.1/System.Web.dll",
        stdlib_path = "@core_sdk//:core/shared/Microsoft.NETCore.App/3.1.0/System.Web.dll",
        deps = [
            ":p2_netstandard.dll",
        ]
    )
    core_stdlib(
        name = "p2_system.windows.dll",
        dotnet_context_data = context_data,
        ref = "@core_sdk//:core/packs/NETStandard.Library.Ref/2.1.0/ref/netstandard2.1/System.Windows.dll",
        stdlib_path = "@core_sdk//:core/shared/Microsoft.NETCore.App/3.1.0/System.Windows.dll",
        deps = [
            ":p2_netstandard.dll",
        ]
    )
    core_stdlib(
        name = "p2_system.xml.dll",
        dotnet_context_data = context_data,
        ref = "@core_sdk//:core/packs/NETStandard.Library.Ref/2.1.0/ref/netstandard2.1/System.Xml.dll",
        stdlib_path = "@core_sdk//:core/shared/Microsoft.NETCore.App/3.1.0/System.Xml.dll",
        deps = [
            ":p2_netstandard.dll",
        ]
    )
    core_stdlib(
        name = "p2_system.xml.linq.dll",
        dotnet_context_data = context_data,
        ref = "@core_sdk//:core/packs/NETStandard.Library.Ref/2.1.0/ref/netstandard2.1/System.Xml.Linq.dll",
        stdlib_path = "@core_sdk//:core/shared/Microsoft.NETCore.App/3.1.0/System.Xml.Linq.dll",
        deps = [
            ":p2_netstandard.dll",
        ]
    )
    core_stdlib(
        name = "p2_system.xml.readerwriter.dll",
        dotnet_context_data = context_data,
        ref = "@core_sdk//:core/packs/NETStandard.Library.Ref/2.1.0/ref/netstandard2.1/System.Xml.ReaderWriter.dll",
        stdlib_path = "@core_sdk//:core/shared/Microsoft.NETCore.App/3.1.0/System.Xml.ReaderWriter.dll",
        deps = [
            ":p2_netstandard.dll",
        ]
    )
    core_stdlib(
        name = "p2_system.xml.serialization.dll",
        dotnet_context_data = context_data,
        ref = "@core_sdk//:core/packs/NETStandard.Library.Ref/2.1.0/ref/netstandard2.1/System.Xml.Serialization.dll",
        stdlib_path = "@core_sdk//:core/shared/Microsoft.NETCore.App/3.1.0/System.Xml.Serialization.dll",
        deps = [
            ":p2_netstandard.dll",
        ]
    )
    core_stdlib(
        name = "p2_system.xml.xdocument.dll",
        dotnet_context_data = context_data,
        ref = "@core_sdk//:core/packs/NETStandard.Library.Ref/2.1.0/ref/netstandard2.1/System.Xml.XDocument.dll",
        stdlib_path = "@core_sdk//:core/shared/Microsoft.NETCore.App/3.1.0/System.Xml.XDocument.dll",
        deps = [
            ":p2_netstandard.dll",
        ]
    )
    core_stdlib(
        name = "p2_system.xml.xmldocument.dll",
        dotnet_context_data = context_data,
        ref = "@core_sdk//:core/packs/NETStandard.Library.Ref/2.1.0/ref/netstandard2.1/System.Xml.XmlDocument.dll",
        stdlib_path = "@core_sdk//:core/shared/Microsoft.NETCore.App/3.1.0/System.Xml.XmlDocument.dll",
        deps = [
            ":p2_netstandard.dll",
        ]
    )
    core_stdlib(
        name = "p2_system.xml.xmlserializer.dll",
        dotnet_context_data = context_data,
        ref = "@core_sdk//:core/packs/NETStandard.Library.Ref/2.1.0/ref/netstandard2.1/System.Xml.XmlSerializer.dll",
        stdlib_path = "@core_sdk//:core/shared/Microsoft.NETCore.App/3.1.0/System.Xml.XmlSerializer.dll",
        deps = [
            ":p2_netstandard.dll",
        ]
    )
    core_stdlib(
        name = "p2_system.xml.xpath.dll",
        dotnet_context_data = context_data,
        ref = "@core_sdk//:core/packs/NETStandard.Library.Ref/2.1.0/ref/netstandard2.1/System.Xml.XPath.dll",
        stdlib_path = "@core_sdk//:core/shared/Microsoft.NETCore.App/3.1.0/System.Xml.XPath.dll",
        deps = [
            ":p2_netstandard.dll",
        ]
    )
    core_stdlib(
        name = "p2_system.xml.xpath.xdocument.dll",
        dotnet_context_data = context_data,
        ref = "@core_sdk//:core/packs/NETStandard.Library.Ref/2.1.0/ref/netstandard2.1/System.Xml.XPath.XDocument.dll",
        stdlib_path = "@core_sdk//:core/shared/Microsoft.NETCore.App/3.1.0/System.Xml.XPath.XDocument.dll",
        deps = [
            ":p2_netstandard.dll",
        ]
    )
