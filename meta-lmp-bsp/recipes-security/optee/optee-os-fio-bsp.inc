OPTEEMACHINE:qemuarm64 = "vexpress-qemu_armv8a"

# Machine Settings
EXTRA_OEMAKE:append:qemuarm64 = " \
    CFG_RPMB_FS=y CFG_RPMB_WRITE_KEY=y \
"
