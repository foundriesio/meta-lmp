require recipes-kernel/wireguard/wireguard.inc

SRCREV = "81570925e480778aafd570ed86987db744582e7a"

SRC_URI = "git://git.zx2c4.com/wireguard-linux-compat"

inherit module kernel-module-split

DEPENDS = "virtual/kernel libmnl"

# This module requires Linux 3.10 higher and several networking related
# configuration options. For exact kernel requirements visit:
# https://www.wireguard.io/install/#kernel-requirements

EXTRA_OEMAKE_append = " \
    KERNELDIR=${STAGING_KERNEL_DIR} \
    "

MAKE_TARGETS = "module"
MODULES_INSTALL_TARGET = "module-install"

RRECOMMENDS_${PN} = "kernel-module-xt-hashlimit"
MODULE_NAME = "wireguard"

# Kernel module packages MUST begin with 'kernel-module-', otherwise
# multilib image generation can fail.
#
# The following line is only necessary if the recipe name does not begin
# with kernel-module-.
PKG_${PN} = "kernel-module-${MODULE_NAME}"

# WireGuard has been merged into Linux kernel >= 5.6 and therefore this compatibility module is no longer required.
# OE-core post dunfell has moved to use kernel 5.8 which now means we cant build this module in world builds
# for reference machines e.g. qemu
EXCLUDE_FROM_WORLD = "1"
