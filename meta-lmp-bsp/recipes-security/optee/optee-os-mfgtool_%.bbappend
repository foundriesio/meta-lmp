OPTEEMACHINE_imx8mmevk = "imx-imx8mmevk"

EXTRA_OEMAKE_append_imx8mmevk = " \
    CFG_DT=y CFG_OVERLAY_ADDR=0x43600000 \
"
EXTRA_OEMAKE_append_imx = " \
		CFG_NXP_WORKAROUND_CAAM_LOCKED_BY_HAB=y \
"
