DISTRO_VERSION = "3.2"

# These default to 'oecore' and 'nodistro'
SDK_NAME_PREFIX = "${DISTRO}"
SDK_VERSION = "${DISTRO_VERSION}"

MAINTAINER = "LMP Support <support@foundries.io>"

TARGET_VENDOR = "-lmp"

TCLIBCAPPEND = ""

require conf/distro/include/arm-defaults.inc
require conf/distro/include/security_flags.inc

PREFERRED_PROVIDER_virtual/kernel ?= "linux-lmp"
PREFERRED_PROVIDER_virtual/optee-os ?= "optee-os-fio"
PREFERRED_PROVIDER_u-boot-fw-utils ?= "libubootenv"
PREFERRED_RPROVIDER_u-boot-fw-utils ?= "libubootenv"
PREFERRED_PROVIDER_zlib ?= "zlib"
PREFERRED_PROVIDER_zlib-native ?= "zlib-native"
PREFERRED_PROVIDER_nativesdk-zlib ?= "nativesdk-zlib"
PREFERRED_PROVIDER_qemu-native ?= "qemu-native"
PREFERRED_PROVIDER_nativesdk-qemu ?= "nativesdk-qemu"
PREFERRED_PROVIDER_virtual/docker ?= "docker-ce"
PREFERRED_PROVIDER_virtual/docker_riscv64 ?= "docker-moby"

# Default distro features for LMP (can be extended by the user if needed)
DISTRO_FEATURES_DEFAULT = "acl argp bluetooth ext2 ipv4 ipv6 largefile usbgadget usbhost wifi xattr zeroconf pci vfat"
DISTRO_FEATURES_BACKFILL_CONSIDERED = "pulseaudio sysvinit ldconfig"
DISTRO_FEATURES_append = " pam systemd usrmerge virtualization ptest"
VIRTUAL-RUNTIME_init_manager = "systemd"

# Extended packageconfig options for LMP
PACKAGECONFIG_append_pn-docker-ce = " seccomp"
PACKAGECONFIG_append_pn-runc-docker = " seccomp"
# Required because of https://github.com/opencontainers/runc/issues/2008
PACKAGECONFIG_remove_pn-runc-docker = "static"
PACKAGECONFIG_append_pn-systemd = " journal-upload resolved seccomp serial-getty-generator"
PACKAGECONFIG_remove_pn-systemd = "networkd"
PACKAGECONFIG_append_pn-qemu-native = " libusb"
PACKAGECONFIG_append_pn-networkmanager = " nss"
PACKAGECONFIG_remove_pn-networkmanager = " dnsmasq"

# Default image formats
IMAGE_FSTYPES = "wic wic.gz wic.bmap"
IMAGE_FSTYPES_remove = "tar.gz tar.bz2"

# No Ostree tarball by default (prefer ota instead)
BUILD_OSTREE_TARBALL ?= "0"

# LMP default classes and overwrites
INHERIT += "lmp"

INHERIT += "buildhistory"
INHERIT += "image-buildinfo"
BUILDHISTORY_COMMIT = "1"

PREMIRRORS ??= "\
     git://.*/.* https://storage.googleapis.com/lmp-cache/downloads/ \n \
     ftp://.*/.* https://storage.googleapis.com/lmp-cache/downloads/ \n \
     http://.*/.* https://storage.googleapis.com/lmp-cache/downloads/ \n \
     https://.*/.* https://storage.googleapis.com/lmp-cache/downloads/ \n \
"

MIRRORS =+ "\
     ftp://.*/.* https://storage.googleapis.com/lmp-cache/downloads/ \n \
     http://.*/.* https://storage.googleapis.com/lmp-cache/downloads/ \n \
     https://.*/.* https://storage.googleapis.com/lmp-cache/downloads/ \n \
"

# Compatibility with other layers
BBMASK += " \
    /meta-virtualization/recipes-kernel/linux/linux-%.bbappend \
    /meta-security/recipes-kernel/linux/linux-%_5.%.bbappend \
    /meta-updater/recipes-connectivity/nfs-utils/nfs-utils_%.bbappend \
"

# meta-arm: mask op-tee as we have our own recipes (until merged in meta-arm)
BBMASK += " \
    /meta-arm/meta-arm/recipes-security/optee/optee-test_3.8.0.bb \
    /meta-arm/meta-arm/recipes-security/optee/optee-test_3.11.0.bb \
    /meta-arm/meta-arm/recipes-security/optee/optee-os_3.8.0.bb \
    /meta-arm/meta-arm/recipes-security/optee/optee-os_3.11.0.bb \
    /meta-arm/meta-arm/recipes-security/optee/optee-examples_3.8.0.bb \
    /meta-arm/meta-arm/recipes-security/optee/optee-examples_3.11.0.bb \
    /meta-arm/meta-arm/recipes-security/optee/optee-client_3.8.0.bb \
    /meta-arm/meta-arm/recipes-security/optee/optee-client_3.11.0.bb \
"
# meta-arm-bsp: mask recipes from meta-kernel as we have our own recipes
BBMASK += " \
    /meta-arm-bsp/recipes-kernel/linux/linux-stable_%.bbappend \
    /meta-arm-bsp/recipes-kernel/linux/linux-stable_5.3%.bbappend \
    /meta-arm-bsp/recipes-kernel/linux/linux-stable_5.6%.bbappend \
    /meta-arm-bsp/recipes-kernel/linux/linux-stable_5.7%.bbappend \
"
# meta-xilinx/meta-xilinx-tools: mask recipes not required for lmp
BBMASK += " \
    /meta-xilinx-bsp/recipes-kernel/linux-firmware/linux-firmware_%.bbappend \
    /meta-xilinx-tools/recipes-bsp/ai-engine/ai-engine-driver_1.0.bb \
    /meta-xilinx-tools/recipes-bsp/ai-engine/ai-engine-driver_2.0.bb \
"

# only zynqmp machines inherit Xilinx xsct tarball download class
INHERIT_remove = "${@ ' xsct-tc' if d.getVar('SOC_FAMILY') != 'zynqmp' else ''}"

# QA check settings - follow poky, which is stricter than the OE-Core defaults
WARN_TO_ERROR_QA = "already-stripped compile-host-path install-host-path \
                    installed-vs-shipped ldflags pn-overrides rpaths staticdev \
                    unknown-configure-option useless-rpaths"
WARN_QA_remove = "${WARN_TO_ERROR_QA}"
ERROR_QA_append = " ${WARN_TO_ERROR_QA}"
ERROR_QA_remove = "version-going-backwards"

LMP_USER ?= "fio"
LMP_PASSWORD ?= "fio"
