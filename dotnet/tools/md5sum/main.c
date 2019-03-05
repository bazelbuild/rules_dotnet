#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include "dotnet/tools/md5/md5.h"

static void sumFile(const char *filename, MD5_CTX* ctx)
{
    int bytes;
    unsigned char data[1024];
    FILE *inFile = fopen(filename, "rb");
    if (inFile == NULL) {
        printf("%s can't be opened.\n", filename);
        exit(-1);
    }

    while((bytes = fread(data, 1, 1024, inFile)) != 0)
        MD5_Update(ctx, data, bytes);

    fclose(inFile);
}

int main(int argc, char **argv)
{
    /* Usage: md5sum paramFile */
    FILE* fp;
    char buf[16*1024], *line, *output;
    unsigned char c[MD5_DIGEST_LENGTH];
    MD5_CTX mdContext;
    int i;

    if (argc != 2)
    {
        printf("Usage: %s paramFile\n", argv[0]);
        return -1;
    }
    if ((fp = fopen(argv[1], "r")) == NULL)
    { 
        printf("Can't open %s\n", argv[1]);
        return -1;
    }
        
    output = fgets(buf, sizeof(buf), fp);
    if (output == NULL) 
    {
        printf("File %s is empty\n", argv[1]);
        return -1;
    }
    output = strdup(buf);
    output[strlen(output)-1] = '\0';

    MD5_Init(&mdContext);
    while (fgets(buf, sizeof(buf), fp) != NULL)
    {
        buf[strlen(buf) - 1] = '\0'; 
        sumFile(buf, &mdContext);
    }    
    MD5_Final (c,&mdContext);
    fclose(fp);

    fp = fopen(output, "w");
    if (fp == NULL)
    {
        printf("Can't open %s\n", argv[1]);
        return -1;
    }

    for(i = 0; i < MD5_DIGEST_LENGTH; i++) fprintf(fp, "%02x", c[i]);
    fclose (fp);
    return 0;
}