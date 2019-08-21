using System;
using System.Collections.Generic;
using System.Text;
using NuGet.Common;
using NuGet.Configuration;

namespace nuget2bazel
{
    public class MachineWideSettings : IMachineWideSettings
    {
        private readonly Lazy<IEnumerable<Settings>> _settings;

        public MachineWideSettings()
        {
            var baseDirectory = NuGetEnvironment.GetFolderPath(NuGetFolderPath.MachineWideConfigDirectory);
            _settings = new Lazy<IEnumerable<Settings>>(
                () => global::NuGet.Configuration.Settings.LoadMachineWideSettings(baseDirectory));
        }

        public IEnumerable<Settings> Settings => _settings.Value;

    }
}
