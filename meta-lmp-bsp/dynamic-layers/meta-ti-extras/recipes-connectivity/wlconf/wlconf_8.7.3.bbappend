SRC_URI:append:beaglebone-yocto = " \
    https://github.com/beagleboard/beaglebone-black-wireless/raw/d9135000a223228158d92fd2e3f00e495f642fee/firmware/wl18xx-conf.bin;name=wl18xx-conf-beagle \
"
SRC_URI[wl18xx-conf-beagle.sha256sum] = "e68e9a37995ab782faa41971704f24fd597d5abf16c47463708e90f8f080d335"

do_install:append:beaglebone-yocto() {
    install -m 0644 ${WORKDIR}/wl18xx-conf.bin ${D}${nonarch_base_libdir}/firmware/ti-connectivity/
}
