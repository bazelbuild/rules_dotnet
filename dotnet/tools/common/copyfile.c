#ifndef _MSC_VER

#include <fcntl.h>
#include <unistd.h>
#include <errno.h>
#include <sys/stat.h>
#include <sys/types.h>
#include <stdio.h>
#include <stdlib.h>
#include <string.h>

#include "manifest.h"

int cp(const char *to, const char *from)
{
    int fd_to, fd_from;
    char buf[4096];
    ssize_t nread;
    int saved_errno;

    fd_from = open(from, O_RDONLY);
    if (fd_from < 0)
    {
        printf("Failed to open file %s. errno: %d\n", from, errno);
        return -1;
    }

    fd_to = open(to, O_WRONLY | O_CREAT | O_EXCL, 0666);
    if (fd_to < 0)
    {
        printf("Failed to open for writing file %s. errno: %d\n", to, errno);
        goto out_error;
    }

    while (nread = read(fd_from, buf, sizeof buf), nread > 0)
    {
        char *out_ptr = buf;
        ssize_t nwritten;

        do
        {
            nwritten = write(fd_to, out_ptr, nread);

            if (nwritten >= 0)
            {
                nread -= nwritten;
                out_ptr += nwritten;
            }
            else if (errno != EINTR)
            {
                goto out_error;
            }
        } while (nread > 0);
    }

    if (nread == 0)
    {
        if (close(fd_to) < 0)
        {
            fd_to = -1;
            goto out_error;
        }
        close(fd_from);

        /* Success! */
        return 0;
    }

out_error:
    saved_errno = errno;

    close(fd_from);
    if (fd_to >= 0)
        close(fd_to);

    errno = saved_errno;
    printf("errno: %d\n", saved_errno);
    return -1;
}

void CopyIfNeeded(const char *to, const char *from)
{
    struct stat toStat, fromStat;

    if (stat(to, &toStat) < 0)
        goto copyNeeded;

    if (stat(from, &fromStat) < 0)
    {
        printf("Can't open source file %s\n", from);
        exit(-1);
    }

    if (fromStat.st_size != toStat.st_size)
        goto copyNeeded;

    if (fromStat.st_mtime >= toStat.st_mtime)
        goto copyNeeded;

    return;

copyNeeded:
    unlink(to);
    cp(to, from);
}

/* On Linux, CoreCLR follows symbolic link to locate necessary dlls. To workaround the problem
   we copy the exe file to the runfiles directory.
*/
extern const char *Exe;
void PrepareExe(const char *manifestDir)
{
    const struct Entry *p = g_Entries;
    char target[64 * 1024];
    const char *q = strrchr(Exe, '/');
    const char *z;

    if (q == NULL)
    {
        printf("Exe (%s) - '/' not found\n", Exe);
        exit(-1);
    }

    while (p != NULL)
    {
        z = strrchr(p->Key, '/');
        if (z == NULL)
            continue;

        if (strcmp(q, z) == 0)
            break;

        p = p->Next;
    }

    if (p == NULL)
    {
        printf("Exe (%s) - not found in MANIFEST\n", q);
        exit(-1);
    }

    sprintf(target, "%s%s", manifestDir, q);
    CopyIfNeeded(target, p->Path);
}
void PrepareTestExe(const char *manifestDir)
{
    const struct Entry *p = g_Entries;
    char target[64 * 1024];
    const char *q = "/xunit.console.dll_exe.exe";
    const char *z;

    while (p != NULL)
    {
        z = strrchr(p->Key, '/');
        if (z == NULL)
            continue;

        if (strcmp(q, z) == 0)
            break;

        p = p->Next;
    }

    if (p == NULL)
    {
        printf("Exe (%s) - not found in MANIFEST\n", q);
        exit(-1);
    }

    sprintf(target, "%s%s", manifestDir, q);
    CopyIfNeeded(target, p->Path);
}

#endif