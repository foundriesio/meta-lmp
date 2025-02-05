FILESEXTRAPATHS:prepend := "${THISDIR}/${PN}:"

PACKAGECONFIG += "${@bb.utils.contains('MACHINE_FEATURES', 'tpm2', 'tpm2', '', d)}"
PACKAGECONFIG[tpm2] = "-D TPM2_ENABLE=TRUE,-D TPM2_ENABLE=FALSE,,"


SRC_URI += "file://0001-CryptoPkg-Increase-ScratchMemory-buffer-for-openssl-.patch"