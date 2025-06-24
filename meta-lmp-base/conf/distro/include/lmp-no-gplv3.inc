# LmP incompatible license images wrapper varaibles to mimic the image override
# INCOMPATIBLE_LICENSE:pn-image and IMAGE_INCOMPATIBLE_LICENSE_EXCEPTIONS:pn-image
IMAGE_INCOMPATIBLE_LICENSE = "GPL-3.0* LGPL-3.0* AGPL-3.0*"

# Upstream oe-core configuration options to excluded from the build GPLv3 content in the target images
require conf/distro/include/no-gplv3.inc

# General LMP build options for disabling usage of GPLv3 based components
# and dependencies.
RRECOMMENDS:packagegroup-base-vfat:remove = "dosfstools"
PACKAGECONFIG:remove:pn-python3 = "readline"
PACKAGECONFIG:remove:pn-curl = "libidn"
PACKAGECONFIG:remove:pn-bluez5 = "readline mesh"
PACKAGECONFIG:append:pn-bluez5 = " libedit "
PACKAGECONFIG:remove:pn-iproute2 = "elf"
PACKAGECONFIG:remove:pn-wireguard-tools = "bash-completion wg-quick"
PACKAGECONFIG:remove:pn-networkmanager = "readline ifupdown"
PACKAGECONFIG:remove:pn-systemd = "vconsole"
PACKAGECONFIG:remove:pn-nftables = "readline"
