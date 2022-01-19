# Wifi packages
MACHINE_FIRMWARE:append = " ${@bb.utils.contains('MACHINE_FEATURES', 'nxp8987', 'linux-firmware-nxp89xx', '', d)}"

CORE_IMAGE_BASE_INSTALL += " \
    hostapd \
    linux-firmware-ar3k \
    linux-firmware-ath9k \
    linux-firmware-ath10k \
    linux-firmware-qca \
    linux-firmware-wl18xx \
    ${@bb.utils.contains('MACHINE_EXTRA_RRECOMMENDS', 'linux-firmware-rpidistro-bcm43430', 'linux-firmware-rpidistro-bcm43430', 'linux-firmware-bcm43430', d)} \
    ${@bb.utils.contains('MACHINE_EXTRA_RRECOMMENDS', 'linux-firmware-rpidistro-bcm43455', 'linux-firmware-rpidistro-bcm43455', 'linux-firmware-bcm43455', d)} \
    ${@bb.utils.contains('MACHINE_EXTRA_RRECOMMENDS', 'linux-firmware-nxp89xx', 'linux-firmware-nxp89xx', '', d)} \
    ${@bb.utils.contains('MACHINE_FEATURES', 'mxm-mwifiex-load', 'mxm-mwifiex-setup', '', d)} \
    ${@bb.utils.contains('MACHINE_FEATURES', 'nxp8987', 'kernel-module-nxp89xx', '', d)} \
"
