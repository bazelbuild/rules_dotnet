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
#ifndef SYMBOLIC_LINK_FLAG_ALLOW_UNPRIVILEGED_CREATE
#define SYMBOLIC_LINK_FLAG_ALLOW_UNPRIVILEGED_CREATE 0x2
#endif
#else
#include <unistd.h>
#include <errno.h>
#endif

#include "manifest.h"

extern const char *Exe;
struct Entry *g_Entries = NULL;

void ReadManifestPath(const char *manifestPath)
{
    char buffer[64 * 1024];
    FILE *f;
    char *p;
    int line = 0;
    struct Entry *entry;

    /* read manifest file */
    f = fopen(manifestPath, "r");
    if (f == NULL)
    {
        p = getcwd(buffer, sizeof(buffer));
        printf("Can't open file MANIFEST in %s\n", p);
        exit(-1);
    }
    while (fgets(buffer, sizeof(buffer), f) != NULL)
    {
        ++line;
        p = strchr(buffer, '\n');
        if (p != NULL)
            *p = '\0';
        p = strchr(buffer, '\r');
        if (p != NULL)
            *p = '\0';

        p = strchr(buffer, ' ');
        if (p == NULL)
        {
            printf("Line %d is malformatted (no space)\n", line);
            exit(-1);
        }
        *p = '\0';
        entry = (struct Entry *)malloc(sizeof(struct Entry));
        entry->Key = strdup(buffer);
        entry->Path = strdup(p + 1);
        entry->Next = g_Entries;
        g_Entries = entry;
    }
    fclose(f);
}

void ReadManifest(const char *manifestDir)
{
    char buffer[64 * 1024];

    strcpy(buffer, manifestDir);
    strcat(buffer, "/MANIFEST");

    ReadManifestPath(buffer);
}

#ifdef _MSC_VER
void CreateLinkIfNeeded(const char *target, const char *toCreate)
{
    BOOL result;
    DWORD error;
    DWORD flag;

    if (!PathFileExists(target))
    {
        printf("File %s does not exist\n", target);
        exit(-1);
    }

    /* The file is linked by the calling script */
    if (strstr(toCreate, "manifest_prep.exe") != NULL)
        return;

    _chmod(toCreate, _S_IREAD | _S_IWRITE);

    unlink(toCreate);

    /* Try hard linking first (except mono.exe) */
    if (strstr(toCreate, "mono.exe") == NULL)
    {
        result = CreateHardLink(toCreate, target, NULL);
        if (result)
            return;
        error = GetLastError();
        if (error == ERROR_ALREADY_EXISTS)
        {
            /*printf("%s does exist after unlink. Ignoring error. \n", toCreate);*/
            return;
        }
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
void CreateLinkIfNeeded(const char *target, const char *toCreate)
{
    int result;
    char *p;

    if (access(target, F_OK) == -1)
    {
        printf("File %s does not exist\n", target);
        exit(-1);
    }

    p = strrchr(toCreate, '/');
    if (p == NULL)
    {
        printf("Error on linking %s to %s. toCreate doesn't contain '/'\n", toCreate, target);
        exit(-1);
    }

    unlink(toCreate);

    if (strcmp(p, "/mono") == 0 || strcmp(p, "/dotnet") == 0)
        result = symlink(target, toCreate);
    else
    {
        result = link(target, toCreate);
        if (result != 0 && errno == EXDEV)
        {
            // Cross-device hardlinks are not possible. Fallback to a symlink.
            result = symlink(target, toCreate);
        }
    }
    if (result != 0)
    {
        int error = errno;
        if (error == EEXIST)
            return;
        if (error == EPERM)
        {
            result = symlink(target, toCreate);
            if (result == 0)
                return;
            error = errno;
        }
        if (error != EEXIST)
        {
            printf("Error %d on linking %s to %s\n", error, toCreate, target);
            exit(-1);
        }
    }
}
#endif

void LinkFiles(const char *manifestDir)
{
    return;
    const struct Entry *p = g_Entries;
    const char *basename;
    char toCreate[64 * 1024];

    while (p != NULL)
    {
        basename = strrchr(p->Key, '/');
        if (basename == NULL)
            basename = p->Key;
        else
            ++basename;

        sprintf(toCreate, "%s/%s", manifestDir, basename);

        CreateLinkIfNeeded(p->Path, toCreate);
        p = p->Next;
    }
}

#ifdef _MSC_VER
typedef struct _stat Stat;
static void do_mkdir(const char *path)
{
    Stat st;
    DWORD error;
    wchar_t buffer[32 * 1024];

    if (access(path, F_OK) == 0)
    {
        return;
    }

    mbstowcs(buffer, path, sizeof(buffer));
    /* Directory does not exist. EEXIST for race condition */
    if (CreateDirectoryW(buffer, NULL) == 0)
    {
        error = GetLastError();
        if (error == ERROR_ALREADY_EXISTS)
            return;
        /*printf("Error %d creating directory for %s\n", error, path);
        exit(-1); */
    }
}

#else

typedef struct stat Stat;
static void do_mkdir(const char *path)
{
    Stat st;
    int status = 0;

    if (stat(path, &st) != 0)
    {
        /* Directory does not exist. EEXIST for race condition */
        if (mkdir(path, 0777) != 0 && errno != EEXIST)
            status = -1;
    }
    else if (!S_ISDIR(st.st_mode))
    {
        errno = ENOTDIR;
        status = -1;
    }

    if (status != 0)
    {
        /*printf("Error %d creating directory for %s\n", errno, path);
        exit(-1);  */
    }
}
#endif

static void NormalizeDir(char *path)
{
    char *q, *p;
    while ((q = strchr(path, '\\')) != NULL)
    {
        *q = '/';
    }

    while ((p = strstr(path, "../")) != NULL)
    {
        q = strchr(p + 3, '/');
        if (q == NULL)
        {
            printf("Failed to normalize dir %s\n", path);
            exit(-1);
        }

        memcpy(p, q + 1, strlen(q + 1) + 1);
    }
}
static void CreateDirTreeForFile(const char *path)
{
    char *pp;
    char *sp;
    char copypath[64 * 1024];

    strcpy(copypath, path);

    pp = strrchr(copypath, '/');
    *(pp + 1) = '\0';

    pp = copypath;
    while ((sp = strchr(pp, '/')) != NULL)
    {
        if (sp != pp)
        {
            /* Neither root nor double slash in path */
            *sp = '\0';
            do_mkdir(copypath);
            *sp = '/';
        }
        pp = sp + 1;
    }
}

void LinkFilesTree(const char *manifestDir)
{
    return;
    const struct Entry *p = g_Entries;
    char toCreate[64 * 1024];

    while (p != NULL)
    {
        sprintf(toCreate, "%s%s", manifestDir, p->Key);
        NormalizeDir(toCreate);

        CreateDirTreeForFile(toCreate);
        CreateLinkIfNeeded(p->Path, toCreate);
        p = p->Next;
    }
}

const char *GetManifestPath()
{
    static char buffer[64 * 1024];

    sprintf(buffer, "%s.runfiles/MANIFEST", Exe);
    if (IsVerbose())
        printf("1. Checking MANIFEST %s\n", buffer);
    if (access(buffer, F_OK) != -1)
        return buffer;

    sprintf(buffer, "%s.runfiles_manifest", Exe);
    if (IsVerbose())
        printf("2. Checking MANIFEST %s\n", buffer);
    if (access(buffer, F_OK) != -1)
        return buffer;

    sprintf(buffer, "%s/MANIFEST", getenv("RUNFILES_DIR"));
    if (IsVerbose())
        printf("3. Checking MANIFEST %s\n", buffer);
    if (access(buffer, F_OK) != -1)
        return buffer;

    getcwd(buffer, sizeof(buffer));
    strcat(buffer, "/MANIFEST");
    if (IsVerbose())
        printf("4. Checking MANIFEST %s\n", buffer);
    if (access(buffer, F_OK) != -1)
        return buffer;

    printf("Couldn't find MANIFEST file\n");
    exit(-1);
}

/* I didn't find an easy way to locate MANIFEST file. 
   Until now, I have identified the following cases:
   1. Current directory (run on Windows).
   2. Parrent directory (run on Linux and osx).
   3. <currentdir>/<launcher>.runfiles (when used as a tool and launcher is this program)
   This function tries to locate the MANIFEST file and returns
   an absolute path to directory with it.
*/
const char *GetManifestDir()
{
    static char buffer[64 * 1024];
    char *p;

    strcpy(buffer, Exe);
    if (IsVerbose())
        printf("1. Checking MANIFEST in %s\n", buffer);
    if (access(buffer, F_OK) != -1)
    {
        p = strrchr(buffer, '/');
        *(p + 1) = '\0';

        return buffer;
    }

    p = getcwd(buffer, sizeof(buffer));
    if (IsVerbose())
        printf("2. Checking MANIFEST in %s\n", buffer);
    if (access("MANIFEST", F_OK) != -1)
        return buffer;

    strcat(buffer, "/../MANIFEST");
    if (IsVerbose())
        printf("3. Checking MANIFEST in %s\n", buffer);
    if (access(buffer, F_OK) != -1)
    {
        p = strrchr(buffer, '/');
        *(p + 1) = '\0';

        return buffer;
    }

    p = getcwd(buffer, sizeof(buffer));
    strcat(buffer, "/");
    strcat(buffer, Exe);
    /* We have to convert Exe name to this launcher name (by removing _exe suffix and possibly .exe 
	   on non-Windows platforms) */
    p = strrchr(buffer, '_');
#ifdef _MSC_VER
    strcpy(p, p + 4);
#else
    strcpy(p, p + 8);
#endif

    strcat(buffer, ".runfiles/MANIFEST");
    if (IsVerbose())
        printf("4. Checking MANIFEST in %s\n", buffer);
    if (access(buffer, F_OK) != -1)
    {
        p = strrchr(buffer, '/');
        *(p + 1) = '\0';
        return buffer;
    }

    p = getcwd(buffer, sizeof(buffer));
    strcat(buffer, "/");
    strcat(buffer, Exe);
    strcat(buffer, ".runfiles/MANIFEST");
    if (IsVerbose())
        printf("5. Checking MANIFEST in %s\n", buffer);
    if (access(buffer, F_OK) != -1)
    {
        p = strrchr(buffer, '/');
        *(p + 1) = '\0';
        return buffer;
    }

    printf("Couldn't find MANIFEST file\n");
    exit(-1);
}

void LinkHostFxr(const char *manifestDir)
{
    char buffer[64 * 1024], *q;
    const struct Entry *p = g_Entries;

    while (p != NULL)
    {
        q = strstr(p->Key, "host/fxr/");
        if (q != NULL)
            break;

        p = p->Next;
    }

    if (q == NULL)
    {
        return;
    }

    sprintf(buffer, "%s%s", manifestDir, q);
    CreateDirTreeForFile(buffer);
    CreateLinkIfNeeded(p->Path, buffer);
}
