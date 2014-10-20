#include <mingw-path.h>
#include <stdio.h>
#include <string.h>
#include <sys/stat.h>

#include <c-string-manip.h>

#define TEST_SIZE 17

typedef struct {
    char *path;
    int expectedResult;
    char *expectedMingwPath;
    char *expectedMsysPath;
} testcriteria;

testcriteria criteria[TEST_SIZE] = {
    {".", 1, NULL, NULL},
    {"..", 1, NULL, NULL},
    {"/home", 1, NULL, NULL},
    {"C:\\", 1, NULL, NULL},
    {"C:\\Windows", 1, NULL, NULL},
    {"/", 1, NULL, NULL},
    {"//", 1, NULL, NULL},
    {"/mingw/bin", 1, NULL, NULL},
    {"/mingw", 1, NULL, NULL},
    {"/bin", 1, NULL, NULL},
    {"/home", 1, NULL, NULL},
    {"/nonexistent", 0,"", ""},
    {"\"data/language/tree-il.scm\"", 1,"data/language/tree-il.scm","data/language/tree-il.scm"},
    {"relative", 1,"relative","relative"},
    {"./relative", 1,"relative","relative"},
    {".\\relative", 1,"relative","relative"},
    {"data/ice-9/eval.scm", 1,"data/ice-9/eval.scm","data/ice-9/eval.scm"}
};

int mkpathTest(char *szPath, char *szCheck) {
    int rv = 0;

    printf ("mkpathTest for %s...\n", szPath);

    rv=mkpath(szPath, S_IRWXU);

    if (szCheck==NULL)
        szCheck=szPath;

    if ((rv != 0) || !doesFileExist(szCheck))
    {
          printf ("mkpath failed for %s, rv %d errno %d\n", szCheck, rv, errno);
          return 1;
    } else {
        rv=rmpath(szCheck);
        if (rv != 0) {
          printf ("rmpath failed for %s, rv %d errno %d\n", szCheck, rv, errno);
          return 1;
        }
    }

    return 0;
}

int rmpathTest(char *szPath) {
    printf ("rmpathTest for %s...\n", szPath);
    int rv=rmpath(szPath);
    if ((rv != 0) || doesFileExist(szPath)) {
      printf ("rmpath failed for %s, rv %d errno %d\n", szPath, rv, errno);
      return 1;
    }

    return 0;
}

int
main (int argc, char *argv[])
{
    char szMingwPathTest[1024]={0};
    char *szRoot=mingw_rootpath();
    int i = 0;

    strcpy(szMingwPathTest,"abcdefg");

    str_removeChar(szMingwPathTest, 'c');

    if (strcmp("abdefg", szMingwPathTest)!=0)
    {
        printf ("str_removeChar failed!\n");
        return 1;
    }

    readFstab();

    if (strlen(szRoot)==0)
    {
        printf ("getMingwRoot failed!\n");
        return 1;
    } else {
        printf("Mingw root path exists: %s\n", szRoot);
    }

    for (i=0; i<TEST_SIZE; i++)
    {
        if (criteria[i].path[0]!='/')
            mkdir(criteria[i].path, S_IRWXG);

        memset(szMingwPathTest,0,sizeof(szMingwPathTest));
        printf("\nmingw_realpath test: %s\n", criteria[i].path);
        mingw_realpath(criteria[i].path, szMingwPathTest, 1024);

        if ((strlen(szMingwPathTest)==0) && (criteria[i].expectedResult==1))
        {
            printf ("mingw_realpath failed!\n");
            return 1;
        } else {
            printf("mingw_realpath: %s\n", szMingwPathTest);
        }

        if ((criteria[i].expectedMingwPath!=NULL) &&
            (strcmp(szMingwPathTest, criteria[i].expectedMingwPath)!=0))
        {
            int tLen=strlen(szMingwPathTest);
            int eLen=strlen(criteria[i].expectedMsysPath);
            int diff=((tLen-eLen)>0)?(tLen-eLen):0;
            char *szDiff=szMingwPathTest+diff;

            if(strcmp(szDiff, criteria[i].expectedMsysPath)!=0) {
                printf ("mingw_realpath check failed, \"%s\" != \"%s\"!\n",szMingwPathTest, criteria[i].expectedMsysPath);
                return 1;
            }
        }

        memset(szMingwPathTest,0,sizeof(szMingwPathTest));
        printf("\nmsys_realpath test: %s\n", criteria[i].path);
        msys_realpath(criteria[i].path, szMingwPathTest, 1024);

        if ((strlen(szMingwPathTest)==0) && (criteria[i].expectedResult==1))
        {
            printf ("msys_realpath failed!\n");
            return 1;
        } else {
            printf("msys_realpath: %s\n", szMingwPathTest);
        }

        if ((criteria[i].expectedMsysPath!=NULL) &&
            (strcmp(szMingwPathTest, criteria[i].expectedMsysPath)!=0))
        {
            int tLen=strlen(szMingwPathTest);
            int eLen=strlen(criteria[i].expectedMsysPath);
            int diff=((tLen-eLen)>0)?(tLen-eLen):0;
            char *szDiff=szMingwPathTest+diff;

            if(strcmp(szDiff, criteria[i].expectedMsysPath)!=0) {
                printf ("msys_realpath check failed, \"%s\" != \"%s\"!\n",szMingwPathTest, criteria[i].expectedMsysPath);
                return 1;
            }
        }
    }

    printf ("\n\n");

    if (mkpathTest("full/path/test", NULL)) return 1;
    if (mkpathTest("full\\path2\\test2", NULL)) return 1;
    if (mkpathTest("./full\\path3\\test3", NULL)) return 1;

    char szActualPath[PATH_CONVERSION_LEN]={0};
    mingw_resolveRoot("/full/path4/test5", szActualPath, sizeof(szActualPath));

    if (mkpathTest("/full/path4/test5", szActualPath)) return 1;

    if (mkpathTest("C:/full/path4/test4", NULL)) return 1;

    printf ("\n\n");

    if (rmpathTest("full")) return 1;
    if (rmpathTest("C:/full")) return 1;
    if (rmpathTest("/full")) return 1;

    return 0;
}