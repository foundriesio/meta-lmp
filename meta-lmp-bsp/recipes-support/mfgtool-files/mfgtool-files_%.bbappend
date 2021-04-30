FILESEXTRAPATHS_prepend := "${THISDIR}/${PN}:"

SRC_URI_append_imx6ullevk-sec = " \
    file://fuse.uuu \
    file://close.uuu \
    file://readme.md \
"

SRC_URI_append_apalis-imx6-sec = " \
    file://fuse.uuu \
    file://close.uuu \
    file://readme.md \
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
}

do_compile_append_imx6ullevk-sec(){
    sed -i -e 's/SPL-mfgtool/&.signed/g' -e 's/SPL-.*-sec/&.signed/g' bootloader.uuu
    sed -i -e 's/SPL-mfgtool/&.signed/g' -e 's/SPL-.*-sec/&.signed/g' full_image.uuu
}

do_deploy_prepend_imx6ullevk-sec() {
    install -d ${DEPLOYDIR}/${PN}
    install -m 0644 ${WORKDIR}/fuse.uuu ${DEPLOYDIR}/${PN}/fuse.uuu
    install -m 0644 ${WORKDIR}/close.uuu ${DEPLOYDIR}/${PN}/close.uuu
    install -m 0644 ${WORKDIR}/readme.md ${DEPLOYDIR}/${PN}/readme.md
}

do_deploy_prepend_apalis-imx6() {
    install -d ${DEPLOYDIR}/${PN}
    install -m 0644 ${DEPLOY_DIR_IMAGE}/SPL ${DEPLOYDIR}/${PN}/SPL-mfgtool
    install -m 0644 ${DEPLOY_DIR_IMAGE}/u-boot.itb ${DEPLOYDIR}/${PN}/u-boot-mfgtool.itb
}

do_compile_append_apalis-imx6-sec() {
    sed -i 's/SPL.*/&.signed/g' bootloader.uuu
    sed -i 's/SPL.*/&.signed/g' full_image.uuu
}

do_deploy_prepend_apalis-imx6-sec() {
    install -d ${DEPLOYDIR}/${PN}
    install -m 0644 ${WORKDIR}/fuse.uuu ${DEPLOYDIR}/${PN}/fuse.uuu
    install -m 0644 ${WORKDIR}/close.uuu ${DEPLOYDIR}/${PN}/close.uuu
    install -m 0644 ${WORKDIR}/readme.md ${DEPLOYDIR}/${PN}/readme.md
}
