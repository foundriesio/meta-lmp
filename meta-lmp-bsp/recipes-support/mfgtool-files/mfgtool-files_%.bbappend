FILESEXTRAPATHS_prepend := "${THISDIR}/${PN}:"

# Machine specific dependencies
def get_do_deploy_depends(d):
    machine = d.getVar('MACHINE')
    if machine == 'imx8mmevk':
        return "imx-boot:do_deploy"
    return ""

do_deploy[depends] += "${@get_do_deploy_depends(d)}"

do_deploy_prepend_imx8mmevk() {
    install -d ${DEPLOYDIR}/${PN}
    install -m 0644 ${DEPLOY_DIR_IMAGE}/imx-boot ${DEPLOYDIR}/${PN}/imx-boot-mfgtool
}
