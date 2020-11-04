# Support additional firmware for WiLink8 modules
# TIInit_11.8.32.bts is required for bluetooth support but this particular
# version is not available in the linux-firmware repository.
#
SRC_URI_append = "\
    https://git.ti.com/ti-bt/service-packs/blobs/raw/31a43dc1248a6c19bb886006f8c167e2fd21cb78/initscripts/TIInit_11.8.32.bts;name=TIInit_11.8.32 \
"
SRC_URI_append_beaglebone-yocto = "\
    https://github.com/beagleboard/beaglebone-black-wireless/raw/d9135000a223228158d92fd2e3f00e495f642fee/firmware/wl18xx-conf.bin;name=wl18xx-conf \
"

# WiLink8
SRC_URI[TIInit_11.8.32.md5sum] = "8c47a23f3f3d745b7f475a2db4eedb98"
SRC_URI[TIInit_11.8.32.sha256sum] = "398e9149225c19e73415463bbbf54dd8cbbb8dd1a595251519b828c0f8f50446"
SRC_URI[wl18xx-conf.md5sum] = "e0db09a1dea22b1fbcb1a5d9aa168215"
SRC_URI[wl18xx-conf.sha256sum] = "e68e9a37995ab782faa41971704f24fd597d5abf16c47463708e90f8f080d335"

do_install_append() {
    cp ${WORKDIR}/TIInit_11.8.32.bts ${D}${nonarch_base_libdir}/firmware/ti-connectivity/
}

do_install_append_beaglebone-yocto() {
    cp ${WORKDIR}/wl18xx-conf.bin ${D}${nonarch_base_libdir}/firmware/ti-connectivity/
}
