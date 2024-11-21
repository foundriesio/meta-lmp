SUMMARY = "Produces a Manufacturing Tool compatible U-Boot"
DESCRIPTION = "U-Boot recipe that produces a Manufacturing Tool compatible \
binary to be used in updater environment"

require recipes-bsp/u-boot/u-boot-fio_${PV}.bb

# Environment config is not required for mfgtool
SRC_URI:remove = "file://fw_env.config"
