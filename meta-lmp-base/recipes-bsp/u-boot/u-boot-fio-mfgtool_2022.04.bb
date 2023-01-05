SUMMARY = "Produces a Manufacturing Tool compatible U-Boot"
DESCRIPTION = "U-Boot recipe that produces a Manufacturing Tool compatible \
binary to be used in updater environment"

require recipes-bsp/u-boot/u-boot-fio_2022.04.bb

# Environment config is not required for mfgtool
SRC_URI:remove = "file://fw_env.config"

SRC_URI:append:imx8mp-lpddr4-evk = " file://0001-FIO-extra-bootcmd_mfg-start-USB-again.patch "
