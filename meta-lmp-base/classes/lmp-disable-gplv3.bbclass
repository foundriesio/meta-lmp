# General LMP build options for disabling usage of GPLv3 based components
# and dependencies.
RRECOMMENDS_packagegroup-base-vfat_remove = "dosfstools"
PACKAGECONFIG_remove_pn-python3 = "readline"
PACKAGECONFIG_remove_pn-curl = "libidn"
PACKAGECONFIG_remove_pn-bluez5 = "readline mesh"
PACKAGECONFIG_remove_pn-iproute2 = "elf"
LMP_DISABLE_GPLV3 = "1"

# TODO: switch to a solution that doesn't depend on parted
CORE_IMAGE_BASE_INSTALL_remove = "resize-helper"
