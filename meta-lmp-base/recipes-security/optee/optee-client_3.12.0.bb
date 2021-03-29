require optee-client.inc

SRCREV = "347144b79964233e718347e3f0fbe89ab5be46ae"
DEFAULT_PREFERENCE = "-1"

SRC_URI += " \
    file://0001-tee-supplicant-rpmb-switch-to-MMC_IOC_MULTI_CMD.patch \
"
