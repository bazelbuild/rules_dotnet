struct Entry {
	const char *Key;
	const char *Path;
	const struct Entry* Next; 
};

extern struct Entry* g_Entries;

void ReadManifest(const char *manifestDir);
void LinkFiles(const char *manifestDir);
void LinkFilesTree(const char *manifestDir);
const char *GetManifestDir();

