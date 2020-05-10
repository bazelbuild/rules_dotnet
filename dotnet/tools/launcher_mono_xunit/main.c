#include <stdio.h>
#include <string.h>
#include <stdlib.h>
#ifdef _MSC_VER
#include <direct.h>
#include <windows.h>
#include <Shlwapi.h>
#include <io.h>
#include <process.h>
#define F_OK 0
#pragma comment(lib, "shlwapi.lib")
#else
#include <unistd.h>
#include <errno.h>
#define _execvp execvp
#endif

#include "dotnet/tools/common/manifest.h"

const char *Exe = NULL;

static void Execute(int argc, char *argv[], const char *manifestDir)
{
	char torun[64 * 1024], *p, xunit[64 * 1024];
	const char *mono;
	char **newargv = (char **)malloc((argc + 5) * sizeof(char *));
	//char *newargv[1024];
	int i;

	// Locate mono runner
	mono = GetLinkedMonoLauncher(manifestDir);

	// xunit runner
	sprintf(xunit, "%s/xunit.console.exe", manifestDir);

	// Based on current exe calculate _0.dll to run
	p = strrchr(Exe, '/');
	sprintf(torun, "%s/%s", manifestDir, p + 1);
	p = strrchr(torun, '_');
	if (p == NULL)
	{
		printf("launcher_mono_xunit: _ not found in %s\n", torun);
		exit(-1);
	}
	*p = '\0';

	// Prepare arguments
	newargv[0] = (char*)mono;
	newargv[1] = xunit;
	newargv[2] = torun;
	newargv[3] = "-junit";
	newargv[4] = getenv("XML_OUTPUT_FILE");
	for (i = 1; i < argc; ++i)
		newargv[i + 4] = argv[i];
	newargv[i + 4] = NULL;

	if (IsVerbose())
	{
		for (i = 0; i < argc + 5; ++i)
			printf("argv[%d] = %s\n", i, newargv[i]);
	}
#ifdef _MSC_VER
	exit(_spawnvp(_P_WAIT, newargv[0], newargv));
#else
	_execvp(newargv[0], newargv);
#endif
	printf("Call failed with errno %d\n", errno);
}

/* One argument is expected: path to the launcher (to locate the manifest file) */
int main(int argc, char *argv[], char *envp[])
{
	const char *manifestDir, *manifestPath;
	char *p;

	if (IsVerbose())
		printf("Launcher mono_xunit %s\n", argv[0]);

	Exe = strdup(argv[0]);
	for (p = (char *)Exe; *p != '\0'; ++p)
		if (*p == '\\')
			*p = '/';

	manifestPath = strdup(Exe);
	manifestDir = strdup(manifestPath);
	p = strrchr(manifestDir, '/');
	if (p == NULL)
	{
		printf("/ not found in %s\n", manifestDir);
		return -1;
	}
	*(p + 1) = '\0';

	Execute(argc, argv, manifestDir);

	return 0;
}