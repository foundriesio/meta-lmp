FILESEXTRAPATHS:prepend := "${THISDIR}/${PN}:"

# fix OP-TEE performance regression for Cortex-A9 i.MX6QDL
# fix HDMI for Apalis-iMX6
SRC_URI:append:apalis-imx6 = " \
    file://0001-MLK-16912-PL310-unlock-ways-during-initialization.patch \
    file://0001-FIO-extra-arch-arm-dts-imx6q-apalis-disable-lcdif-pa.patch \
"
