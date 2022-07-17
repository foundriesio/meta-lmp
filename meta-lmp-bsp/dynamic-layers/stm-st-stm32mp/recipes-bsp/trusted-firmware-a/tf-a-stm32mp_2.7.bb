require recipes-bsp/trusted-firmware-a/tf-a-stm32mp-common.inc

SUMMARY = "Trusted Firmware-A for STM32MP1"
SECTION = "bootloaders"
LICENSE = "BSD-3-Clause"
LIC_FILES_CHKSUM = "file://license.rst;md5=1dd070c98a281d18d9eefd938729b031"

PROVIDES += "virtual/trusted-firmware-a"

FILESEXTRAPATHS:prepend:stm32mpcommon := "${THISDIR}/tf-a-stm32mp:"

SRC_URI = "git://github.com/ARM-software/arm-trusted-firmware.git;protocol=https;nobranch=1"
SRCREV = "35f4c7295bafeb32c8bcbdfb6a3f2e74a57e732b"

SRC_URI += " \
     file://0001-feat-stm32mp1-save-boot-auth-status-and-partition-in.patch \
     file://0002-feat-stm32mp1-check-for-fip-a-fip-b-partitions.patch \
     "

TF_A_VERSION = "v2.7.0"
PV = "${TF_A_VERSION}"

ARCHIVER_ST_BRANCH = "${TF_A_VERSION}-${TF_A_SUBVERSION}"
ARCHIVER_ST_REVISION = "${PV}"
ARCHIVER_COMMUNITY_BRANCH = "master"
ARCHIVER_COMMUNITY_REVISION = "${TF_A_VERSION}"

S = "${WORKDIR}/git"

# Configure settings
TFA_PLATFORM  = "stm32mp1"
TFA_ARM_MAJOR = "7"
TFA_ARM_ARCH  = "aarch32"

# Enable the wrapper for debug
TF_A_ENABLE_DEBUG_WRAPPER ?= "1"

# ---------------------------------
# Configure archiver use
# ---------------------------------
include ${@oe.utils.ifelse(d.getVar('ST_ARCHIVER_ENABLE') == '1', 'tf-a-stm32mp-archiver.inc','')}

# ---------------------------------
# Configure devupstream class usage
# ---------------------------------
BBCLASSEXTEND = "devupstream:target"

SRC_URI:class-devupstream = "git://github.com/STMicroelectronics/arm-trusted-firmware.git;protocol=https;branch=${ARCHIVER_ST_BRANCH}"
SRCREV:class-devupstream = "c6da17964e4260944af2a703171a3c36b9e3edf8"

# ---------------------------------
# Configure default preference to manage dynamic selection between tarball and github
# ---------------------------------
STM32MP_SOURCE_SELECTION ?= "tarball"

DEFAULT_PREFERENCE = "${@bb.utils.contains('STM32MP_SOURCE_SELECTION', 'github', '-1', '1', d)}"
