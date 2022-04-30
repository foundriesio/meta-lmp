# Compatible with optee-os-fio and optee-os from meta-arm
require ${@bb.utils.contains('PREFERRED_PROVIDER_virtual/optee-os', 'optee-os', 'recipes-security/optee/optee-os_${PV}.bb', '', d)}
require ${@bb.utils.contains('PREFERRED_PROVIDER_virtual/optee-os', 'optee-os-fio', 'optee-os-fio_${PV}.bb', '', d)}
require ${@bb.utils.contains('PREFERRED_PROVIDER_virtual/optee-os', 'optee-os-fio-mfgtool', 'optee-os-fio-mfgtool_${PV}.bb', '', d)}

SUMMARY = "OP-TEE Trusted OS TA devkit"
DESCRIPTION = "OP-TEE TA devkit for build TAs"
HOMEPAGE = "https://www.op-tee.org/"

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
