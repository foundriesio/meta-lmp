# Support additional firmware for WiLink8 modules
# TIInit_11.8.32.bts is required for bluetooth support but this particular
# version is not available in the linux-firmware repository.
#
SRC_URI_append = "\
     https://git.ti.com/ti-bt/service-packs/blobs/raw/c290f8af9e388f37e509ecb111a1b64572b7c225/initscripts/TIInit_11.8.32.bts;name=TIInit_11.8.32 \
"
SRC_URI_append_beaglebone = "\
    https://github.com/beagleboard/beaglebone-black-wireless/raw/d9135000a223228158d92fd2e3f00e495f642fee/firmware/wl18xx-conf.bin;name=wl18xx-conf \
"
# Updated firmware files for QCA6174
SRC_URI_append = "\
    https://github.com/kvalo/ath10k-firmware/raw/35d8642f452827b955470de4ac997ffe906a6f17/QCA6174/hw3.0/board-2.bin;name=board-2 \
    https://github.com/kvalo/ath10k-firmware/raw/35d8642f452827b955470de4ac997ffe906a6f17/QCA6174/hw3.0/4.4.1/firmware-6.bin_WLAN.RM.4.4.1-00079-QCARMSWPZ-1;name=firmware-6 \
"

# WiLink8
SRC_URI[TIInit_11.8.32.md5sum] = "b1e142773e8ef0537b93895ebe2fcae3"
SRC_URI[TIInit_11.8.32.sha256sum] = "962322c05857ad6b1fb81467bdfc59c125e04a6a8eaabf7f24b742ddd68c3bfa"
SRC_URI[wl18xx-conf.md5sum] = "e0db09a1dea22b1fbcb1a5d9aa168215"
SRC_URI[wl18xx-conf.sha256sum] = "e68e9a37995ab782faa41971704f24fd597d5abf16c47463708e90f8f080d335"
# QCA6174
SRC_URI[board-2.md5sum] = "33a5884a8ae14f150aa70468cc092ad2"
SRC_URI[board-2.sha256sum] = "8fcc6b96c1895bc227c3caf0bd04b23d0292f8f919e819e4e025e29ef4b44d8e"
SRC_URI[firmware-6.md5sum] = "f248b22e3f7c8602887203efe1d96bc8"
SRC_URI[firmware-6.sha256sum] = "5554d6aa0de07394938a0094bae725ed24d4ceee3b38c849b4099a496ec50b48"

do_install_append() {
     cp ${WORKDIR}/TIInit_11.8.32.bts ${D}${nonarch_base_libdir}/firmware/ti-connectivity/
     cp ${WORKDIR}/board-2.bin ${D}${nonarch_base_libdir}/firmware/ath10k/QCA6174/hw3.0/
     cp ${WORKDIR}/firmware-6.bin_WLAN.RM.4.4.1-00079-QCARMSWPZ-1 ${D}${nonarch_base_libdir}/firmware/ath10k/QCA6174/hw3.0/firmware-6.bin
}

do_install_append_beaglebone() {
     cp ${WORKDIR}/wl18xx-conf.bin ${D}${nonarch_base_libdir}/firmware/ti-connectivity/
}
