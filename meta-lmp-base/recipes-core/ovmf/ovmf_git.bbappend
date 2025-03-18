PACKAGECONFIG += "${@bb.utils.contains('MACHINE_FEATURES', 'tpm2', 'tpm2', '', d)}"
PACKAGECONFIG[tpm2] = "-D TPM2_ENABLE=TRUE,-D TPM2_ENABLE=FALSE,,"
