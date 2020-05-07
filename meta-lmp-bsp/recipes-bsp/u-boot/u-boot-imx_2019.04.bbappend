FILESEXTRAPATHS_prepend := "${THISDIR}/${PN}:"

# LMP config extensions
SRC_URI_append_imx8mmevk = " file://0001-imx8mm_evk-lmp-compatibility.patch \
    file://fw_env.config \
"
