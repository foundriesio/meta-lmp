# Separate TAs into a different package, follow optee-os-fio
PACKAGES += "${PN}-ta"
RPROVIDES:${PN}-ta = "virtual-optee-os-ta"

FILES:${PN} = "${nonarch_base_libdir}/firmware/"
FILES:${PN}-ta = "${nonarch_base_libdir}/optee_armtz"
