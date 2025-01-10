OPTEEMACHINE:am62xx = "k3-am62x"
OPTEEMACHINE:am64xx = "k3-am64x"
OPTEEMACHINE:imx6ulevk = "imx-mx6ulevk"
OPTEEMACHINE:imx6ullevk = "imx-mx6ullevk"
OPTEEMACHINE:imx7ulpea-ucom = "imx-mx7ulpevk"
OPTEEMACHINE:imx8mm-lpddr4-evk = "imx-mx8mmevk"
OPTEEMACHINE:imx8mp-lpddr4-evk = "imx-mx8mpevk"
OPTEEMACHINE:imx8mq-evk = "imx-mx8mqevk"
OPTEEMACHINE:imx8mn-ddr4-evk = "imx-mx8mnevk"
OPTEEMACHINE:imx8mn-lpddr4-evk = "imx-mx8mnevk"
OPTEEMACHINE:imx8qm-mek = "imx-mx8qmmek"
OPTEEMACHINE:imx8ulp-lpddr4-evk = "imx-mx8ulpevk"
OPTEEMACHINE:imx93-11x11-lpddr4x-evk = "imx-mx93evk"
OPTEEMACHINE:qemuarm64 = "vexpress-qemu_armv8a"
OPTEEMACHINE:stm32mp15-disco = "stm32mp1-157C_DK2"
OPTEEMACHINE:stm32mp15-eval = "stm32mp1-157C_EV1"

# SoC Settings
EXTRA_OEMAKE:append:mx8m-nxp-bsp = " \
    CFG_NXP_CAAM=y CFG_NXP_CAAM_RNG_DRV=y \
    CFG_WITH_SOFTWARE_PRNG=n CFG_CRYPTO_DRIVER=y CFG_HWRNG_PTA=y CFG_HWRNG_QUALITY=1024 \
    CFG_DT=y CFG_EXTERNAL_DTB_OVERLAY=y CFG_DT_ADDR=0x43200000 \
    CFG_CORE_HEAP_SIZE=131072 \
"
EXTRA_OEMAKE:append:mx8ulp-nxp-bsp = " \
    CFG_NXP_CAAM=y CFG_NXP_CAAM_RNG_DRV=y \
    CFG_WITH_SOFTWARE_PRNG=n CFG_CRYPTO_DRIVER=y \
    CFG_DT=y CFG_EXTERNAL_DTB_OVERLAY=y CFG_DT_ADDR=0x9d000000 \
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
EXTRA_OEMAKE:append:imx7ulpea-ucom = " \
    CFG_DRAM_BASE=0x60000000 CFG_NS_ENTRY_ADDR=0x67800000 \
    CFG_TZDRAM_START=0x9e000000 \
    CFG_DT=y CFG_OVERLAY_ADDR=0x65000000 \
    CFG_NXP_CAAM=y \
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
EXTRA_OEMAKE:append:stm32mp15-disco = " \
    CFG_OVERLAY_ADDR=0xC4300000 \
"
EXTRA_OEMAKE:append:stm32mp15-eval = " \
    CFG_OVERLAY_ADDR=0xC4300000 \
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
EXTRA_OEMAKE:append:stm32mp15-disco = " \
    ${@bb.utils.contains('MACHINE_FEATURES', 'se05x', 'CFG_STM32_CRYPTO_DRIVER=n CFG_STM32_CRYP=n CFG_STM32_I2C=y CFG_CORE_SE05X_I2C_BUS=5 CFG_WITH_NSEC_I2CS=y', '', d)} \
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

EXTRA_OEMAKE:append:stm32mp15-eval-sec = " \
    CFG_STM32MP15_HUK=y \
    CFG_STM32MP15_HUK_BSEC_KEY_0=60 \
    CFG_STM32MP15_HUK_BSEC_KEY_1=61 \
    CFG_STM32MP15_HUK_BSEC_KEY_2=62 \
    CFG_STM32MP15_HUK_BSEC_KEY_3=63 \
    CFG_REE_FS=n CFG_RPMB_FS=y \
    CFG_RPMB_FS_DEV_ID=1 \
"
