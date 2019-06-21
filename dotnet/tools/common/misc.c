#include <stdio.h>
#include <string.h>
#include <stdlib.h>
#include <sys/types.h>
#include <sys/stat.h>
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

#include "manifest.h"

int IsVerbose()
{
    return 0;
}

char *GetLinkedMonoLauncher(const char *manifestDir)
{
    static char mono[64 * 1024];
    char linkedmono[64 * 1024];

#ifdef _MSC_VER
    HANDLE h;
    DWORD ret;
    BOOL b;
#else
    int len;
#endif
#ifdef _MSC_VER
    sprintf(mono, "%s/mono.exe", manifestDir);
    h = CreateFile(mono,                  // file to open
                   GENERIC_READ,          // open for reading
                   FILE_SHARE_READ,       // share for reading
                   NULL,                  // default security
                   OPEN_EXISTING,         // existing file only
                   FILE_ATTRIBUTE_NORMAL, // normal file
                   NULL);                 // no attr. template
    if (h == INVALID_HANDLE_VALUE)
    {
        printf("Could not open file %s (error %d\n)", mono, GetLastError());
        exit(-1);
    }
    ret = GetFinalPathNameByHandle(h, linkedmono, sizeof(linkedmono), VOLUME_NAME_DOS);
    CloseHandle(h);
    GetShortPathName(linkedmono, mono, sizeof(mono));
    strcpy(mono, mono + 4);
#else
    sprintf(mono, "%s/mono", manifestDir);
    len = readlink(mono, linkedmono, sizeof(linkedmono));
    linkedmono[len] = '\0';
    strcpy(mono, linkedmono);
#endif

    return mono;
}
