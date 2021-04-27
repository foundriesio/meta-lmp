# Enable RPMB emulation on qemuarm64 to easy testing
EXTRA_OEMAKE_append_qemuarm64 = " \
    RPMB_EMU=1 \
"
