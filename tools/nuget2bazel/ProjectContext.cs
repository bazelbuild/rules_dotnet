using System;
using System.Collections.Generic;
using System.Text;
using System.Xml.Linq;
using NuGet.Common;
using NuGet.Configuration;
using NuGet.Packaging;
using NuGet.Packaging.PackageExtraction;
using NuGet.Packaging.Signing;
using NuGet.ProjectManagement;

namespace nuget2bazel
{
    public class ProjectContext : INuGetProjectContext
    {
        private Logger logger = new Logger();

        public ProjectContext(ISettings settings)
        {
            var policy = ClientPolicyContext.GetClientPolicy(settings, logger);
            PackageExtractionContext = new PackageExtractionContext(
                PackageSaveMode.Defaultv3,
                PackageExtractionBehavior.XmlDocFileSaveMode,
                policy,
                logger);
        }

        public void Log(MessageLevel level, string message, params object[] args)
        {
            logger.Log(LogLevel.Debug, string.Format(message, args));
        }

        public void Log(ILogMessage message)
        {
            logger.Log(message);
        }

        public void ReportError(ILogMessage message)
        {
            logger.Log(message);
        }

        public FileConflictAction ResolveFileConflict(string message) => FileConflictAction.Ignore;

        public PackageExtractionContext PackageExtractionContext { get; set; }

        public XDocument OriginalPackagesConfig { get; set; }

        public ISourceControlManagerProvider SourceControlManagerProvider => null;

        public ExecutionContext ExecutionContext => null;

        public void ReportError(string message)
        {
        }

        public NuGetActionType ActionType { get; set; }
        public Guid OperationId { get; set; }
        //public TelemetryServiceHelper TelemetryService
        //{
        //    get => null; set => throw new NotImplementedException();
        //}
    }
}
