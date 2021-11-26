require optee-os-fio.inc

PV = "3.15.0+git"
SRCREV = "bc4d6d7ebf6ba98c75f7f8cf6ef24353c5a30786"
SRCBRANCH = "3.15+fio"

ALLOW_EMPTY_${PN}-ta-pkcs11 = "1"

DEFAULT_PREFERENCE = "-1"
