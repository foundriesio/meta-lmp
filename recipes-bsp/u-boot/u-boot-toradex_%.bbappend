FILESEXTRAPATHS_prepend := "${THISDIR}/${PN}:"

RDEPENDS_${PN}_append_sota = " u-boot-ostree-scr"

SRC_URI_append_colibri-imx7 = " \
    file://0001-colibri_imx7-run-distro_bootcmd-by-default.patch \
    file://0001-colibri_imx7-prefer-non-secure-mode-by-default.patch \
    file://0001-colibri_imx7_emmc-use-distro-boot-for-internal-eMMC-.patch \
"

SRC_URI_append_apalis-imx6 = " \
    file://0001-apalis_imx6-use-imx6q-apalis-ixora-v1.1.dtb-as-defau.patch \
"
