require optee-os-fio.inc

PV = "3.15.0+git"
SRCREV = "f8f0abea1a1a8bd11c4e531e023368a903fd4ed7"
SRCBRANCH = "3.15+fio"

ALLOW_EMPTY_${PN}-ta-pkcs11 = "1"

DEFAULT_PREFERENCE = "-1"
