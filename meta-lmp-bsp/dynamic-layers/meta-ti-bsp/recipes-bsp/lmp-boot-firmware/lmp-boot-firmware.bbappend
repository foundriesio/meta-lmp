# Depend on scr-fit as boot.itb is not yet part of the boot firmware
TI_BOOT_SCRIPT_DEPLOY ?= ""
TI_BOOT_SCRIPT_DEPLOY:sota:k3 = "u-boot-ostree-scr-fit:do_deploy"
do_install[depends] += "${TI_BOOT_SCRIPT_DEPLOY}"

# MC task dependencies for TI_SCI_FW
TI_SCI_FW_DEPLOY ?= ""
TI_SCI_FW_DEPLOY:am62xx-evm = "mc::lmp-k3r5:ti-sci-fw:do_deploy"
TI_SCI_FW_DEPLOY:am64xx-evm = "mc::lmp-k3r5-gp:ti-sci-fw:do_deploy mc::lmp-k3r5-sr2-hs-fs:ti-sci-fw:do_deploy mc::lmp-k3r5-sr2-hs-se:ti-sci-fw:do_deploy"
do_install[mcdepends] += "${TI_SCI_FW_DEPLOY}"
