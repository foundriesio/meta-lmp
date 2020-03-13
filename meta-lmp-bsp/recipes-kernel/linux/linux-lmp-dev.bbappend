FILESEXTRAPATHS_prepend := "${THISDIR}/${PN}:"

# RPI: 7-Inch display support
SRC_URI_append_rpi = " \
    file://0001-FIO-extras-drm-panel-rpi-add-lcd-rotate-property.patch \
"

# Apalis iMX8
LINUX_VERSION_apalis-imx8 ?= "4.14.y"
KERNEL_REPO_apalis-imx8 ?= "git://git.toradex.com/linux-toradex.git"
KERNEL_BRANCH_apalis-imx8 ?= "toradex_4.14-2.0.x-imx"
KERNEL_COMMIT_apalis-imx8 ?= "fff496c2a1bd08bb4987232c9f3f4b6704bd3146"
LIC_FILES_CHKSUM_apalis-imx8 = "file://COPYING;md5=d7810fab7487fb0aad327b76f1be7cd7"
SRC_URI_append_apalis-imx8 = " \
    file://defconfig \
"
