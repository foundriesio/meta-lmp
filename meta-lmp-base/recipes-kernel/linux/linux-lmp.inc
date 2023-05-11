DESCRIPTION = "Common Foundries.io Linux microPlatform Kernel"

PV = "${LINUX_VERSION}+git${SRCPV}"

KERNEL_FEATURES += "${@bb.utils.contains('MACHINE_FEATURES', 'jailhouse', ' features/jailhouse/jailhouse.scc', '', d)}"

DEPENDS += "${@bb.utils.contains('ARCH', 'x86', 'elfutils-native', '', d)}"
DEPENDS += "openssl-native util-linux-native"

inherit kernel siteinfo
require recipes-kernel/linux/linux-yocto.inc

KCONFIG_MODE = "--alldefconfig"

LINUX_VERSION_EXTENSION ?= "-lmp-${LINUX_KERNEL_TYPE}"

# Kernel config
KERNEL_CONFIG_NAME ?= "${KERNEL_PACKAGE_NAME}-config-${KERNEL_ARTIFACT_NAME}"
KERNEL_CONFIG_LINK_NAME ?= "${KERNEL_PACKAGE_NAME}-config"

# This is needed to apply an optee overlay
KERNEL_DTC_FLAGS += "-@"

do_deploy:append() {
    # Publish final kernel config with a proper datetime-based link
    cp -a ${B}/.config ${DEPLOYDIR}/${KERNEL_CONFIG_NAME}
    ln -sf ${KERNEL_CONFIG_NAME} ${DEPLOYDIR}/${KERNEL_CONFIG_LINK_NAME}
}
