OPTEEMACHINE_qemuarm64 = "vexpress-qemu_armv8a"
OPTEEMACHINE_uz = "zynqmp-zcu102"

# SoC Settings
EXTRA_OEMAKE_append_uz = " \
    CFG_TZDRAM_START=0x7e000000 CFG_TZDRAM_SIZE=0x1c00000 \
    CFG_SHMEM_START=0x7fc00000 CFG_SHMEM_SIZE=0x400000 \
    CFG_DT=y CFG_GENERATE_DTB_OVERLAY=y CFG_DT_ADDR=0x22000000 \
    CFG_ENABLE_EMBEDDED_TESTS=y \
"

# Machine Settings
EXTRA_OEMAKE_append_qemuarm64 = " \
    CFG_RPMB_FS=y CFG_RPMB_WRITE_KEY=y \
"

# Extra Settings for Secure Machines
EXTRA_OEMAKE_append_uz3eg-iocc-sec = " \
    CFG_REE_FS=n CFG_RPMB_FS=y CFG_RPMB_WRITE_KEY=y \
    CFG_RPMB_FS_DEV_ID=0 CFG_EARLY_TA=y \
    CFG_IN_TREE_EARLY_TAS=fiovb/22250a54-0bf1-48fe-8002-7b20f1c9c9b1 \
"
