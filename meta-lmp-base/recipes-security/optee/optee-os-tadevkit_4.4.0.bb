# tadevkit requires a matching version on the base recipe
# meta-arm kirkstone is using 3.16 by default
DEFAULT_PREFERENCE = "${@bb.utils.contains('PREFERRED_PROVIDER_virtual/optee-os', 'optee-os', '-1', '0', d)}"

# Compatible with optee-os-fio and optee-os from meta-arm
include ${@bb.utils.contains('PREFERRED_PROVIDER_virtual/optee-os', 'optee-os', 'recipes-security/optee/optee-os_${PV}.bb', '', d)}
include ${@bb.utils.contains('PREFERRED_PROVIDER_virtual/optee-os', 'optee-os-fio', 'recipes-security/optee/optee-os-fio_${PV}.bb', '', d)}
include ${@bb.utils.contains('PREFERRED_PROVIDER_virtual/optee-os', 'optee-os-fio-mfgtool', 'recipes-security/optee/optee-os-fio-mfgtool_${PV}.bb', '', d)}

SUMMARY = "OP-TEE Trusted OS TA devkit"
DESCRIPTION = "OP-TEE TA devkit for build TAs"
HOMEPAGE = "https://www.op-tee.org/"

LICENSE ?= "BSD-2-Clause"
LIC_FILES_CHKSUM ?= "file://${COMMON_LICENSE_DIR}/BSD-2-Clause;md5=cb641bc04cda31daea161b1bc15da69f"

# Needed due provides from optee-os-fio (for virtual/optee-os)
PROVIDES = "${PN}"

do_install() {
    #install TA devkit
    install -d ${D}${includedir}/optee/export-user_ta/
    for f in ${B}/export-ta_${OPTEE_ARCH}/* ; do
        cp -aR $f ${D}${includedir}/optee/export-user_ta/
    done
}

do_deploy() {
    echo "Do not inherit do_deploy from optee-os."
}

FILES:${PN} = "${includedir}/optee/"
