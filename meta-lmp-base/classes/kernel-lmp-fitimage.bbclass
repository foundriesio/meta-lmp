# Linux microPlatform extensions to the upstream OE-core kernel-fitimage class

INITRAMFS_IMAGE_BUNDLE = "0"
FIT_CONF_PREFIX:mx8-nxp-bsp = "conf-freescale_"
FIT_CONF_PREFIX:am62xx = "conf-ti_"


inherit kernel-fitimage2
