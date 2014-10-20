#include <mingle/config.h>

#include <unistd.h>
#include <stdlib.h>
#include <stdio.h>
#include <string.h>
#include <stddef.h>
#include <c-string-manip.h>

void str_prepend(char* s, const char* t)
{
    size_t len = strlen(t);
    size_t i;

    memmove(s + len, s, strlen(s) + 1);

    for (i = 0; i < len; ++i)
    {
        s[i] = t[i];
    }
}

void str_removeChar(char *str, char garbage) {

    char *src, *dst;
    for (src = dst = str; *src != '\0'; src++) {
        *dst = *src;
        if (*dst != garbage) dst++;
    }
    *dst = '\0';
}


/*
 * Description: Replaces in the string str all the occurrences of the source
 * string old with the destination string new. The lengths of the strings old
 * and new may differ. The string new may be of any length, but the string "old"
 * must be of non-zero length - the penalty for providing an empty string for
 * the "old" parameter is an infinite loop. In addition, none of the three
 * parameters may be NULL.
 *
 * Returns:	The post-replacement string, or NULL if memory for the new string
 * could not be allocated. Does not modify the original string. The memory
 * for the returned post-replacement string may be deallocated with the
 * standard library function free() when it is no longer required.
 *
 * Licence:	Public domain. You may use this code in any way you see fit,
 * optionally crediting its author (me, Laird Shaw, with assistance from
 * comp.lang.c).
 * http://creativeandcritical.net/str-replace-c/
 */
char *str_replace(const char *str, const char *old, const char *new)
{
	char *ret, *r;
	const char *p, *q;
	size_t oldlen = strlen(old);
	size_t count, retlen, newlen = strlen(new);

	if (oldlen != newlen) {
		for (count = 0, p = str; (q = strstr(p, old)) != NULL; p = q + oldlen)
			count++;
		/* this is undefined if p - str > PTRDIFF_MAX */
		retlen = p - str + strlen(p) + count * (newlen - oldlen);
	} else
		retlen = strlen(str);

	if ((ret = malloc(retlen + 1)) == NULL)
		return NULL;

	for (r = ret, p = str; (q = strstr(p, old)) != NULL; p = q + oldlen) {
		/* this is undefined if q - p > PTRDIFF_MAX */
		ptrdiff_t l = q - p;
		memcpy(r, p, l);
		r += l;
		memcpy(r, new, newlen);
		r += newlen;
	}
	strcpy(r, p);

	return ret;
}