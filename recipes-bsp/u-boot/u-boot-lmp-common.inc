SRC_URI_append = " \
    file://0001-fat-check-for-buffer-size-before-reading-blocks.patch \
"

SRC_URI_append_qemuarm64 = " \
    file://0001-qemuarm64-enable-support-for-fitimage.patch \
    file://0001-qemuarm64-make-u-boot-an-ATF-payload.patch \
"

SRC_URI_append_rpi = " \
    file://0001-rpi-set-CONFIG_SYS_BOOTM_LEN-to-32M.patch \
    file://0001-rpi_defconfig-enable-support-for-FIT.patch \
    file://0001-rpi-prefer-downstream-dtb-files.patch \
"

SRC_URI_append_beaglebone-yocto = " \
    file://beaglebone-extend-usb-ether.patch \
"
