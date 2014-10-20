#include <mingle/config.h>

#include <mingw-path.h>

#include <unistd.h>
#include <stdlib.h>
#include <stdio.h>
#include <unistd.h>
#include <sys/stat.h>
#include <sys/types.h>
#include <c-string-manip.h>

#include <errno.h>
#include <libgen.h>
#include <string.h>
#include <dirent.h>

char * realpath (const char *name, char *resolved);

static char rootPath[PATH_CONVERSION_LEN+1]={0};
static int numMounts=-1;
static Fstab *mounted=NULL;

void readFstab()
{
    char *szRoot=mingw_rootpath();
    char szFstabPath[PATH_CONVERSION_LEN+1];
    int sizeLeft = 0;

    if (numMounts>=0)
        return;

    memset(szFstabPath,0,sizeof(szFstabPath));

    sizeLeft = PATH_CONVERSION_LEN-strlen(szFstabPath);
    strncat(szFstabPath, szRoot, sizeLeft);

    sizeLeft = PATH_CONVERSION_LEN-strlen(szFstabPath);
    strncat(szFstabPath, "/etc/fstab", sizeLeft);

    FILE *fp = fopen(szFstabPath, "r");

    char delim[]= " ";
    char line[2000];
    char *curResult;

    numMounts=0;

    while (fgets(line, 2000, fp) != NULL) {
        curResult=NULL;

        curResult = strtok(line,delim);

        if (curResult==NULL||strlen(curResult)==0) {
            break;
        }

        if (numMounts==0)
            mounted=(Fstab *)malloc(1 * sizeof(Fstab));
        else
            mounted = (Fstab *)realloc(mounted, (numMounts+1) * sizeof(Fstab));

        memset(mounted[numMounts].dest,0,sizeof(mounted[numMounts].dest));
        strcpy(mounted[numMounts].dest, curResult);

        curResult = strtok( NULL, delim );

        memset(mounted[numMounts].link,0,sizeof(mounted[numMounts].link));
        strcpy(mounted[numMounts].link, curResult);

        str_removeChar(mounted[numMounts].link, '\n');
        str_removeChar(mounted[numMounts].link, '\r');

        numMounts++;
    }

    fclose(fp);
}

int getNumMounts() {
    readFstab();
    return numMounts;
}

Fstab *getMounts() {
    readFstab();
    return mounted;
}

char *resolveMounts(const char *path, char *resolved, int size) {
    char *updated=NULL;
    int i=0;
    int sizeLeft = 0;

    memset(resolved, 0, size);
    readFstab();

    for (i = 0; i < numMounts; i++) {
        if (strlen(mounted[i].link)>0) {
           updated=str_replace(path, mounted[i].link, mounted[i].dest);

           if (updated!=NULL) {
               if (strcmp(path, updated)!=0) {
                   sizeLeft = size-strlen(resolved);
                   strncpy(resolved, updated, sizeLeft);
                   free(updated);
                   break;
               }
           }
       }
    }

    return resolved;
}

int doesFileExist(const char *filename) {
    struct stat st;
    int result = stat(filename, &st);
    return result == 0;
}

char *mingw_cleanpath(const char *oldpath, char *newpath, int size) {
    char *r=str_replace(oldpath, "\\", "/");

    if (r!=NULL)
    {
        memset(newpath, 0, size);
        strncpy(newpath, r, size);
        str_removeChar(newpath, '"');
        free(r);
    } else {
        memset(newpath, 0, size);
    }

    return newpath;
}

/*
 * Returns windows path to the msys root, "/", with drive
 * letter and foward slashes.
 *
 */
char *mingw_rootpath() {
    if (strlen(rootPath)==0)
    {
        char results[PATH_CONVERSION_LEN+1]={0};
        mingw_posx2winpath("/", results, PATH_CONVERSION_LEN);
        realpath(results, rootPath);
    }

    return rootPath;
}

char *mingw_resolveRoot(const char *oldpath, char *newpath, int size)
{
    int sizeLeft = 0;
    char results[PATH_CONVERSION_LEN+1]={0};
    char *szRoot=mingw_rootpath();

    mingw_cleanpath(oldpath, results, sizeof(results));

    if (results[0]=='/') {
       if (strlen(results)>1)
           resolveMounts(results, newpath, size);

       if ((strlen(newpath)==0)||(doesFileExist(newpath)!=1)) {
           memset(newpath, 0, size);

           sizeLeft = size-strlen(newpath);
           strncat(newpath, szRoot, sizeLeft);

           sizeLeft = size-strlen(newpath);
           strncat(newpath, results, sizeLeft);
       }
    } else {
       strncat(newpath, results, size);
    }

    return newpath;
}

/*
 * Always returns mixed path formatted results, which is drive letter with
 * forward slashes. Example: c:\msys == C:/msys, /home == c:/msys/home
 *
 */
char *mingw_realpath(const char *testpath, char *destination, int size)
{
    char results[PATH_CONVERSION_LEN+1]={0};
    int sizeLeft = 0;

    memset(results, 0, sizeof(results));
    memset(destination, 0, size);

    if (!testpath)
        return destination;

    if (testpath[1]==':') {
        sizeLeft = sizeof(results)-strlen(results);
        strncat(results, testpath, sizeLeft);
        mingw_cleanpath(results, results, sizeof(results));
    } else {
        mingw_resolveRoot(testpath, results, sizeof(results));
    }

    realpath(results, destination);

    if (strlen(destination)>0) {
        char *updated=str_replace(destination, "\\", "/");
        memset(destination, 0, size);
        strcat(destination, updated);
        if (updated!=NULL)
            free(updated);
    }

    if (doesFileExist(destination)) {
        return destination;
    }

    memset(destination, 0, size);

    return destination;
}

/*
 * Always returns msys path formated results, which is forward slash, drive letter,
 * and remainder using forward slashes. Example: C:\msys == /C/msys,
 * /home == /c/msys/home
 *
 */
char *msys_realpath(const char *testpath, char *destination, int size)
{
    char results[PATH_CONVERSION_LEN+1]={0};

    memset(results, 0, sizeof(results));
    memset(destination, 0, size);

    mingw_realpath(testpath, results, PATH_CONVERSION_LEN);

    if (strlen(results)>0) {
        if (results[1]==':') {
            str_removeChar(results,':');
            if (results[0]!='/') {
                str_prepend(results, "/");
            }
        }

        memset(destination, 0, size);

        strcat(destination, results);
    }

    return destination;
}

int mingw_posx2winpath(const char *mingwpath, char *destination, int size)
{
    FILE *fp;
    char cmd[PATH_CONVERSION_LEN+32]={0};
    char results[PATH_CONVERSION_LEN+1]={0};

    memset(destination, 0, size);

    // not quite sure yet why swprintf with size fails. will have
    // to use default swprintf for now.
    sprintf(cmd, "bash -c \"cd %s 2>&1 && pwd -W\"", mingwpath);

    /* Open the command for reading. */
    fp = popen(cmd, "r");

    if (fp == NULL) {
      return 0;
    } else {
        /* Read the output a line at a time - output it. */
        while (fgets(results, sizeof(results)-1, fp) != NULL) {
            if (strstr(results, "No such file")==NULL) {
                results[strlen(results)-1]='\0';
                strncat(destination, results, size);
            } else {
                return 0;
            }
        }

        /* close */
        pclose(fp);
    }

    return 1;
}

int __mkpath(const char *s, mode_t mode){
        char *q, *r = NULL, *path = NULL, *up = NULL;
        int rv = 0;

        rv = -1;
        if ((strcmp(s, ".") == 0) || (strcmp(s, "/") == 0))
            return 0;

        if ((strlen(s)==3) && (s[1]==':') && (s[2]=='/'))
            return 0;
        else if ((strlen(s)==2) && (s[1]==':'))
            return 0;

        if ((path = strdup(s)) == NULL)
        {
            rv = -1;
            goto out;
        }

        if ((q = strdup(s)) == NULL)
        {
            rv = -1;
            goto out;
        }

        if ((r = dirname(q)) == NULL)
                goto out;

        if ((up = strdup(r)) == NULL)
        {
            rv = -1;
            goto out;
        }

        if ((__mkpath(up, mode) == -1) && (errno != EEXIST))
                goto out;

        if ((mkdir(path, mode) == -1) && (errno != EEXIST))
                rv = -1;
        else
                rv = 0;

out:
        if (up != NULL)
                free(up);
        free(q);
        free(path);
        return (rv);
}

int mkpath(const char *s, mode_t mode){
    int rv=-1;
    char szclean[PATH_CONVERSION_LEN+1]={0};
    char results[PATH_CONVERSION_LEN+1]={0};

    memset(szclean, 0, sizeof(szclean));
    memset(results, 0, sizeof(results));

    strncpy(szclean, s, sizeof(szclean));

    mingw_cleanpath(szclean, szclean, sizeof(szclean));

    mingw_resolveRoot(szclean, results, sizeof(results));
    rv=__mkpath(results, mode);

    return rv;
}

int __rmpath(const char *path)
{
   DIR *d = opendir(path);
   size_t path_len = strlen(path);
   int r = -1;

   if (d)
   {
      struct dirent *p;

      r = 0;

      while (!r && (p=readdir(d)))
      {
          int r2 = -1;
          char *buf;
          size_t len;

          /* Skip the names "." and ".." as we don't want to recurse on them. */
          if (!strcmp(p->d_name, ".") || !strcmp(p->d_name, ".."))
          {
             continue;
          }

          len = path_len + strlen(p->d_name) + 2;
          buf = malloc(len);

          if (buf)
          {
             struct stat statbuf;

             snprintf(buf, len, "%s/%s", path, p->d_name);

             if (!stat(buf, &statbuf))
             {
                if (S_ISDIR(statbuf.st_mode))
                {
                   r2 = __rmpath(buf);
                }
                else
                {
                   r2 = unlink(buf);
                }
             }

             free(buf);
          }

          r = r2;
      }

      closedir(d);
   }

   if (!r)
   {
      r = rmdir(path);
   }

   return r;
}

int rmpath(const char *s){
    int rv=-1;
    char szclean[PATH_CONVERSION_LEN+1]={0};
    char results[PATH_CONVERSION_LEN+1]={0};

    memset(szclean, 0, sizeof(szclean));
    memset(results, 0, sizeof(results));

    strncpy(szclean, s, sizeof(szclean));

    mingw_cleanpath(szclean, szclean,sizeof(szclean));

    mingw_resolveRoot(szclean, results, sizeof(results));
    rv=__rmpath(results);

    return rv;
}
