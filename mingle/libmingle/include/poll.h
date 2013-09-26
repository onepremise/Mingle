#ifndef _MINGLE_POLL
#define _MINGLE_POLL

#include <mingle/config.h>

# define POLLIN      0x0001      /* any readable data available   */
# define POLLPRI     0x0002      /* OOB/Urgent readable data      */
# define POLLOUT     0x0004      /* file descriptor is writable   */
# define POLLERR     0x0008      /* some poll error occurred      */
# define POLLHUP     0x0010      /* file descriptor was "hung up" */
# define POLLNVAL    0x0020      /* requested events "invalid"    */
# define POLLRDNORM  0x0040
# define POLLRDBAND  0x0080
# define POLLWRNORM  0x0100
# define POLLWRBAND  0x0200

struct pollfd
{
  int fd;                       /* which file descriptor to poll */
  short events;                 /* events we are interested in   */
  short revents;                /* events found on return        */
};

typedef unsigned long nfds_t;

#define GNULIB_defined_poll_types 1

int poll (struct pollfd *pfd, nfds_t nfd, int timeout);

#endif