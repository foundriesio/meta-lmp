# Depend on scr-fit as boot.itb is not yet part of the boot firmware
TI_BOOT_SCRIPT_DEPLOY ?= ""
TI_BOOT_SCRIPT_DEPLOY:sota:k3 = "u-boot-ostree-scr-fit:do_deploy"
do_install[depends] += "${TI_BOOT_SCRIPT_DEPLOY}"

# Depend on u-boot do_deploy for tiboot3.bin, that is provided by the k3r5 variant
TI_BOOT_FW_DEPLOY ?= ""
TI_BOOT_FW_DEPLOY:sota:k3 = "mc::k3r5:u-boot:do_deploy"
do_install[mcdepends] += "${TI_BOOT_FW_DEPLOY}"
