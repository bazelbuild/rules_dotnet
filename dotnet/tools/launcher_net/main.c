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
	char dotnet[64 * 1024], torun[64 * 1024], *p;
	char **newargv = (char **)malloc((argc + 1) * sizeof(char *));
	//char *newargv[1024];
	int i;

	// Based on current exe calculate _0.dll to run
	p = strrchr(Exe, '/');
	sprintf(torun, "%s/%s", manifestDir, p + 1);
	p = strrchr(torun, '.');
	if (p == NULL)
	{
		printf(". not found in %s\n", torun);
		exit(-1);
	}
	strcpy(p, "_0.dll");

	// Prepare arguments
	newargv[0] = torun;
	for (i = 1; i < argc; ++i)
		newargv[i] = argv[i];
	newargv[i] = NULL;

	if (IsVerbose())
	{
		for (i = 0; i < argc + 1; ++i)
			printf("argv[%d] = %s\n", i, newargv[i]);
	}
#ifdef _MSC_VER
	exit(_spawnvp(_P_WAIT, newargv[0], newargv));
#else
	_execvp(newargv[0], newargv);
#endif
	printf("Call failed with errnor %d\n", errno);
}

/* One argument is expected: path to the launcher (to locate the manifest file) */
int main(int argc, char *argv[], char *envp[])
{
	const char *manifestDir, *manifestPath;
	char *p;

	if (IsVerbose())
		printf("Launcher net %s\n", argv[0]);

	Exe = strdup(argv[0]);
	for (p = (char *)Exe; *p != '\0'; ++p)
		if (*p == '\\')
			*p = '/';

	manifestPath = GetManifestPath();
	if (IsVerbose())
		printf("Manifest found %s\n", manifestPath);

	ReadManifestPath(manifestPath);

	manifestDir = strdup(manifestPath);
	p = strrchr(manifestDir, '/');
	if (p == NULL)
	{
		printf("/ not found in %s\n", manifestDir);
		return -1;
	}
	*(p + 1) = '\0';
	LinkFiles(manifestDir);
	LinkFilesTree(manifestDir);
	LinkHostFxr(manifestDir);

	Execute(argc, argv, manifestDir);

	return 0;
}