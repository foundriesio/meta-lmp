require optee-os-fio.inc

PV = "3.15.0+git"
SRCREV = "f76500f29c755926c6800dfaae18940666a7abee"
SRCBRANCH = "3.15+fio"

ALLOW_EMPTY_${PN}-ta-pkcs11 = "1"

DEFAULT_PREFERENCE = "-1"
