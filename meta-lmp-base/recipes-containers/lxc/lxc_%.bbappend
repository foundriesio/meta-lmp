# musl: usage of non-standard #include <sys/cdefs.h> is deprecated
EXTRA_OECONF_append_libc-musl = " --disable-werror"
