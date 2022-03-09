FILESEXTRAPATHS:prepend := "${THISDIR}/${PN}:"

SRC_URI:append:corstone700-mps3 = " \
    file://0001-corstone700-update-bootargs-and-initrd-address.patch \
"
