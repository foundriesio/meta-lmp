# Revert meta-freescale 4bc9568 (scarthgap specific)
do_configure:append() {
    patchelf --replace-needed libtinyxml2.so.10 libtinyxml2.so.9 ${S}/units/cam_device/proprietories/lib/libcam_device.so
    patchelf --replace-needed libtinyxml2.so.10 libtinyxml2.so.9 ${S}/mediacontrol/lib/arm-64/fpga/libcam_device.so
}
