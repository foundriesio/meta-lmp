OPTEEMACHINE_imx8mmevk = "imx-imx8mmevk"
OPTEEMACHINE_imx6ullevk = "imx-mx6ullevk"

EXTRA_OEMAKE_append_imx8mmevk = " \
    CFG_CORE_DYN_SHM=n CFG_DT=y CFG_OVERLAY_ADDR=0x43600000 \
"

EXTRA_OEMAKE_append_imx6ullevk = " \
    CFG_NS_ENTRY_ADDR= CFG_IMX_WDOG_EXT_RESET=y \
    CFG_EXTERNAL_DTB_OVERLAY=y CFG_DT_ADDR=0x83f00000 \
"
