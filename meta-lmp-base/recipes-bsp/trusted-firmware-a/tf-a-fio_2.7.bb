require tf-a-fio-common.inc

SUMMARY = "Trusted Firmware-A FIO"
SECTION = "bootloaders"
LICENSE = "BSD-3-Clause"
LIC_FILES_CHKSUM = "file://license.rst;md5=1dd070c98a281d18d9eefd938729b031"

PROVIDES += "virtual/trusted-firmware-a"

SRC_URI = "git://github.com/ARM-software/arm-trusted-firmware.git;protocol=https;nobranch=1"
SRCREV = "35f4c7295bafeb32c8bcbdfb6a3f2e74a57e732b"

TF_A_VERSION = "v2.7.0"
PV = "${TF_A_VERSION}"

S = "${WORKDIR}/git"

# Configure settings
TFA_PLATFORM  ?= ""
TFA_ARM_MAJOR ?= "7"
TFA_ARM_ARCH  ?= "aarch32"

# Enable the wrapper for debug
TF_A_ENABLE_DEBUG_WRAPPER ?= "1"

# ---------------------------------
# Configure default preference to manage dynamic selection between tarball and github
# ---------------------------------
TF_A_SOURCE_SELECTION ?= "tarball"

DEFAULT_PREFERENCE = "${@bb.utils.contains('TF_A_SOURCE_SELECTION', 'github', '-1', '1', d)}"
