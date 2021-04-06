FILESEXTRAPATHS_prepend := "${THISDIR}/${PN}:"

SRC_URI += " \
    file://defconfig \
"

# fix OP-TEE performance regression for Cortex-A9 i.MX6QDL
SRC_URI_append_apalis-imx6 = " \
    file://0001-MLK-16912-PL310-unlock-ways-during-initialization.patch \
"
