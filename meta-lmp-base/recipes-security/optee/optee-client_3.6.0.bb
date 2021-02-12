require optee-client.inc

PV = "3.6.0+git"
SRCREV = "bc0ec8ce1e4dc5ae23f4737ef659338b7cd408fe"

SRC_URI += " \
    file://0001-FIO-extras-Disable-RPMB_EMU-by-default.patch \
"
