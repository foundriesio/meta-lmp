# tadevkit requires a matching version on the base recipe.
# control recipe prioritization with DEFAULT_PREFERENCE, as other
# layers (e.g., meta-arm) may provide different OP-TEE versions.
DEFAULT_PREFERENCE = "${@bb.utils.contains('PREFERRED_PROVIDER_virtual/optee-os', 'optee-os', '-1', '0', d)}"

# Compatible with optee-os-fio and optee-os from meta-arm
include ${@bb.utils.contains('PREFERRED_PROVIDER_virtual/optee-os', 'optee-os', 'recipes-security/optee/optee-os_${PV}.bb', '', d)}
include ${@bb.utils.contains('PREFERRED_PROVIDER_virtual/optee-os', 'optee-os-fio', 'recipes-security/optee/optee-os-fio_${PV}.bb', '', d)}

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

# ERROR: optee-os-tadevkit-4.4.0-r0 do_package_qa: QA Issue: File /usr/include/optee/export-user_ta/lib/libdl.a in package optee-os-tadevkit-dev contains reference to TMPDIR [buildpaths]
# ERROR: optee-os-tadevkit-4.4.0-r0 do_package_qa: QA Issue: File /usr/include/optee/export-user_ta/lib/libutee.a in package optee-os-tadevkit-dev contains reference to TMPDIR [buildpaths]
# ERROR: optee-os-tadevkit-4.4.0-r0 do_package_qa: QA Issue: File /usr/include/optee/export-user_ta/lib/libmbedtls.a in package optee-os-tadevkit-dev contains reference to TMPDIR [buildpaths]
# ERROR: optee-os-tadevkit-4.4.0-r0 do_package_qa: QA Issue: File /usr/include/optee/export-user_ta/lib/libutils.a in package optee-os-tadevkit-dev contains reference to TMPDIR [buildpaths]
INSANE_SKIP:${PN}-dev += "buildpaths"
