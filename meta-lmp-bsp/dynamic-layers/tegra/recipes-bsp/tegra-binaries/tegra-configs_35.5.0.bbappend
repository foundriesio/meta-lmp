do_install:append() {
    rm ${D}/opt/nvidia/l4t-bootloader-config/nv-l4t-bootloader-config.sh
    (cd ${D} && rmdir -v --parents opt/nvidia/l4t-bootloader-config)
}

ALLOW_EMPTY:${PN}-bootloader = "1"
