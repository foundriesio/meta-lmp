FILESEXTRAPATHS_prepend := "${THISDIR}/${PN}:"

do_deploy_apalis-imx8() {
    install -d ${DEPLOYDIR}
    install -m 0644 boot.scr ${DEPLOYDIR}/boot.scr-${MACHINE}-${PV}-${PR}
    ln -sf boot.scr-${MACHINE}-${PV}-${PR} ${DEPLOYDIR}/boot.scr-${MACHINE}
    ln -sf boot.scr-${MACHINE}-${PV}-${PR} ${DEPLOYDIR}/boot.scr
    install -m 0644 uEnv.txt ${DEPLOYDIR}/uEnv-lmp.txt
}
