SRCBRANCH_apalis-imx8 = "imx_4.14.98_2.3.0"
SRCREV_apalis-imx8 = "d7f9440dd5c050cc22cb362d53d4048e689a0c01"

REV_CHIP ?= "B0"
REV_CHIP_imx8qxpc0mek = "C0"
REV_CHIP_imx8qxpc0lpddr4arm2 = "C0"
REV_CHIP_mx8qxpc0 = "C0"

do_compile_apalis-imx8() {
    cd ${S}
    oe_runmake clean
    oe_runmake bin
    oe_runmake -C iMX8M -f soc.mak mkimage_imx8
    oe_runmake -C iMX8QM REV=${REV_CHIP} -f soc.mak imx8qm_dcd.cfg.tmp
    oe_runmake -C iMX8QX REV=${REV_CHIP} -f soc.mak imx8qx_dcd.cfg.tmp
}
