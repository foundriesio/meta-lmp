FILESEXTRAPATHS_prepend := "${THISDIR}/${PN}:"

RDEPENDS_${PN}_append_sota = " u-boot-ostree-scr"
DEPENDS_remove_rpi = "rpi-u-boot-scr"

SRC_URI_append = " \
    file://0001-fat-check-for-buffer-size-before-reading-blocks.patch \
"

SRC_URI_append_rpi = " \
    file://0001-rpi-set-CONFIG_SYS_BOOTM_LEN-to-32M.patch \
    file://0001-rpi_defconfig-enable-support-for-FIT.patch \
    file://0001-rpi-prefer-downstream-dtb-files.patch \
"

SRC_URI_append_beaglebone-yocto = " \
    file://beaglebone-extend-usb-ether.patch \
"

# DB410c specific changes
SRC_URI_append_dragonboard-410c = " \
    file://0001-HACK-disable-emmc.patch \
    file://0002-db410c-config-updates.patch \
    file://config-db410c-disable-autoboot-console-check.patch \
"

# DB820c specific changes
SRC_URI_append_dragonboard-820c = " \
    file://0003-db820c-config-updates.patch \
    file://0001-Revert-Revert-Revert-efi_loader-efi_allocate_pages-i.patch \
    file://dragonboard820c_defconfig-enable-support-for-FIT.patch \
    file://config-db820c-disable-autoboot-console-check.patch \
"

# Boot image for Qcom-based machines
def get_include_handler(d):
    machine = d.getVar('MACHINE')
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
