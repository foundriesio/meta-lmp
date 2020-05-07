FILESEXTRAPATHS_prepend := "${THISDIR}/${PN}:"

# RPI: 7-Inch display support
SRC_URI_append_rpi = " \
    file://0001-FIO-extras-drm-panel-rpi-add-lcd-rotate-property.patch \
"

# Apalis iMX8
LINUX_VERSION_apalis-imx8 ?= "4.14.y"
KERNEL_REPO_apalis-imx8 ?= "git://git.toradex.com/linux-toradex.git"
KERNEL_BRANCH_apalis-imx8 ?= "toradex_4.14-2.3.x-imx"
KERNEL_COMMIT_apalis-imx8 ?= "5c643afa32bee5141224919d63a0fafa955cf709"
LIC_FILES_CHKSUM_apalis-imx8 = "file://COPYING;md5=d7810fab7487fb0aad327b76f1be7cd7"
SRC_URI_append_apalis-imx8 = " \
    file://defconfig \
"
