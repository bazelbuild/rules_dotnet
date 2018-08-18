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

extern const char * Exe;

int main(int argc, char *argv[], char *envp[])
{
	const char *manifestDir;
	printf("Test prep running %s)\n", Exe);
	if (strlen(Exe) > 32*1024) {
		printf("File path %s too long\n", Exe);
		return -1;
	}

	manifestDir = GetManifestDir();
	ReadManifest(manifestDir);
	LinkFilesTree(manifestDir);

	return 0;
}