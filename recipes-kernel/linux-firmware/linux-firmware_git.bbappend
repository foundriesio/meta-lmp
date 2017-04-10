# Support additional firmware for WiLink8 modules
# TIInit_11.8.32.bts is required for bluetooth support but this particular
# version is not available in the linux-firmware repository.
#
SRC_URI_append = "\
     https://git.ti.com/ti-bt/service-packs/blobs/raw/c290f8af9e388f37e509ecb111a1b64572b7c225/initscripts/TIInit_11.8.32.bts;name=TIInit_11.8.32 \
"
# Updated firmware files for QCA6174
SRC_URI_append = "\
    https://github.com/kvalo/ath10k-firmware/raw/1675d48520f2252b583a054ea934e76ea6b8bff3/QCA6174/hw3.0/board-2.bin;name=board-2 \
    https://github.com/kvalo/ath10k-firmware/raw/1675d48520f2252b583a054ea934e76ea6b8bff3/QCA6174/hw3.0/4.4/firmware-5.bin_WLAN.RM.4.4-00022-QCARMSWPZ-2;name=firmware-5 \
"

# WiLink8
SRC_URI[TIInit_11.8.32.md5sum] = "b1e142773e8ef0537b93895ebe2fcae3"
SRC_URI[TIInit_11.8.32.sha256sum] = "962322c05857ad6b1fb81467bdfc59c125e04a6a8eaabf7f24b742ddd68c3bfa"
# QCA6174
SRC_URI[board-2.md5sum] = "82223d65048e43a6f8b16d09a55c30a8"
SRC_URI[board-2.sha256sum] = "fa4a58086a7545717a20e2a507fce6e3ce097865ef8744af412e2c482346bbbb"
SRC_URI[firmware-5.md5sum] = "48605abe5f687f66131a2a39fc531965"
SRC_URI[firmware-5.sha256sum] = "7fa6a6e60a68f7f787ad26766f9647c9c99d681d15ba59d0ae3951bbcf94bb64"

do_install_append() {
     cp ${WORKDIR}/TIInit_11.8.32.bts ${D}/lib/firmware/ti-connectivity/
     cp ${WORKDIR}/board-2.bin ${D}/lib/firmware/ath10k/QCA6174/hw3.0/
     cp ${WORKDIR}/firmware-5.bin_WLAN.RM.4.4-00022-QCARMSWPZ-2 ${D}/lib/firmware/ath10k/QCA6174/hw3.0/firmware-5.bin
}
