require linux.inc
require linux-qcom-bootimg.inc

DESCRIPTION = "Common Open Source Foundries Linux microPlatform Kernel"

PV = "4.11+git${SRCPV}"
SRCREV_kernel = "241905c635e97ed48885582055b19d1fea51b7f5"
SRCREV_FORMAT = "kernel"
OSF_LMP_GIT_URL ?= "source.foundries.io"
OSF_LMP_GIT_NAMESPACE ?= ""

SRC_URI = "git://${OSF_LMP_GIT_URL}/${OSF_LMP_GIT_NAMESPACE}linux.git;protocol=https;branch=linux-v4.11.y-dev;name=kernel \
    file://distro.config \
"
SRC_URI_append_hikey += "file://hikey.config"

S = "${WORKDIR}/git"

KERNEL_DEFCONFIG_beaglebone ?= "${S}/arch/arm/configs/omap2plus_defconfig"
KERNEL_DEFCONFIG_aarch64 ?= "${S}/arch/arm64/configs/defconfig"
KERNEL_DEFCONFIG_armv7a ?= "${S}/arch/arm/configs/multi_v7_defconfig"
KERNEL_DEFCONFIG_mx6 ?= "${S}/arch/arm/configs/imx_v6_v7_defconfig"
KERNEL_DEFCONFIG_mx7 ?= "${S}/arch/arm/configs/imx_v6_v7_defconfig"
KERNEL_DEFCONFIG_intel-core2-32 ?= "${S}/arch/x86/configs/i386_defconfig"
KERNEL_DEFCONFIG_intel-corei7-64 ?= "${S}/arch/x86/configs/x86_64_defconfig"
KERNEL_CONFIG_FRAGMENTS += "${WORKDIR}/distro.config"
KERNEL_CONFIG_FRAGMENTS_append_hikey += " ${WORKDIR}/hikey.config"

# ST
KERNEL_EXTRA_ARGS_append_stih410-b2260 += " \
    LOADADDR=${ST_KERNEL_LOADADDR} TEXT_OFFSET=0x00008000 "

# NXP
## Reuse board config by removing dtb that is not available upstream
KERNEL_DEVICETREE_ls1043ardb = "freescale/fsl-ls1043a-rdb.dtb"

COMPATIBLE_MACHINE = "(beaglebone|cl-som-imx7|cubox-i|hikey|dragonboard-410c|dragonboard-820c|ls1043ardb|stih410-b2260|intel-core2-32|intel-corei7-64)"
KERNEL_IMAGETYPE ?= "Image"

# make[3]: *** [scripts/extract-cert] Error 1
DEPENDS += "openssl-native"
HOST_EXTRACFLAGS += "-I${STAGING_INCDIR_NATIVE}"

do_configure() {
    # Make sure to disable debug info and enable ext4fs built-in
    sed -e '/CONFIG_EXT4_FS=/d' \
        -e '/CONFIG_DEBUG_INFO=/d' \
        < ${KERNEL_DEFCONFIG} \
        > ${B}/.config

    echo 'CONFIG_EXT4_FS=y' >> ${B}/.config
    echo '# CONFIG_DEBUG_INFO is not set' >> ${B}/.config

    # Check for kernel config fragments. The assumption is that the config
    # fragment will be specified with the absolute path. For example:
    #   * ${WORKDIR}/config1.cfg
    #   * ${S}/config2.cfg
    # Iterate through the list of configs and make sure that you can find
    # each one. If not then error out.
    # NOTE: If you want to override a configuration that is kept in the kernel
    #       with one from the OE meta data then you should make sure that the
    #       OE meta data version (i.e. ${WORKDIR}/config1.cfg) is listed
    #       after the in-kernel configuration fragment.
    # Check if any config fragments are specified.
    if [ ! -z "${KERNEL_CONFIG_FRAGMENTS}" ]; then
        for f in ${KERNEL_CONFIG_FRAGMENTS}; do
            # Check if the config fragment was copied into the WORKDIR from
            # the OE meta data
            if [ ! -e "$f" ]; then
                echo "Could not find kernel config fragment $f"
                exit 1
            fi
        done

        # Now that all the fragments are located merge them.
        ( cd ${WORKDIR} && ${S}/scripts/kconfig/merge_config.sh -m -r -O ${B} ${B}/.config ${KERNEL_CONFIG_FRAGMENTS} 1>&2 )
    fi

    yes '' | oe_runmake -C ${S} O=${B} oldconfig

    bbplain "Saving defconfig to:\n${B}/defconfig"
    oe_runmake -C ${B} savedefconfig
}

do_deploy_append() {
    cp -a ${B}/defconfig ${DEPLOYDIR}
    cp -a ${B}/.config ${DEPLOYDIR}/config
}
