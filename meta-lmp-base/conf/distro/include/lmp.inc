DISTRO_VERSION = "3.3"

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
PREFERRED_PROVIDER_virtual/docker = "docker-moby"

# Default distro features for LMP (can be extended by the user if needed)
INIT_MANAGER = "systemd"
DISTRO_FEATURES_DEFAULT = "acl argp bluetooth ext2 ipv4 ipv6 largefile usbgadget usbhost wifi xattr zeroconf pci vfat modsign"
DISTRO_FEATURES_BACKFILL_CONSIDERED = "pulseaudio ldconfig"
DISTRO_FEATURES_append = " pam usrmerge seccomp virtualization ptest"

# Default IMA policy (tcb)
IMA_POLICY ?= "ima-policy-tcb"

# Extended packageconfig options for LMP
PACKAGECONFIG_append_pn-docker-ce = " seccomp"
PACKAGECONFIG_append_pn-docker-moby = " seccomp"
# Required because of https://github.com/opencontainers/runc/issues/2008
PACKAGECONFIG_remove_pn-runc-docker = "static"
PACKAGECONFIG_append_pn-systemd = " journal-upload resolved seccomp serial-getty-generator"
PACKAGECONFIG_remove_pn-systemd = "networkd"
PACKAGECONFIG_append_pn-qemu-native = " libusb"
PACKAGECONFIG_append_pn-networkmanager = " nss"

# Alternatives used by nss-altfiles
NSS_ALT_TYPES ?= "hosts,pwd,grp,spwd,sgrp"

# Use staticids for deterministic uid/gid values
USERADDEXTENSION = "useradd-staticids"
USERADD_UID_TABLES = "files/lmp-passwd-table"
USERADD_GID_TABLES = "files/lmp-group-table"
USERADD_ERROR_DYNAMIC = "error"

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
    /meta-security/meta-integrity/recipes-core/systemd/systemd_%.bbappend \
    /meta-updater/recipes-connectivity/nfs-utils/nfs-utils_%.bbappend \
"

# meta-arm: mask op-tee as we have our own recipes (until merged in meta-arm)
BBMASK += " \
    /meta-arm/meta-arm/recipes-security/optee/optee-test_3.11.0.bb \
    /meta-arm/meta-arm/recipes-security/optee/optee-os_3.11.0.bb \
    /meta-arm/meta-arm/recipes-security/optee/optee-examples_3.11.0.bb \
    /meta-arm/meta-arm/recipes-security/optee/optee-client_3.11.0.bb \
    /meta-arm/meta-arm-bsp/recipes-security/optee/optee-client_3.11.0.bbappend \
    /meta-arm/meta-arm-bsp/recipes-security/optee/optee-os_3.11.0.bbappend \
    /meta-arm/meta-arm-bsp/recipes-security/optee/optee-test_3.11.0.bbappend \
"
# meta-xilinx/meta-xilinx-tools: mask recipes not required for lmp
BBMASK += " \
    /meta-xilinx-bsp/recipes-kernel/linux-firmware/linux-firmware_%.bbappend \
    /meta-xilinx-tools/recipes-bsp/ai-engine/aiefal_1.0.bb \
"
# meta-st-stm32mp: mask libdrm append only compatible with gatesgarth
BBMASK += " \
    /meta-st-stm32mp/recipes-graphics/drm/libdrm_2.4.102.bbappend \
"

# disable xsct tarball by default (xilinx)
USE_XSCT_TARBALL = "0"

# QA check settings - follow poky, which is stricter than the OE-Core defaults
WARN_TO_ERROR_QA = "already-stripped compile-host-path install-host-path \
                    installed-vs-shipped ldflags pn-overrides rpaths staticdev \
                    unknown-configure-option useless-rpaths"
WARN_QA_remove = "${WARN_TO_ERROR_QA}"
ERROR_QA_append = " ${WARN_TO_ERROR_QA}"
ERROR_QA_remove = "version-going-backwards"

LMP_USER ?= "fio"
LMP_PASSWORD ?= "fio"
