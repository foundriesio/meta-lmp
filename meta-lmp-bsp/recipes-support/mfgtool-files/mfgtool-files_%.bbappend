FILESEXTRAPATHS_prepend := "${THISDIR}/${PN}:"

# Machine specific dependencies
def get_do_deploy_depends(d):
    imxboot_families = ['mx8']
    cur_families = (d.getVar('MACHINEOVERRIDES') or '').split(':')
    if any(map(lambda x: x in cur_families, imxboot_families)):
        return "imx-boot:do_deploy"
    return ""

do_deploy[depends] += "${@get_do_deploy_depends(d)}"

do_deploy_prepend_mx8() {
    install -d ${DEPLOYDIR}/${PN}
    install -m 0644 ${DEPLOY_DIR_IMAGE}/imx-boot ${DEPLOYDIR}/${PN}/imx-boot-mfgtool
}

do_deploy_prepend_mx6ull() {
    install -d ${DEPLOYDIR}/${PN}
    install -m 0644 ${DEPLOY_DIR_IMAGE}/SPL ${DEPLOYDIR}/${PN}/SPL-mfgtool
    install -m 0644 ${DEPLOY_DIR_IMAGE}/u-boot.itb ${DEPLOYDIR}/${PN}/u-boot-mfgtool.itb
}

do_deploy_prepend_apalis-imx6() {
    install -d ${DEPLOYDIR}/${PN}
    install -m 0644 ${DEPLOY_DIR_IMAGE}/SPL ${DEPLOYDIR}/${PN}/SPL-mfgtool
    install -m 0644 ${DEPLOY_DIR_IMAGE}/u-boot.itb ${DEPLOYDIR}/${PN}/u-boot-mfgtool.itb
}
