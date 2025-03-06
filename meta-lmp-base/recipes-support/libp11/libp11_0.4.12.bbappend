FILESEXTRAPATHS:prepend := "${THISDIR}/${PN}:"

SRC_URI += " \
	file://0001-from-list-Introduce-generic-keypair-generation-inter.patch \
	file://0002-from-list-Fix-constness-of-key-generation-attributes.patch \
	file://0003-FIO-internal-ec_keygen-changes-required-for-TPM.patch \
	file://0004-from-upstream-slot-fix-token-initialization.patch \
"
