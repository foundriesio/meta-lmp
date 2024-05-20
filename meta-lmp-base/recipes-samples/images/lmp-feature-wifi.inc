# Wifi packages
CORE_IMAGE_BASE_INSTALL += " \
    hostapd \
    ${@bb.utils.contains('MACHINE_FEATURES', 'mxm-mwifiex-load', 'mxm-mwifiex-setup', '', d)} \
"
