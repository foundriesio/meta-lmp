SCFW_TDX_SRC = "git://github.com/toradex/i.MX-System-Controller-Firmware.git"

SRC_URI_append_toradex = " ${SCFW_TDX_SRC};branch=master;protocol=https;fsl-eula=true"

SRCREV_toradex = "1f184f12405d681d23b77cf5bac66110b9d34ddf"

do_patch[prefuncs] += "do_cp_scfw"
do_cp_scfw_toradex() {
    cp ${WORKDIR}/git/src/scfw_export_*/build_*/*-scfw-tcm.bin ${S}/
}
do_cp_scfw() {
    :
}
