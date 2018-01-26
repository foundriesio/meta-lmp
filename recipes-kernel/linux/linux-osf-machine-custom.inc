# Machine specific configuration

# Machines that were tested and known to work
COMPATIBLE_MACHINE = "(beaglebone|cl-som-imx7|cubox-i|hikey|dragonboard-410c|dragonboard-820c|rpi|stih410-b2260|intel-corei7-64)"

# Generic configs for ARM
KBUILD_DEFCONFIG_aarch64 ?= "defconfig"
KBUILD_DEFCONFIG_armv7a ?= "multi_v7_defconfig"

# Generic configs for X86
KBUILD_DEFCONFIG_intel-corei7-64 ?= "x86_64_defconfig"

# Beagle
KBUILD_DEFCONFIG_beaglebone ?= "omap2plus_defconfig"

# iMX
KBUILD_DEFCONFIG_mx6 ?= "imx_v6_v7_defconfig"
KBUILD_DEFCONFIG_mx7 ?= "imx_v6_v7_defconfig"

# HiKey
SRC_URI_append_hikey += " file://hikey.scc"

# Qcom (db410/db820c)
SRC_URI_append_dragonboard-410c += " file://qcom.scc"
SRC_URI_append_dragonboard-820c += " file://qcom.scc"

# Raspberry Pi
# No common rpi machine override available, need entries for every device
## TODO: Upstream a common override and uboot entrypoint
## Default kernel configs
KBUILD_DEFCONFIG_raspberrypi0-wifi ?= "bcmrpi_defconfig"
KBUILD_DEFCONFIG_raspberrypi ?= "bcmrpi_defconfig"
KBUILD_DEFCONFIG_raspberrypi2 ?= "bcm2709_defconfig"
KBUILD_DEFCONFIG_raspberrypi3 ?= "bcm2709_defconfig"
KBUILD_DEFCONFIG_raspberrypi3-64 ?= "bcmrpi3_defconfig"
UBOOT_ENTRYPOINT_RPI = "0x00008000"
KERNEL_EXTRA_ARGS_rpi += "LOADADDR=${UBOOT_ENTRYPOINT_RPI}"
## Raspberry Pi config fragment
SRC_URI_append_rpi += " file://rpi.scc"

## Default cmdline
CMDLINE_rpi ?= "dwc_otg.lpm_enable=0 console=serial0,115200 root=/dev/mmcblk0p2 rootfstype=ext4 rootwait"

## Deploy cmdline.txt
do_deploy_append_rpi() {
    install -d ${DEPLOYDIR}/bcm2835-bootfiles
    echo "${CMDLINE}" > ${DEPLOYDIR}/bcm2835-bootfiles/cmdline.txt
}

## DB410c fails to build when skales is invoked
do_deploy_append_dragonboard-410c() {
    # FIXME 410c fails to build when skales in invoked
    # |   File "/usr/bin/skales/dtbTool", line 239, in __init__
    # |     self.msm_id[0] = soc_ids[matches['soc']] | (foundry << 16)
    # | KeyError: u'ipq8074'
    rm -f ${B}/arch/arm64/boot/dts/qcom/*ipq8074* || true
}

## DB820c fails to build when skales is invoked
do_deploy_append_dragonboard-820c() {
    # FIXME 820c fails to build when skales in invoked
    # |   File "/usr/bin/skales/dtbTool", line 239, in __init__
    # |     self.msm_id[0] = soc_ids[matches['soc']] | (foundry << 16)
    # | KeyError: u'ipq8074'
    rm -f ${B}/arch/arm64/boot/dts/qcom/*ipq8074* || true
}

## Build issues
## TODO: Validate if still required
do_compile_append_raspberrypi3-64() {
    cc_extra=$(get_cc_option)
    oe_runmake dtbs CC="${KERNEL_CC} $cc_extra " LD="${KERNEL_LD}" ${KERNEL_EXTRA_ARGS}
}

# ST
KERNEL_EXTRA_ARGS_stih410-b2260 += "LOADADDR=${ST_KERNEL_LOADADDR}"

# Machine specific hooks (e.g. hw specific boot images)
def get_include_handler(d):
    machine = d.getVar('MACHINE', True)
    if (machine == "dragonboard-410c"):
        include = "recipes-kernel/linux/linux-qcom-bootimg.inc"
    elif (machine == "dragonboard-820c"):
        include = "recipes-kernel/linux/linux-qcom-bootimg.inc"
    else:
        include = "recipes-kernel/linux/file-cannot-be-found.inc"
    return include

# Use a weak include to avoid to produce an error when the file cannot be found.
# It is the case when we don't have any machine specific hooks.
include ${@get_include_handler(d)}
