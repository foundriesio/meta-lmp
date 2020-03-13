FILESEXTRAPATHS_prepend := "${THISDIR}/${PN}:"

do_deploy_apalis-imx8() {
    install -d ${DEPLOYDIR}
    install -m 0644 boot.scr ${DEPLOYDIR}
    install -m 0644 uEnv.txt ${DEPLOYDIR}/uEnv-lmp.txt
}
