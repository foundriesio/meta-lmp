# ATF overrides for Toradex-based devices (based on meta-toradex-nxp)

PLATFORM_mx8qxp  = "imx8qxp"

## Apalis-iMX8
PV_apalis-imx8 = "1.5.0+git${SRCPV}"
SRCBRANCH_apalis-imx8 = "imx_4.14.78_1.0.0_ga"
SRCREV_apalis-imx8 = "d6451cc1e162eff89b03dd63e86d55b9baa8885b"

# imx-atf 1.5 uses bl31-imx8qxp.bin, 2.0 will use bl31-imx8qx.bin for a
# platform specific filename. Provide both for now, so that the user of
# the file need not care.
do_deploy_append_mx8qxp () {
    install -Dm 0644 ${S}/build/${PLATFORM}/release/bl31.bin ${DEPLOYDIR}/${BOOT_TOOLS}/bl31-imx8qx.bin
}
