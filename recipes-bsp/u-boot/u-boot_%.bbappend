FILESEXTRAPATHS_prepend := "${THISDIR}/${PN}:"

RDEPENDS_${PN}_append_sota = " u-boot-ostree-scr"
RDEPENDS_${PN}_remove_rpi = "rpi-u-boot-scr"

# Backports from upstream
SRC_URI_append_sota += " \
    file://0001-spmi-msm-display-the-PMIC-Arb-version-debug.patch  \
    file://0002-dm-core-parse-chosen-node.patch \
    file://0003-arm-mach-snapdragon-refactor-clock-driver.patch \
    file://0004-db820c-add-qualcomm-dragonboard-820C-support.patch \
    file://0005-db820c-enable-pmic-gpios-for-pm8994.patch \
    file://0006-db820c-stop-autoboot-when-vol-pressed.patch \
    file://0007-db410c-configs-increase-gunzip-buffer-size-for-the-k.patch \
    file://0008-db410c-update-wlan-and-bt-mac-addresses-from-firmwar.patch \
    file://0009-db410c-replace-reset-driver-with-psci.patch \
    file://0010-fdtdec-allow-board-to-provide-fdt-for-CONFIG_OF_SEPA.patch \
    file://0011-db410c-use-the-device-tree-parsed-by-the-lk-loader.patch \
    file://0012-db410c-add-reserved-memory-node-to-dts.patch \
"

# LMP specific changes
SRC_URI_append_sota += " \
    file://0013-HACK-disable-emmc.patch \
    file://0014-db410c-config-updates.patch \
    file://0015-db820c-config-updates.patch \
    file://fix_load_addr_db820c.patch \
"

# Boot image for Qcom-based machines
def get_include_handler(d):
    machine = d.getVar('MACHINE', True)
    if (machine == "dragonboard-410c"):
        include = "recipes-bsp/u-boot/u-boot-qcom.inc"
    elif (machine == "dragonboard-820c"):
        include = "recipes-bsp/u-boot/u-boot-qcom.inc"
    else:
        include = "recipes-bsp/u-boot/file-cannot-be-found.inc"
    return include

# Use a weak include to avoid to produce an error when the file cannot be found.
# It is the case when we don't have any machine specific hooks.
include ${@get_include_handler(d)}
