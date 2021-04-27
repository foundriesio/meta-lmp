require optee-test.inc

SRCREV = "f88f69eb27beda52998de09cd89a7ee422da00d9"

EXTRA_OEMAKE += " \
    CFG_PKCS11_TA=y \
"

do_compile_append() {
    oe_runmake test_plugin
}

do_install_append() {
    # install path should match the value set in optee-client/tee-supplicant
    # default CFG_TEE_PLUGIN_LOAD_PATH is /usr/lib/tee-supplicant/plugins/
    mkdir -p ${D}${libdir}/tee-supplicant/plugins
    install -D -p -m0444 ${B}/supp_plugin/*.plugin ${D}${libdir}/tee-supplicant/plugins/
}

FILES_${PN} += "${libdir}/tee-supplicant/plugins/"

DEFAULT_PREFERENCE = "-1"
