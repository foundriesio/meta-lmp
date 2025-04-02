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
LMP_DISABLE_GPLV3 = "1"
