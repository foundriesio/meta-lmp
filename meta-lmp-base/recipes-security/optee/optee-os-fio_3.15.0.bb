require optee-os-fio.inc

PV = "3.15.0+git"
SRCREV = "56918f1a8939fd1426f8a34c1d213f5f6707e8f5"
SRCBRANCH = "3.15+fio"

ALLOW_EMPTY_${PN}-ta-pkcs11 = "1"

DEFAULT_PREFERENCE = "-1"
