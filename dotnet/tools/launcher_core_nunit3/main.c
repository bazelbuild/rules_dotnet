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

#ifdef _MSC_VER
static void LaunchProcess(int argc, char *argv[], const char *workingDir)
{
	STARTUPINFO info;
	PROCESS_INFORMATION pi;
	BOOL r;
	DWORD rc;

	ZeroMemory(&info, sizeof(info));
	ZeroMemory(&pi, sizeof(pi));
	info.cb = sizeof(info);

	char commandline[32 * 1024];
	if (strchr(argv[0], ' ') != NULL)
		sprintf(commandline, "\"%s\"", argv[0]);
	else
		strcpy(commandline, argv[0]);

	for (int i = 1; i < argc; ++i)
	{
		strcat(commandline, " ");
		if (strchr(argv[i], ' ') != NULL)
		{
			strcat(commandline, "\"");
			strcat(commandline, argv[i]);
			strcat(commandline, "\"");
		}
		else
		{
			strcat(commandline, argv[i]);
		}
	}

	r = CreateProcess(NULL, commandline, NULL, NULL, TRUE, 0, NULL, workingDir, &info, &pi);
	if (!r)
	{
		printf("CreateProcess failed (%d).\n", GetLastError());
		exit(-1);
	}

	// Wait until child process exits.
	WaitForSingleObject(pi.hProcess, INFINITE);

	r = GetExitCodeProcess(pi.hProcess, &rc);
	if (!r)
	{
		printf("GetExitCodeProcess failed (%d).\n", GetLastError());
		exit(-1);
	}

	// Close process and thread handles.
	CloseHandle(pi.hProcess);
	CloseHandle(pi.hThread);

	exit(rc);
}
#endif

static void Execute(int argc, char *argv[], const char *manifestDir)
{
	char dotnet[64 * 1024], torun[64 * 1024], *p, xunit[64 * 1024], output[64*1024];
	char **newargv = (char **)malloc((argc + 5) * sizeof(char *));
	//char *newargv[1024];
	int i;

	// Locate dotnet runner
	sprintf(dotnet, "%s/dotnet", manifestDir);

	// xunit runner
	sprintf(xunit, "%s/vstest.console.exe", manifestDir);

	// output
	sprintf(output, "/logger:junit;LogFilePath=%s", getenv("XML_OUTPUT_FILE"));

	// Based on current exe calculate _0.dll to run
	p = strrchr(Exe, '/');
	sprintf(torun, "%s/%s", manifestDir, p + 1);
	p = strrchr(torun, '_');
	if (p == NULL)
	{
		printf("launcher_core_nunit3: _ not found in %s\n", torun);
		exit(-1);
	}
	*p = '\0';

	// Prepare arguments
	newargv[0] = dotnet;
	newargv[1] = xunit;
	newargv[2] = torun;
	newargv[3] = output;
	for (i = 1; i < argc; ++i)
		newargv[i + 3] = argv[i];
	newargv[i + 3] = NULL;

	if (IsVerbose())
	{
		for (i = 0; i < argc + 4; ++i)
			printf("argv[%d] = %s\n", i, newargv[i]);
	}
#ifdef _MSC_VER
	exit(_spawnvp(_P_WAIT, newargv[0], newargv));
	//LaunchProcess(argc + 5, argv, manifestDir);
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
		printf("Launcher core_xunit %s (%s) \n", argv[0], getenv("RULES_DOTNET_WORKSPACE_ROOT"));

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
	// LinkFiles(manifestDir);
	// LinkFilesTree(manifestDir);
	// LinkHostFxr(manifestDir);

	Execute(argc, argv, manifestDir);

	return 0;
}