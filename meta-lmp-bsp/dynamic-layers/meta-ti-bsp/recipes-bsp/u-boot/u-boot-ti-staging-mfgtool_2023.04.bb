SUMMARY = "Produces a Manufacturing Tool compatible U-Boot"
DESCRIPTION = "U-Boot recipe that produces a Manufacturing Tool compatible \
binary to be used in updater environment"

require recipes-bsp/u-boot/u-boot-ti-staging_${PV}.bb

FILESEXTRAPATHS:prepend := "${THISDIR}/u-boot-ti-staging:"

include u-boot-ti-staging.inc

# Environment config is not required for mfgtool
SRC_URI:remove = "file://fw_env.config"
SRC_URI:remove = "file://lmp.cfg"
SRC_URI:append = " file://lmp-mfgtool.cfg"
