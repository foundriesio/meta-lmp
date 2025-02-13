include recipes-bsp/u-boot/u-boot-lmp-common.inc

SRC_URI:append = " \
    file://0001-k3-accept-filesystem-path-to-the-RoT-key.patch \
    file://0002-k3-set-env-variable-device_type.patch \
"

SRC_URI:append:am64xx-evm = " \
    file://fw_env.config \
    file://lmp.cfg \
"

SRC_URI:append:am62xx-evm = " \
    file://fw_env.config \
    file://lmp.cfg \
"

SRC_URI:append:beagleplay-k3r5 = " file://lmp.cfg"
SRC_URI:append:beagleplay = " \
    file://fw_env.config \
    file://lmp.cfg \
"

# lmp-mfgtool
SRC_URI:remove:lmp-mfgtool = "file://fw_env.config file://lmp.cfg"
SRC_URI:append:lmp-mfgtool = " file://lmp-mfgtool.cfg"

PACKAGECONFIG[optee] = "TEE=${STAGING_DIR_HOST}${nonarch_base_libdir}/firmware/tee-pager_v2.bin,,${PREFERRED_PROVIDER_virtual/optee-os}"

do_deploy:append() {
    # because TI uses multiconfig we can't have this name shared between machines in
    # meta-lmp-base/recipes-bsp/u-boot/u-boot-lmp-common.inc
    rm ${DEPLOYDIR}/${PN}-config
}

# Root of Trust Key directory
K3_ROT_KEYS ?= "CONFIG_SIGN_KEY_PATH=${TOPDIR}/conf/keys/platform/ti"
EXTRA_OEMAKE += "$K3_ROT_KEYS"
