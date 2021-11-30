OPTEEMACHINE_apalis-imx8 = "imx-mx8qmmek"
OPTEEMACHINE_imx8mm-lpddr4-evk = "imx-mx8mmevk"
OPTEEMACHINE_imx8mp-lpddr4-evk = "imx-mx8mpevk"
OPTEEMACHINE_imx8mq-evk = "imx-mx8mqevk"
OPTEEMACHINE_imx8qm-mek = "imx-mx8qmmek"
OPTEEMACHINE_qemuarm64 = "vexpress-qemu_armv8a"
OPTEEMACHINE_uz = "zynqmp-zcu102"

# SoC Settings
EXTRA_OEMAKE_append_mx8m = " \
    CFG_NXP_CAAM=y CFG_NXP_CAAM_RNG_DRV=y \
    CFG_WITH_SOFTWARE_PRNG=n CFG_CRYPTO_DRIVER=y CFG_RNG_PTA=y \
    CFG_DT=y CFG_EXTERNAL_DTB_OVERLAY=y CFG_DT_ADDR=0x43200000 \
"
EXTRA_OEMAKE_append_mx8qm = " \
    CFG_DT=y CFG_EXTERNAL_DTB_OVERLAY=y CFG_DT_ADDR=0x83200000 \
"
EXTRA_OEMAKE_append_uz = " \
    CFG_TZDRAM_START=0x7e000000 CFG_TZDRAM_SIZE=0x1c00000 \
    CFG_SHMEM_START=0x7fc00000 CFG_SHMEM_SIZE=0x400000 \
    CFG_DT=y CFG_GENERATE_DTB_OVERLAY=y CFG_DT_ADDR=0x22000000 \
    CFG_ENABLE_EMBEDDED_TESTS=y \
"

# Machine Settings
EXTRA_OEMAKE_append_apalis-imx8 = " \
    CFG_UART_BASE=0x5a070000 \
"
EXTRA_OEMAKE_append_imx8mp-lpddr4-evk = " \
    CFG_TZDRAM_START=0x56000000 \
"
EXTRA_OEMAKE_append_qemuarm64 = " \
    CFG_RPMB_FS=y CFG_RPMB_WRITE_KEY=y \
"

# Extra Settings for Secure Machines
EXTRA_OEMAKE_append_uz3eg-iocc-sec = " \
    CFG_REE_FS=n CFG_RPMB_FS=y CFG_RPMB_WRITE_KEY=y \
    CFG_RPMB_FS_DEV_ID=0 CFG_EARLY_TA=y \
    CFG_IN_TREE_EARLY_TAS=fiovb/22250a54-0bf1-48fe-8002-7b20f1c9c9b1 \
"
EXTRA_OEMAKE_append_imx8mm-lpddr4-evk-sec = " \
    CFG_REE_FS=n CFG_RPMB_FS=y CFG_RPMB_FS_DEV_ID=2 \
    CFG_EARLY_TA=y \
    CFG_IN_TREE_EARLY_TAS=fiovb/22250a54-0bf1-48fe-8002-7b20f1c9c9b1 \
"
