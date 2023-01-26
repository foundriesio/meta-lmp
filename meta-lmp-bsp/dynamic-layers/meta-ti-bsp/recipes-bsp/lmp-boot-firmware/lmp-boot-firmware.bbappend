# Depend on scr-fit as boot.itb is not yet part of the boot firmware
TI_BOOT_SCRIPT_DEPLOY ?= ""
TI_BOOT_SCRIPT_DEPLOY:sota:k3 = "u-boot-ostree-scr-fit:do_deploy"
do_install[depends] += "${TI_BOOT_SCRIPT_DEPLOY}"
