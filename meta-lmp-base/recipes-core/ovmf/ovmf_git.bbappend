FILESEXTRAPATHS:prepend := "${THISDIR}/${PN}:"

SRC_URI += "\
	file://0001-MdeModulePkg-NvmExpressDxe-fix-check-for-Cap.Css.patch \
	file://0002-MdeModulePkg-NvmExpressPei-fix-check-for-NVM-command.patch \
"

PACKAGECONFIG += "${@bb.utils.contains('MACHINE_FEATURES', 'tpm2', 'tpm2', '', d)}"
PACKAGECONFIG[tpm2] = "-D TPM2_ENABLE=TRUE,-D TPM2_ENABLE=FALSE,,"
