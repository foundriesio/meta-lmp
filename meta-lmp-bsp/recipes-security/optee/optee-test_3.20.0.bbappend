FILESEXTRAPATHS:prepend := "${THISDIR}/${PN}:"

SRC_URI:append:versal = " \
	file://0001-versal-add-option-to-disable-AES-GCM-unaligned-tests.patch \
"

EXTRA_OEMAKE:append:versal = " CFG_CRYPTO_VERSAL=y"
