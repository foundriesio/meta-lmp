FILESEXTRAPATHS_prepend := "${THISDIR}/${PN}:"

SRC_URI_append_imx6ullevk = " \
    file://gen_fuse.sh \
    file://gen_fuse.bat \
    file://gen_close.sh \
    file://gen_close.bat \
"
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

do_deploy_prepend_mx8m() {
    install -d ${DEPLOYDIR}/${PN}
    install -m 0644 ${DEPLOY_DIR_IMAGE}/u-boot.itb ${DEPLOYDIR}/${PN}/u-boot-mfgtool.itb
    install -m 0644 ${DEPLOY_DIR_IMAGE}/fitImage-${INITRAMFS_IMAGE}-${MACHINE}-${MACHINE} ${DEPLOYDIR}/${PN}/fitImage-${MACHINE}-mfgtool
}

do_deploy_prepend_imx7ulpea-ucom() {
    install -d ${DEPLOYDIR}/${PN}
    install -m 0644 ${DEPLOY_DIR_IMAGE}/SPL ${DEPLOYDIR}/${PN}/SPL-mfgtool
    install -m 0644 ${DEPLOY_DIR_IMAGE}/u-boot.itb ${DEPLOYDIR}/${PN}/u-boot-mfgtool.itb
    install -m 0644 ${DEPLOY_DIR_IMAGE}/fitImage-${INITRAMFS_IMAGE}-${MACHINE}-${MACHINE} ${DEPLOYDIR}/${PN}/fitImage-${MACHINE}-mfgtool
}

do_deploy_prepend_mx6ull() {
    install -d ${DEPLOYDIR}/${PN}
    install -m 0644 ${DEPLOY_DIR_IMAGE}/SPL ${DEPLOYDIR}/${PN}/SPL-mfgtool
    install -m 0644 ${DEPLOY_DIR_IMAGE}/u-boot.itb ${DEPLOYDIR}/${PN}/u-boot-mfgtool.itb
    install -m 0755 ${WORKDIR}/gen_* ${DEPLOYDIR}/${PN}/
}

do_deploy_prepend_apalis-imx6() {
    install -d ${DEPLOYDIR}/${PN}
    install -m 0644 ${DEPLOY_DIR_IMAGE}/SPL ${DEPLOYDIR}/${PN}/SPL-mfgtool
    install -m 0644 ${DEPLOY_DIR_IMAGE}/u-boot.itb ${DEPLOYDIR}/${PN}/u-boot-mfgtool.itb
}
