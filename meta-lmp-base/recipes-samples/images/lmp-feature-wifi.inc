# Wifi packages
CORE_IMAGE_BASE_INSTALL += " \
    hostapd \
    linux-firmware-ar3k \
    linux-firmware-ath9k \
    linux-firmware-ath10k \
    linux-firmware-qca \
    linux-firmware-wl18xx \
    ${@bb.utils.contains('MACHINE_EXTRA_RRECOMMENDS', 'linux-firmware-rpidistro-bcm43430', 'linux-firmware-rpidistro-bcm43430', 'linux-firmware-bcm43430', d)} \
    ${@bb.utils.contains('MACHINE_EXTRA_RRECOMMENDS', 'linux-firmware-rpidistro-bcm43455', 'linux-firmware-rpidistro-bcm43455', 'linux-firmware-bcm43455', d)} \
"
