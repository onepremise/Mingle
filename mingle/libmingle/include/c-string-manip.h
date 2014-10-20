#if __GNUC__ >= 3
#pragma GCC system_header
#endif

#ifndef _GL_MINGW_C_STR_MANIP_H
#define _GL_MINGW_C_STR_MANIP_H

#if defined __cplusplus
# define _GL_EXTERN_C extern "C"
#else
# define _GL_EXTERN_C extern
#endif

_GL_EXTERN_C void str_prepend(char* s, const char* t);
_GL_EXTERN_C void str_removeChar(char *str, char garbage);
_GL_EXTERN_C char *str_replace(const char *str, const char *old, const char *new);

#endif