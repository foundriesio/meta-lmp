require optee-os-fio.inc

PV = "3.15.0+git"
SRCREV = "74217d5f06feb13bce986d0c8cd5ee07d9e66d00"
SRCBRANCH = "3.15+fio"

ALLOW_EMPTY_${PN}-ta-pkcs11 = "1"

DEFAULT_PREFERENCE = "-1"
