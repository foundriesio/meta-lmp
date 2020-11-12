inherit update-alternatives

# Avoid conflict with busybox
ALTERNATIVE_${PN} = "mkfs.vfat"
ALTERNATIVE_PRIORITY = "100"
ALTERNATIVE_LINK_NAME[mkfs.vfat] = "${base_sbindir}/mkfs.vfat"
