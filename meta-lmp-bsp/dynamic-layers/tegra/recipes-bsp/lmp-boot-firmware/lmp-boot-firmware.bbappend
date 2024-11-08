TEGRA_INSTALL_DEPENDS ?= ""
TEGRA_INSTALL_DEPENDS:tegra = "tegra-uefi-capsules:do_install"
do_install[depends] += "${TEGRA_INSTALL_DEPENDS}"

inherit l4t_version

def get_dec_bsp_version(bsp_version):
    verparts = bsp_version.split('.')
    return int(verparts[0])<<16 | int(verparts[1])<<8 | int(verparts[2])

LMP_BOOT_FIRMWARE_VERSION:tegra = "${@get_dec_bsp_version(d.getVar('L4T_VERSION'))}"