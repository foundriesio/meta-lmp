include recipes-bsp/u-boot/u-boot-lmp-common.inc

SRC_URI:append = " \
    ${@bb.utils.contains('MACHINE_FEATURES', 'jailhouse', 'file://0003-HACK-lib-lmb-Allow-re-reserving-post-relocation-U-Bo.patch', '', d)} \
    file://lib-zlib-Fix-a-bug-when-getting-a-gzip-header-extra-field.patch \
    file://k3-accept-filesystem-path-to-the-RoT-key.patch \
    file://k3-set-env-variable-device_type.patch \
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
PACKAGECONFIG[optee] = "TEE=${STAGING_DIR_HOST}${nonarch_base_libdir}/firmware/tee-pager_v2.bin,,${PREFERRED_PROVIDER_virtual/optee-os}"

do_deploy:append() {
    # because TI uses multiconfig we can't have this name shared between machines in
    # meta-lmp-base/recipes-bsp/u-boot/u-boot-lmp-common.inc
    rm ${DEPLOYDIR}/${PN}-config
}

# setting DEPENDS create dependency loops so skip the check
LMPSTAGING_DEPLOYED_CHECK_SKIP += "${PN}:do_deploy"

python() {
    # we need to set the DEPENDS as well to produce valid SPDX documents
    fix_deployed_depends('do_install', d)
}

# Root of Trust Key directory
K3_ROT_KEYS ?= "CONFIG_SIGN_KEY_PATH=${TOPDIR}/conf/keys/platform/ti"
EXTRA_OEMAKE += "$K3_ROT_KEYS"
