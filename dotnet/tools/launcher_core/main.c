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

static void Execute(int argc, char *argv[], const char *manifestDir) {
	char   dotnet[64 * 1024] = {0};
	char   torun[64 * 1024]  = {0};
	char  *p                 = NULL;
	char **newargv           = NULL;

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

	// If torun ends in ".exe", strip it off
	p = strrchr(torun, '.');
	if (p != NULL && (strcmp(p, ".exe") == 0)) {
		*p = '\0';
	}

	// Add the new postfix
	strcat(torun, "_0.dll");

	// Prepare arguments
	newargv = calloc(argc + 2, sizeof(char *));
	if (newargv == NULL) {
		printf("Failed to allocate memory\n");
		exit(-1);
	}

	sprintf(dotnet, "%s/dotnet", manifestDir);
	newargv[0] = dotnet;
	newargv[1] = torun;
	for (int i = 1; i < argc; ++i) {
		newargv[i + 1] = argv[i];
	}
	newargv[argc + 1] = NULL;

	if (IsVerbose()) {
		for (int i = 0; i < argc + 2; ++i) {
			printf("argv[%d] = %s\n", i, newargv[i]);
		}
	}

#ifdef _MSC_VER
	exit(_spawnvp(_P_WAIT, newargv[0], newargv));
#else
	_execvp(newargv[0], newargv);
#endif

	printf("Call failed with errnor %d\n", errno);
}

/*
 * One argument is expected: path to the launcher (to locate the manifest file)
 */
int main(int argc, char *argv[], char *envp[]) {
	const char *manifestDir;
	const char *manifestPath;
	char       *p;

	if (IsVerbose()) {
		printf("Launcher core %s\n", argv[0]);
	}

	Exe = strdup(argv[0]);

	// Normalise the path separators
	for (p = (char *)Exe; *p != '\0'; ++p) {
		if (*p == '\\') {
			*p = '/';
		}
	}

	manifestPath = GetManifestPath();
	if (IsVerbose()) {
		printf("Manifest found %s\n", manifestPath);
	}

	ReadManifestPath(manifestPath);

	manifestDir = strdup(manifestPath);
	p = strrchr(manifestDir, '/');
	if (p == NULL) {
		printf("/ not found in %s\n", manifestDir);
		return -1;
	}
	p[1] = '\0';

	LinkFiles(manifestDir);
	LinkFilesTree(manifestDir);
	LinkHostFxr(manifestDir);

	// Execute should never return - it should transform this process into
	// dotnet, which will handle exiting at some point/
	Execute(argc, argv, manifestDir);

	return -1;
}
