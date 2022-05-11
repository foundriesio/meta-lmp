FILESEXTRAPATHS:prepend := "${THISDIR}/${BPN}:"

# Required by docker-vxcan
SRC_URI:append = " file://0001-fix-vxcan-peer.patch"
