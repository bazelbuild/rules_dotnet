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

const char * Exe = NULL;

/* Two arguments are expected: path to the launcher (to locate the manifest file) and output file which should contain simple "ok" */
int main(int argc, char *argv[], char *envp[])
{
	FILE *f;
	const char *manifestDir, *outFile;

	Exe = argv[1];
	outFile = argv[2];

#ifdef _MSC_VER
	manifestDir = GetManifestDir();
	ReadManifest(manifestDir);
	LinkFiles(manifestDir);
	LinkHostFxr(manifestDir);
#endif

	f = fopen(outFile, "w");
	fprintf(f, "ok");
	fclose(f);

	return 0;
}