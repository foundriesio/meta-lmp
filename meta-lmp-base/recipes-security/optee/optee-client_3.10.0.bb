require optee-client-fio.inc

SRCREV = "e7a4706e08c8fbdd53530868a6ac4937193dd73c"

SRC_URI += " \
    file://0001-Disable-RPMB_EMU-by-default-3.10.patch \
    file://0001-tee-supplicant-rpmb-switch-to-MMC_IOC_MULTI_CMD.patch \
"
