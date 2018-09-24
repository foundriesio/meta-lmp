FILESEXTRAPATHS_prepend := "${THISDIR}/${PN}:"

RDEPENDS_${PN}_append_sota = " u-boot-ostree-scr"
DEPENDS_remove_rpi = "rpi-u-boot-scr"

SRC_URI_append_beaglebone-yocto += " \
    file://beaglebone-extend-usb-ether.patch \
"

# LMP specific changes
SRC_URI_append_sota += " \
    file://configs-dragonboard410-820-remove-qcom-dir-from-fdtf.patch \
    file://0001-HACK-disable-emmc.patch \
    file://0002-db410c-config-updates.patch \
    file://0003-db820c-config-updates.patch \
    file://fix_load_addr_db820c.patch \
    file://configs-dragonboard-disable-autoboot-console-check.patch \
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
