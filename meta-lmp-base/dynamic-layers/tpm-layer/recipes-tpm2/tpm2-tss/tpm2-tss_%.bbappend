# Fix support for usrmerge
EXTRA_OECONF += "--with-udevrulesdir=${nonarch_base_libdir}/udev/rules.d/"
EXTRA_OECONF_remove = "--with-udevrulesdir=${base_prefix}/lib/udev/rules.d/"
