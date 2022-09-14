FILESEXTRAPATHS:prepend := "${THISDIR}/${PN}:"

do_install:append:stm32mp15-eval() {
    install -m 0644 ${DEPLOYDIR}/boot.scr ${D}/boot.scr
    install -m 0644 ${DEPLOYDIR}/uEnv.txt ${D}/uEnv.txt
}

FILES:${PN} += " \
    boot.scr \
    uEnv.txt \
"
