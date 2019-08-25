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
#endif

#include "dotnet/tools/common/manifest.h"

const char *Exe = NULL;

#ifdef _MSC_VER
static int CopyMsc(const char *to, const char *from)
{
	BOOL r = CopyFile(from, to, FALSE);
	if (!r)
	{
		printf("copy: Failed to copy %s to %s. LastError: %d\n", from, to, GetLastError());
		return -1;
	}
	return 0;
}
#else
static int CopyLinux(const char *to, const char *from)
{
	return cp(to, from);
}
#endif

/* One argument is expected: path to the launcher (to locate the manifest file) */
int main(int argc, char *argv[], char *envp[])
{
	if (argc != 3)
	{
		printf("Usage: copy <to> <from>\n");
		return -1;
	}

#ifdef _MSC_VER
	return CopyMsc(argv[1], argv[2]);
#else
	return CopyLinux(argv[1], argv[2]);
#endif
}
