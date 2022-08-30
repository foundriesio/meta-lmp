FILESEXTRAPATHS:prepend := "${THISDIR}/${PN}:"

SRC_URI:append:versal = " \
       file://0001-enable-nvm.patch \
       file://0001-enable-puf.patch \
"
