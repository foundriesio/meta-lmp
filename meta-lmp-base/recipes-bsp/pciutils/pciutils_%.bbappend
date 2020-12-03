inherit update-alternatives

# Avoid conflict with busybox
ALTERNATIVE_${PN} = "lspci"
ALTERNATIVE_PRIORITY = "100"
ALTERNATIVE_LINK_NAME[lspci] = "${base_bindir}/lspci"
