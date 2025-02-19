# Enable RPMB emulation on qemuarm64 to easy testing
EXTRA_OECMAKE:append:qemuarm64 = " \
    -DRPMB_EMU=ON \
"
