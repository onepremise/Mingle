#ifndef UTSNAME_H
#define UTSNAME_H

#define	_SYS_NMLN	256

struct utsname
{
	char	sysname[_SYS_NMLN];	/* Name of this OS. */
	char	nodename[_SYS_NMLN];	/* Name of this network node. */
	char	release[_SYS_NMLN];	/* Release level. */
	char	version[_SYS_NMLN];	/* Version level. */
	char	machine[_SYS_NMLN];	/* Hardware type. */
};

int uname(struct utsname *);

#endif /* UTSNAME_H */
