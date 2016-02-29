#include <stdio.h>
#include <unistd.h>
#include <sys/cdefs.h>
#include <string.h>
#include <stdlib.h>
#ifndef _SET_ABORT_MESSAGE_H
#define _SET_ABORT_MESSAGE_H

static const char *msg = "Im just as useless as official log messages";

__BEGIN_DECLS

void android_set_abort_message(const char* msg) { printf(" %s \n ", msg); }

__END_DECLS

#endif // _SET_ABORT_MESSAGE_H
