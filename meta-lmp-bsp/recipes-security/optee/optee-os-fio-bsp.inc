OPTEEMACHINE:am62xx = "k3-am62x"
OPTEEMACHINE:am64xx = "k3-am64x"
OPTEEMACHINE:imx6ulevk = "imx-mx6ulevk"
OPTEEMACHINE:imx6ullevk = "imx-mx6ullevk"
OPTEEMACHINE:imx8mm-lpddr4-evk = "imx-mx8mmevk"
OPTEEMACHINE:imx8mp-lpddr4-evk = "imx-mx8mpevk"
OPTEEMACHINE:imx8mq-evk = "imx-mx8mqevk"
OPTEEMACHINE:imx8mn-ddr4-evk = "imx-mx8mnevk"
OPTEEMACHINE:imx8mn-lpddr4-evk = "imx-mx8mnevk"
OPTEEMACHINE:imx8qm-mek = "imx-mx8qmmek"
OPTEEMACHINE:imx93-11x11-lpddr4x-evk = "imx-mx93evk"
OPTEEMACHINE:qemuarm64 = "vexpress-qemu_armv8a"

# SoC Settings
# https://github.com/OP-TEE/optee_os/issues/7327
EXTRA_OEMAKE:append:imx-generic-bsp = " \
    CFG_CORE_HUK_SUBKEY_COMPAT_USE_OTP_DIE_ID=n \
"
EXTRA_OEMAKE:append:mx8m-nxp-bsp = " \
    CFG_NXP_CAAM=y CFG_NXP_CAAM_RNG_DRV=y \
    CFG_WITH_SOFTWARE_PRNG=n CFG_CRYPTO_DRIVER=y CFG_HWRNG_PTA=y CFG_HWRNG_QUALITY=1024 \
    CFG_DT=y CFG_EXTERNAL_DTB_OVERLAY=y CFG_DT_ADDR=0x43200000 \
    CFG_CORE_HEAP_SIZE=131072 \
"
EXTRA_OEMAKE:append:mx8qm-nxp-bsp = " \
    CFG_DT=y CFG_EXTERNAL_DTB_OVERLAY=y CFG_DT_ADDR=0x83200000 \
"
EXTRA_OEMAKE:append:mx93-nxp-bsp = " \
    CFG_DT=y CFG_EXTERNAL_DTB_OVERLAY=y CFG_DT_ADDR=0x83200000 \
"

# Machine Settings
EXTRA_OEMAKE:append:am62xx-evm = " \
    CFG_WITH_SOFTWARE_PRNG=y \
"
EXTRA_OEMAKE:append:imx8qm-mek = " \
    CFG_NXP_CAAM=y CFG_NXP_CAAM_RNG_DRV=y \
    CFG_WITH_SOFTWARE_PRNG=n CFG_CRYPTO_DRIVER=y CFG_HWRNG_PTA=y CFG_HWRNG_QUALITY=1024 \
"
EXTRA_OEMAKE:append:imx6ulevk = " \
    CFG_NS_ENTRY_ADDR=0x87800000 CFG_NXP_CAAM=y \
    CFG_TZDRAM_START=0x9e000000 CFG_DT=y CFG_OVERLAY_ADDR=0x86000000 \
"
EXTRA_OEMAKE:append:imx6ullevk = " \
    CFG_NS_ENTRY_ADDR=0x87800000 CFG_TZDRAM_START=0x9e000000 \
    CFG_WITH_SOFTWARE_PRNG=n CFG_IMX_RNGB=y CFG_HWRNG_PTA=y CFG_HWRNG_QUALITY=1024 \
    CFG_DT=y CFG_OVERLAY_ADDR=0x86000000 \
"
EXTRA_OEMAKE:append:imx8mp-lpddr4-evk = " \
    CFG_TZDRAM_START=0x56000000 \
"
EXTRA_OEMAKE:append:imx8mn-ddr4-evk = " \
    CFG_TZDRAM_START=0x56000000 \
"
EXTRA_OEMAKE:append:imx8mn-lpddr4-evk = " \
    CFG_TZDRAM_START=0x56000000 \
"
EXTRA_OEMAKE:append:qemuarm64 = " \
    CFG_RPMB_FS=y CFG_RPMB_WRITE_KEY=y \
"

# Additional Settings for SE05X
EXTRA_OEMAKE:append:imx6ullevk = " \
    ${@bb.utils.contains('MACHINE_FEATURES', 'se05x', 'CFG_IMX_I2C=y CFG_CORE_SE05X_I2C_BUS=1', '', d)} \
"
EXTRA_OEMAKE:append:imx8mm-lpddr4-evk = " \
    ${@bb.utils.contains('MACHINE_FEATURES', 'se05x', 'CFG_IMX_I2C=y CFG_CORE_SE05X_I2C_BUS=2', '', d)} \
"
EXTRA_OEMAKE:append:imx8mp-lpddr4-evk = " \
    ${@bb.utils.contains('MACHINE_FEATURES', 'se05x', 'CFG_IMX_I2C=y CFG_CORE_SE05X_I2C_BUS=4', '', d)} \
"
EXTRA_OEMAKE:append:imx8mn-ddr4-evk = " \
    ${@bb.utils.contains('MACHINE_FEATURES', 'se05x', 'CFG_IMX_I2C=y CFG_CORE_SE05X_I2C_BUS=2', '', d)} \
"
EXTRA_OEMAKE:append:imx8mn-lpddr4-evk = " \
    ${@bb.utils.contains('MACHINE_FEATURES', 'se05x', 'CFG_IMX_I2C=y CFG_CORE_SE05X_I2C_BUS=2', '', d)} \
"

# Extra Settings for Secure Machines
EXTRA_OEMAKE:append:imx8qm-mek-sec = " \
    CFG_REE_FS=n CFG_RPMB_FS=y CFG_RPMB_FS_DEV_ID=0 \
"
EXTRA_OEMAKE:append:imx8mm-lpddr4-evk-sec = " \
    CFG_REE_FS=n CFG_RPMB_FS=y CFG_RPMB_FS_DEV_ID=2 \
"
EXTRA_OEMAKE:append:imx8mp-lpddr4-evk-sec = " \
    CFG_REE_FS=n CFG_RPMB_FS=y CFG_RPMB_FS_DEV_ID=2 \
"
EXTRA_OEMAKE:append:imx8mn-ddr4-evk-sec = " \
    CFG_REE_FS=n CFG_RPMB_FS=y CFG_RPMB_FS_DEV_ID=2 \
"
EXTRA_OEMAKE:append:imx8mn-lpddr4-evk-sec = " \
    CFG_REE_FS=n CFG_RPMB_FS=y CFG_RPMB_FS_DEV_ID=2 \
"
