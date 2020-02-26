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
#ifndef SYMBOLIC_LINK_FLAG_ALLOW_UNPRIVILEGED_CREATE
#define SYMBOLIC_LINK_FLAG_ALLOW_UNPRIVILEGED_CREATE 0x2
#endif
#else
#include <unistd.h>
#include <errno.h>
#endif

#include "dotnet/tools/common/manifest.h"

const char *Exe = NULL;

#ifdef _MSC_VER
void CreateLink(const char *target, const char *toCreate)
{
    BOOL result;
    DWORD error;
    DWORD flag;

    if (!PathFileExists(target))
    {
        printf("File %s does not exist\n", target);
        exit(-1);
    }

    /* Fall back to symbolic linking */
    flag = SYMBOLIC_LINK_FLAG_ALLOW_UNPRIVILEGED_CREATE;
retry:
    result = CreateSymbolicLinkA(toCreate, target, flag);
    if (!result)
    {
        error = GetLastError();
        if (error == 87 && flag != 0)
        {
            printf("SYMBOLIC_LINK_FLAG_ALLOW_UNPRIVILEGED_CREATE seems not supported\n");
            flag = 0;
            goto retry;
        }
        if (error != ERROR_ALREADY_EXISTS)
        {
            /* For uknown to me reasons, sometimes the link function failes even if long paths are enabled. */
            if (error == ERROR_PATH_NOT_FOUND && PathFileExistsA(target))
            {
                /*printf("Target file %s does exists. Ignoring error. \n", target);*/
                return;
            }
            printf("Error %d on linking %s to %s\n", error, toCreate, target);

            exit(-1);
        }
    }
}
#else
void CreateLink(const char *target, const char *toCreate)
{
    int result;

    if (access(target, F_OK) == -1)
    {
        printf("File %s does not exist\n", target);
        exit(-1);
    }

    unlink(toCreate);

	result = symlink(target, toCreate);
    if (result != 0)
    {
        int error = errno;
        if (error != EEXIST)
        {
            printf("Error %d on linking %s to %s\n", error, toCreate, target);
            exit(-1);
        }
    }
}
#endif


/* One argument is expected: path to the launcher (to locate the manifest file) */
int main(int argc, char *argv[], char *envp[])
{
	char cwd[64*1024], argv1[64*1024], argv2[64*1024], *p;
	if (argc != 3)
	{
		printf("Usage: symlink <to> <from>\n");
		return -1;
	}

	p = getcwd(cwd, sizeof(cwd));
	for(;*p!='\0'; ++p)
		if (*p == '\\') *p = '/';
		
	sprintf(argv1, "%s/%s", cwd, argv[1]);
	sprintf(argv2, "%s/%s", cwd, argv[2]);

	if (IsVerbose())
	{
		printf("symlink: linktarget: %s; tocreate: %s\n", argv2, argv1);
	}


	CreateLink(argv2, argv1);

	return 0;
}
