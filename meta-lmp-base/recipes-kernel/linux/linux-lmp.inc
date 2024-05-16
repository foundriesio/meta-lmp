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

# Backport this function from meta-freescale:
# f06c7376 ("linux: Add compatibility logic for 32-bit dtb move")
# A function to strip the new 32-bit dtb sub-folders in KERNEL_DEVICETREE
# for older kernel builds.
# Set KERNEL_DEVICETREE_32BIT_COMPATIBILITY_UPDATE = "1" to enable.
KERNEL_DEVICETREE_32BIT_COMPATIBILITY_UPDATE ?= "0"
python kernel_devicetree_32bit_compatibility_update() {
    import os.path
    import re
    if d.getVar('KERNEL_DEVICETREE_32BIT_COMPATIBILITY_UPDATE') != "1" or d.getVar('TUNE_ARCH') != "arm":
        return
    input = d.getVar('KERNEL_DEVICETREE').split()
    output = ""
    stripped = ""
    for original in input:
        if re.match("^.*/", original):
            stripped = os.path.basename(original)
            output += stripped + " "
            bb.debug(1, "Devicetrees are moved to sub-folder, stripping the sub-folder for older kernel: %s -> %s" % (original, stripped))
        else:
            output += original + " "
    if stripped:
        bb.warn("Updating KERNEL_DEVICETREE, removing sub-folders for older kernel. Use -D for more details. Set KERNEL_DEVICETREE_32BIT_COMPATIBILITY_UPDATE = \"0\" to disable.")
        d.setVar('KERNEL_DEVICETREE', output)
}
addhandler kernel_devicetree_32bit_compatibility_update
kernel_devicetree_32bit_compatibility_update[eventmask] = "bb.event.RecipeParsed"
