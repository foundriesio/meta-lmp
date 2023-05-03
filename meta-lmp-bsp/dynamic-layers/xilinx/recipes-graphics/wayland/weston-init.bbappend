FILESEXTRAPATHS:prepend := "${THISDIR}/${PN}:"

SRC_URI:prepend:zynqmp:lmp-wayland = " \
    file://weston.service.zynqmp.patch \
"
