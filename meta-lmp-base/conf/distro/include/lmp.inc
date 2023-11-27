DISTRO_VERSION = "4.0.20"

# These default to 'oecore' and 'nodistro'
SDK_NAME_PREFIX = "${DISTRO}"
SDK_VERSION = "${DISTRO_VERSION}"

MAINTAINER = "LMP Support <support@foundries.io>"

TARGET_VENDOR = "-lmp"

LMP_FACTORY ?= "lmp"
SPDX_ORG = "Foundries.IO (factory ${LMP_FACTORY})"

TCLIBCAPPEND = ""

require conf/distro/include/arm-defaults.inc
require conf/distro/include/non-clangable.inc
require conf/distro/include/security_flags.inc
require conf/distro/include/yocto-uninative.inc
include conf/distro/include/cve-extra-exclusions.inc
include conf/distro/include/cve-lmp-extra-exclusions.inc

# Default CVE check options
CVE_CHECK_REPORT_PATCHED ?= "0"
CVE_CHECK_SKIP_RECIPE ?= "qemu-native qemu-system-native"

# Disable branch-protection=standard from clang until properly validated (causes issues on aktualizr)
TUNE_CCARGS:remove:toolchain-clang = "${@bb.utils.contains('TUNE_FEATURES', 'aarch64', '-mbranch-protection=standard', '', d)}"

# Include distro features in pre-build configuration output
BUILDCFG_VARS += "DISTRO_FEATURES"

PREFERRED_PROVIDER_virtual/kernel ?= "linux-lmp"
PREFERRED_PROVIDER_virtual/optee-os ?= "optee-os-fio"
PREFERRED_PROVIDER_u-boot-fw-utils ?= "libubootenv"
PREFERRED_RPROVIDER_u-boot-fw-utils ?= "libubootenv"
PREFERRED_PROVIDER_zlib ?= "zlib"
PREFERRED_PROVIDER_zlib-native ?= "zlib-native"
PREFERRED_PROVIDER_nativesdk-zlib ?= "nativesdk-zlib"
PREFERRED_PROVIDER_qemu-native ?= "qemu-native"
PREFERRED_PROVIDER_qemu-helper-native ?= "qemu-helper-native"
PREFERRED_PROVIDER_nativesdk-qemu ?= "nativesdk-qemu"

PREFERRED_VERSION_gcc-arm-none-eabi ?= "11"
PREFERRED_VERSION_gcc-arm-none-eabi-native ?= "11"

# Default distro features for LMP (can be extended by the user if needed)
INIT_MANAGER = "systemd"
DISTRO_FEATURES_DEFAULT = "acl argp bluetooth ext2 ipv4 ipv6 largefile usbgadget usbhost wifi xattr zeroconf pci vfat modsign efi security tpm integrity seccomp"
DISTRO_FEATURES_BACKFILL_CONSIDERED = "pulseaudio ldconfig"
DISTRO_FEATURES:append = " pam usrmerge virtualization alsa"

# List of distro-specific packages to add to all images with packagegroup-distro-base
DISTRO_EXTRA_RRECOMMENDS += "base-files-issue"

# Default IMA policy (tcb)
IMA_POLICY ?= "ima-policy-tcb"

# [FIXME] just for debug propose in main-next
PACKAGECONFIG:append:pn-systemd = " coredump"
# Extended packageconfig options for LMP
# Required because of https://github.com/opencontainers/runc/issues/2008
PACKAGECONFIG:remove:pn-runc-opencontainers = "static"
PACKAGECONFIG:append:pn-qemu-native = " libusb"
PACKAGECONFIG:append:pn-networkmanager = " libedit"
PACKAGECONFIG:remove:pn-networkmanager = " readline"
PACKAGECONFIG:append:pn-kmod = " openssl"
PACKAGECONFIG:append:pn-kmod-native = " openssl"
PACKAGECONFIG:remove:pn-cryptsetup = "ssh-token"
PACKAGECONFIG:append:pn-cryptsetup = " luks2"
PACKAGECONFIG:append:pn-cryptsetup-native = " luks2"
PACKAGECONFIG:pn-tpm2-tss = "policy"

# Alternatives used by nss-altfiles
NSS_ALT_TYPES ?= "hosts,pwd,grp,spwd,sgrp"
# Unix users that will be mirrored in /etc/passwd to allow manipulation
ETC_PASSWD_MEMBERS ?= "${LMP_USER}"
# Unix groups that will be mirrored in /etc/group to allow manipulation
ETC_GROUP_MEMBERS ?= "sudo audio video plugdev users docker"

# Use staticids for deterministic uid/gid values
USERADDEXTENSION = "useradd-staticids"
USERADD_UID_TABLES = "files/lmp-passwd-table"
USERADD_GID_TABLES = "files/lmp-group-table"
USERADD_ERROR_DYNAMIC = "error"

# Default image formats
IMAGE_FSTYPES += "wic wic.gz wic.bmap"
IMAGE_FSTYPES += "${@bb.utils.contains('DISTRO_FEATURES', 'sota', 'ota-ext4.gz', ' ', d)}"
IMAGE_FSTYPES:remove = "tar.gz tar.xz tar.bz2 wic.xz wic.bz2"

# No Ostree tarball by default (prefer ota instead)
BUILD_OSTREE_TARBALL ?= "0"

# LMP default classes and overwrites
INHERIT += "lmp"
INHERIT += "lmp-signing"
INHERIT += "lmp-staging"
INHERIT += "uninative"

# Clang toolchain
TOOLCHAIN ?= "clang"
RUNTIME = "llvm"
# use llvm provided by clang
# https://github.com/kraj/meta-clang/pull/799/files
PREFERRED_PROVIDER_llvm = "clang"
PREFERRED_PROVIDER_llvm-native = "clang-native"
PREFERRED_PROVIDER_nativesdk-llvm = "nativesdk-clang"
PROVIDES:pn-clang = "llvm"
PROVIDES:pn-clang-native = "llvm-native"
PROVIDES:pn-nativesdk-clang = "nativesdk-llvm"

PREMIRRORS += "\
     git://.*/.* https://storage.googleapis.com/lmp-cache/downloads/ \n \
     ftp://.*/.* https://storage.googleapis.com/lmp-cache/downloads/ \n \
     http://.*/.* https://storage.googleapis.com/lmp-cache/downloads/ \n \
     https://.*/.* https://storage.googleapis.com/lmp-cache/downloads/ \n \
"

MIRRORS =+ "\
     git://.*/.* https://storage.googleapis.com/lmp-cache/downloads/ \n \
     ftp://.*/.* https://storage.googleapis.com/lmp-cache/downloads/ \n \
     http://.*/.* https://storage.googleapis.com/lmp-cache/downloads/ \n \
     https://.*/.* https://storage.googleapis.com/lmp-cache/downloads/ \n \
"

# Compatibility with other layers
BBMASK += " \
    /meta-virtualization/recipes-kernel/linux/linux-%.bbappend \
    /meta-virtualization/dynamic-layers/xilinx/recipes-extended/xen/xen_4.14.bbappend \
    /meta-security/meta-integrity/recipes-core/systemd/systemd_%.bbappend \
    /meta-st-stm32mp/recipes-st/images/st-image-bootfs-efi.bb \
"

# meta-xilinx/meta-xilinx-tools: mask recipes not required for lmp
BBMASK += " \
    /meta-xilinx-tools/recipes-bsp/ai-engine/aiefal_1.0.bb \
    /meta-xilinx-tools/recipes-bsp/u-boot/u-boot-xlnx_%.bbappend \
"
# meta-st-stm32mp: mask recipes and appends that are not required by lmp
BBMASK += " \
    /meta-st-stm32mp/recipes-core/busybox/busybox_%.bbappend \
    /meta-st-stm32mp/recipes-devtools/gcc/gcc-source_12.3.bbappend \
    /meta-st-stm32mp/recipes-graphics/drm/libdrm_2.4.115.bbappend \
    /meta-st-stm32mp/recipes-bsp/trusted-firmware-a/tf-a-stm32mp_2.6.bb \
"
# meta-ti-bsp: mask optee and jailhouse related recipes as they are provided by lmp
BBMASK += " \
    /meta-ti/meta-ti-bsp/recipes-security/optee \
    /meta-ti/meta-ti-extras/recipes-ti/jailhouse \
"

# disable xsct tarball by default (xilinx)
USE_XSCT_TARBALL = "0"

# QA check settings - follow poky, which is stricter than the OE-Core defaults
WARN_TO_ERROR_QA = "already-stripped compile-host-path install-host-path \
                    installed-vs-shipped ldflags pn-overrides rpaths staticdev \
                    unknown-configure-option useless-rpaths"
WARN_QA:remove = "${WARN_TO_ERROR_QA}"
ERROR_QA:append = " ${WARN_TO_ERROR_QA}"
ERROR_QA:remove = "version-going-backwards"

# Required to avoid removing libraries used during signing
RM_WORK_EXCLUDE += "make-mod-scripts"

LMP_USER ?= "fio"
# LMP_PASSWORD is a hassed password. To generate the hash use the following command on a host machine
# mkpasswd -m sha512crypt
# When copy and pasting the hash, remember to escape any $ character as in the following example
LMP_PASSWORD ?= "\$6\$OxIhuUvtdFqmUyLv\$gnwD.Qz53y.hvkLc5LyClP8MSRMtG8VZHz.qg/OvRep93ls.2CGzYvINCOrdXYU4yi1q394gWXqixRxO9yCSU/"
