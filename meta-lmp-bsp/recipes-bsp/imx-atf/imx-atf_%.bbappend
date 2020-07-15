# ATF overrides for Toradex-based devices (based on meta-toradex-nxp)

PLATFORM_mx8qxp  = "imx8qx"

## Apalis-iMX8
PV_apalis-imx8 = "2.0+git${SRCPV}"
SRCBRANCH_apalis-imx8 = "imx_4.14.98_2.3.0"
SRCREV_apalis-imx8 = "bb209a0b4ccca2aa4a3a887f9606dc4a3d294adf"

# imx-atf 1.5 uses bl31-imx8qxp.bin, 2.0 will use bl31-imx8qx.bin for a
# platform specific filename. Provide both for now, so that the user of
# the file need not care.
do_deploy_append_mx8qxp () {
    install -Dm 0644 ${S}/build/${PLATFORM}/release/bl31.bin ${DEPLOYDIR}/${BOOT_TOOLS}/bl31-imx8qx.bin
    install -Dm 0644 ${S}/build/${PLATFORM}/release/bl31.bin ${DEPLOYDIR}/${BOOT_TOOLS}/bl31-imx8qxp.bin
}
