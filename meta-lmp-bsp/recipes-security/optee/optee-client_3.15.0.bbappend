# Enable RPMB emulation on qemuarm64 to easy testing
EXTRA_OEMAKE:append:qemuarm64 = " \
    RPMB_EMU=1 \
"
