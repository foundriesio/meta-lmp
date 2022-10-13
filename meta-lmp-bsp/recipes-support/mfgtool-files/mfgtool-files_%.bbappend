FILESEXTRAPATHS:prepend := "${THISDIR}/${PN}:"

SRC_URI:append:imx6ullevk-sec = " \
    file://fuse.uuu \
    file://close.uuu \
    file://readme.md \
"

SRC_URI:append:apalis-imx6-sec = " \
    file://fuse.uuu \
    file://close.uuu \
    file://readme.md \
"

SRC_URI:append:apalis-imx8-sec = " \
    file://fuse.uuu \
    file://close.uuu \
    file://readme.md \
"

SRC_URI:append:imx8qm-mek-sec = " \
    file://fuse.uuu \
    file://close.uuu \
    file://readme.md \
"

SRC_URI:append:imx8mm-lpddr4-evk-sec = " \
    file://fuse.uuu \
    file://close.uuu \
    file://readme.md \
"

SRC_URI:append:imx8mp-lpddr4-evk-sec = " \
    file://fuse.uuu \
    file://close.uuu \
    file://readme.md \
"

# Machine specific dependencies
def get_do_deploy_depends(d):
    imxboot_families = ['mx8-nxp-bsp']
    cur_families = (d.getVar('MACHINEOVERRIDES') or '').split(':')
    if any(map(lambda x: x in cur_families, imxboot_families)):
        return "imx-boot:do_deploy"
    return ""

do_deploy[depends] += "${@get_do_deploy_depends(d)}"

do_deploy:prepend:mx8-nxp-bsp() {
    install -d ${DEPLOYDIR}/${PN}
    install -m 0644 ${DEPLOY_DIR_IMAGE}/imx-boot ${DEPLOYDIR}/${PN}/imx-boot-mfgtool
    install -m 0644 ${DEPLOY_DIR_IMAGE}/u-boot.itb ${DEPLOYDIR}/${PN}/u-boot-mfgtool.itb
    install -m 0644 ${DEPLOY_DIR_IMAGE}/fitImage-${INITRAMFS_IMAGE}-${MACHINE}-${MACHINE} ${DEPLOYDIR}/${PN}/fitImage-${MACHINE}-mfgtool
}

do_deploy:prepend:imx7ulpea-ucom() {
    install -d ${DEPLOYDIR}/${PN}
    install -m 0644 ${DEPLOY_DIR_IMAGE}/SPL ${DEPLOYDIR}/${PN}/SPL-mfgtool
    install -m 0644 ${DEPLOY_DIR_IMAGE}/u-boot.itb ${DEPLOYDIR}/${PN}/u-boot-mfgtool.itb
    install -m 0644 ${DEPLOY_DIR_IMAGE}/fitImage-${INITRAMFS_IMAGE}-${MACHINE}-${MACHINE} ${DEPLOYDIR}/${PN}/fitImage-${MACHINE}-mfgtool
}

do_deploy:prepend:mx6ul-nxp-bsp() {
    install -d ${DEPLOYDIR}/${PN}
    install -m 0644 ${DEPLOY_DIR_IMAGE}/SPL ${DEPLOYDIR}/${PN}/SPL-mfgtool
    install -m 0644 ${DEPLOY_DIR_IMAGE}/u-boot.itb ${DEPLOYDIR}/${PN}/u-boot-mfgtool.itb
}

do_deploy:prepend:mx6ull-nxp-bsp() {
    install -d ${DEPLOYDIR}/${PN}
    install -m 0644 ${DEPLOY_DIR_IMAGE}/SPL ${DEPLOYDIR}/${PN}/SPL-mfgtool
    install -m 0644 ${DEPLOY_DIR_IMAGE}/u-boot.itb ${DEPLOYDIR}/${PN}/u-boot-mfgtool.itb
}

do_compile:append:imx6ullevk-sec(){
    sed -i -e 's/SPL-mfgtool/&.signed/g' -e 's/SPL-.*-sec/&.signed/g' bootloader.uuu
    sed -i -e 's/SPL-mfgtool/&.signed/g' -e 's/SPL-.*-sec/&.signed/g' full_image.uuu
}

do_deploy:prepend:imx6ullevk-sec() {
    install -d ${DEPLOYDIR}/${PN}
    install -m 0644 ${WORKDIR}/fuse.uuu ${DEPLOYDIR}/${PN}/fuse.uuu
    install -m 0644 ${WORKDIR}/close.uuu ${DEPLOYDIR}/${PN}/close.uuu
    install -m 0644 ${WORKDIR}/readme.md ${DEPLOYDIR}/${PN}/readme.md
}

do_deploy:prepend:apalis-imx6() {
    install -d ${DEPLOYDIR}/${PN}
    install -m 0644 ${DEPLOY_DIR_IMAGE}/SPL ${DEPLOYDIR}/${PN}/SPL-mfgtool
    install -m 0644 ${DEPLOY_DIR_IMAGE}/u-boot.itb ${DEPLOYDIR}/${PN}/u-boot-mfgtool.itb
}

do_compile:append:apalis-imx6-sec() {
    sed -i 's/SPL.*/&.signed/g' bootloader.uuu
}

do_deploy:prepend:apalis-imx6-sec() {
    install -d ${DEPLOYDIR}/${PN}
    install -m 0644 ${WORKDIR}/fuse.uuu ${DEPLOYDIR}/${PN}/fuse.uuu
    install -m 0644 ${WORKDIR}/close.uuu ${DEPLOYDIR}/${PN}/close.uuu
    install -m 0644 ${WORKDIR}/readme.md ${DEPLOYDIR}/${PN}/readme.md
}

do_compile:append:apalis-imx8-sec() {
    sed -i 's/imx-boot.*/&.signed/g' bootloader.uuu
}

do_deploy:prepend:apalis-imx8-sec() {
    install -d ${DEPLOYDIR}/${PN}
    install -m 0644 ${WORKDIR}/fuse.uuu ${DEPLOYDIR}/${PN}/fuse.uuu
    install -m 0644 ${WORKDIR}/close.uuu ${DEPLOYDIR}/${PN}/close.uuu
    install -m 0644 ${WORKDIR}/readme.md ${DEPLOYDIR}/${PN}/readme.md
}

do_compile:append:imx8qm-mek-sec() {
    sed -i 's/imx-boot.*/&.signed/g' bootloader.uuu
}

do_deploy:prepend:imx8qm-mek-sec() {
    install -d ${DEPLOYDIR}/${PN}
    install -m 0644 ${WORKDIR}/fuse.uuu ${DEPLOYDIR}/${PN}/fuse.uuu
    install -m 0644 ${WORKDIR}/close.uuu ${DEPLOYDIR}/${PN}/close.uuu
    install -m 0644 ${WORKDIR}/readme.md ${DEPLOYDIR}/${PN}/readme.md
}

do_compile:append:imx8mm-lpddr4-evk-sec() {
    sed -i 's/imx-boot.*/&.signed/g' bootloader.uuu
}

do_deploy:prepend:imx8mm-lpddr4-evk-sec() {
    install -d ${DEPLOYDIR}/${PN}
    install -m 0644 ${WORKDIR}/fuse.uuu ${DEPLOYDIR}/${PN}/fuse.uuu
    install -m 0644 ${WORKDIR}/close.uuu ${DEPLOYDIR}/${PN}/close.uuu
    install -m 0644 ${WORKDIR}/readme.md ${DEPLOYDIR}/${PN}/readme.md
}

do_compile:append:imx8mp-lpddr4-evk-sec() {
    sed -i 's/imx-boot.*/&.signed/g' bootloader.uuu
}

do_deploy:prepend:imx8mp-lpddr4-evk-sec() {
    install -d ${DEPLOYDIR}/${PN}
    install -m 0644 ${WORKDIR}/fuse.uuu ${DEPLOYDIR}/${PN}/fuse.uuu
    install -m 0644 ${WORKDIR}/close.uuu ${DEPLOYDIR}/${PN}/close.uuu
    install -m 0644 ${WORKDIR}/readme.md ${DEPLOYDIR}/${PN}/readme.md

}
