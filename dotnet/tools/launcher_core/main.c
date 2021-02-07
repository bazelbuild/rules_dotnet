#include <stdio.h>
#include <string.h>
#include <stdlib.h>
#ifdef _MSC_VER
#include <direct.h>
#include <windows.h>
#include <Shlwapi.h>
#include <io.h>
#include <process.h>
#define access _access
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
	char dotnet[64 * 1024] = {0};
	char torun[64 * 1024] = {0};
	char *p = NULL;
	char **newargv = NULL;
	int i;

	// Based on current exe calculate _0.dll to run
	//
	// Either
	//	Exe = <some_prefix>/my_exe_name
	// Or
	//	Exe = <some_prefix>/my_exe_name.exe
	//
	// The path we want to calculate looks like:
	//	torun = <manifestDir>/my_exe_name_0.dll
	p = strrchr(Exe, '/');
	sprintf(torun, "%s/%s", manifestDir, p);

	// If torun ends in "_0.exe", strip it off
	p = strrchr(torun, '_');
	if (p != NULL && (strcmp(p, "_0.exe") == 0))
	{
		*p = '\0';
	}

	// Prepare arguments
	newargv = calloc(argc + 2, sizeof(char *));
	if (newargv == NULL)
	{
		printf("Failed to allocate memory\n");
		exit(-1);
	}

	sprintf(dotnet, "%s/dotnet", manifestDir);
	newargv[0] = dotnet;
	newargv[1] = torun;
	for (i = 1; i < argc; ++i)
	{
		newargv[i + 1] = argv[i];
	}
	newargv[argc + 1] = NULL;

	if (IsVerbose())
	{
		for (i = 0; i < argc + 2; ++i)
			printf("argv[%d] = %s (access: %d)\n", i, newargv[i], newargv[i]!=NULL?access(newargv[i], F_OK):0);
	}

#ifdef _MSC_VER
	/*i = _spawnvp(_P_WAIT, newargv[0], newargv);*/
	i = _spawnvp(_P_WAIT, newargv[0], newargv);
	if (IsVerbose())
		printf("Return code from _spawnvp: %d, errno: %d\n", i, errno);
	exit(i);
#else
	_execvp(newargv[0], newargv);
#endif

	printf("Call failed with errno %d\n", errno);
}

int main(int argc, char *argv[], char *envp[])
{
	const char *manifestDir;
	const char *manifestPath;
	char *p;

	if (IsVerbose())
	{
		printf("Launcher core %s\n", argv[0]);
	}

	Exe = strdup(argv[0]);

	// Normalise the path separators
	for (p = (char *)Exe; *p != '\0'; ++p)
	{
		if (*p == '\\')
		{
			*p = '/';
		}
	}

	manifestPath = strdup(Exe);
	manifestDir = strdup(manifestPath);
	p = strrchr(manifestDir, '/');
	if (p == NULL)
	{
		printf("/ not found in %s\n", manifestDir);
		return -1;
	}
	p[1] = '\0';

	// Execute should never return - it should transform this process into
	// dotnet, which will handle exiting at some point/
	Execute(argc, argv, manifestDir);

	return -1;
}
