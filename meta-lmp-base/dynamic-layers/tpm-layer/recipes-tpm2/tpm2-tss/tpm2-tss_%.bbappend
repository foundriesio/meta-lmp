# Prefer /usr/lib directories as they can't be erased/modified by the user
EXTRA_OECONF += " \
    --with-sysusersdir=${nonarch_libdir}/sysusers.d \
    --with-tmpfilesdir=${nonarch_libdir}/tmpfiles.d \
"

FILES:${PN} += " \
    ${nonarch_libdir}/sysusers.d \
    ${nonarch_libdir}/tmpfiles.d \
"
