FILESEXTRAPATHS:prepend := "${THISDIR}/${BPN}:"

# Required by docker-vxcan
SRC_URI += "file://0001-fix-vxcan-peer.patch"
