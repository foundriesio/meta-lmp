TEGRA_INSTALL_DEPENDS ?= ""
TEGRA_INSTALL_DEPENDS:tegra = "tegra-uefi-capsules:do_install"
do_install[depends] += "${TEGRA_INSTALL_DEPENDS}"
