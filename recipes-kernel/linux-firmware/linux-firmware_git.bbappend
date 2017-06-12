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
    https://github.com/kvalo/ath10k-firmware/raw/07859a27a5fd6a6919f8ae613c6ab4f62a5c5a2a/QCA6174/hw3.0/board-2.bin;name=board-2 \
    https://github.com/kvalo/ath10k-firmware/raw/07859a27a5fd6a6919f8ae613c6ab4f62a5c5a2a/QCA6174/hw3.0/4.4/firmware-5.bin_WLAN.RM.4.4-00022-QCARMSWPZ-2;name=firmware-5 \
"

# WiLink8
SRC_URI[TIInit_11.8.32.md5sum] = "b1e142773e8ef0537b93895ebe2fcae3"
SRC_URI[TIInit_11.8.32.sha256sum] = "962322c05857ad6b1fb81467bdfc59c125e04a6a8eaabf7f24b742ddd68c3bfa"
SRC_URI[wl18xx-conf.md5sum] = "e0db09a1dea22b1fbcb1a5d9aa168215"
SRC_URI[wl18xx-conf.sha256sum] = "e68e9a37995ab782faa41971704f24fd597d5abf16c47463708e90f8f080d335"
# QCA6174
SRC_URI[board-2.md5sum] = "039462f699784be6efb77747de9f0011"
SRC_URI[board-2.sha256sum] = "b3f483ad4e645cf36beaee23743176597dddf3fd5afe22f95ac7883f590188d5"
SRC_URI[firmware-5.md5sum] = "48605abe5f687f66131a2a39fc531965"
SRC_URI[firmware-5.sha256sum] = "7fa6a6e60a68f7f787ad26766f9647c9c99d681d15ba59d0ae3951bbcf94bb64"

do_install_append() {
     cp ${WORKDIR}/TIInit_11.8.32.bts ${D}/lib/firmware/ti-connectivity/
     cp ${WORKDIR}/board-2.bin ${D}/lib/firmware/ath10k/QCA6174/hw3.0/
     cp ${WORKDIR}/firmware-5.bin_WLAN.RM.4.4-00022-QCARMSWPZ-2 ${D}/lib/firmware/ath10k/QCA6174/hw3.0/firmware-5.bin

     # No need to install check_whence, triggers QA error (reported upstream)
     rm ${D}${nonarch_base_libdir}/firmware/check_whence.py
}

do_install_append_beaglebone() {
     cp ${WORKDIR}/wl18xx-conf.bin ${D}/lib/firmware/ti-connectivity/
}
