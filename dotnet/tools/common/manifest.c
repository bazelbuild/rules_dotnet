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

void ReadManifestFromPath(const char *manifestPath)
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

    ReadManifestFromPath(buffer);
}

const char *GetDotnetFromEntries()
{
    const struct Entry *entry;
    const char *p;
    for(entry = g_Entries; entry != NULL; entry = entry->Next)
    {
        p = strrchr(entry->Key, '/');
        if (p == NULL)
            continue;
        if ( (strcmp(p, "/dotnet")==0) ||  (strcmp(p, "/dotnet.exe")==0))
            return entry->Path;
    }
    printf("dotnet not found in manifest entries\n");
    exit(-1);
}

const char *GetPathFromManifestEntries(const char *curPath, const char *prefix)
{
    const struct Entry *entry;
    int entriesCount = 0;
    char **dirs;
    int dirsCount = 0;
    int i;
    int bufferSize = 0;
    char * result;
    int prefixLen = strlen(prefix);
    int curPathLen = curPath!=NULL?strlen(curPath):0;

    /* Count entries && allocate array for unique directories*/
    for(entry = g_Entries; entry != NULL; entry = entry->Next)
        ++entriesCount;
    dirs = (char**) malloc(entriesCount * sizeof(char*));

    /* Extract unique directories */
    for(entry = g_Entries; entry != NULL; entry = entry->Next)
    {
        char *dir = strdup(entry->Path);
        char *p = strrchr(dir, '/');
        if (p==NULL)
        {
            free(dir);
            dir = strdup(".");
        }
        else
            *p = '\0';

        /* Check if directory is already present */  
        for(i = 0; i < dirsCount; ++i)
            if (strcmp(dirs[i], dir)==0)
                break;
        if (i >= dirsCount)
            dirs[dirsCount++] = dir;
    }


    /* Allocate buffer for PATH variable */
    for(i = 0; i < dirsCount; ++i)
        bufferSize += strlen(dirs[i]);
    bufferSize += curPathLen + 5 + dirsCount*(2+prefixLen) + 1;
    result = (char*) malloc(bufferSize);
    strncpy(result, "PATH=", bufferSize);

    /* Copy dirs to PATH and free memory */
    for(i = 0; i < dirsCount; ++i)
    {
        strncat(result, prefix, bufferSize - strlen(result));
        strncat(result, dirs[i], bufferSize - strlen(result));
        #ifdef _MSC_VER
        strncat(result, ";", bufferSize - strlen(result));
        #else
        strncat(result, ":", bufferSize - strlen(result));
        #endif
        free(dirs[i]);
    }    
    free(dirs);

    /* Add current PATH to the end */
    if (curPath!=NULL)
        strncat(result, curPath, bufferSize - strlen(result));

    return result;
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
    static char buffer[PATH_BUFFER_SIZE];

    snprintf(buffer, sizeof(buffer), "%s.runfiles_manifest", Exe);
    if (IsVerbose())
        printf("1. Checking MANIFEST %s\n", buffer);
    if (access(buffer, F_OK) != -1)
        return buffer;

    snprintf(buffer, sizeof(buffer), "%s.runfiles/MANIFEST", Exe);
    if (IsVerbose())
        printf("2. Checking MANIFEST %s\n", buffer);
    if (access(buffer, F_OK) != -1)
        return buffer;

    snprintf(buffer, sizeof(buffer), "%s/MANIFEST", getenv("RUNFILES_DIR"));
    if (IsVerbose())
        printf("3. Checking MANIFEST %s\n", buffer);
    if (access(buffer, F_OK) != -1)
        return buffer;

    getcwd(buffer, sizeof(buffer));
    strncat(buffer, "/MANIFEST", sizeof(buffer)-strlen(buffer));
    if (IsVerbose())
        printf("4. Checking MANIFEST %s\n", buffer);
    if (access(buffer, F_OK) != -1)
        return buffer;

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
