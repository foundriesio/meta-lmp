# Needs to be included first as optee-os-fio.inc replaces configure/compile/install
require ${@bb.utils.contains('MACHINE_FEATURES', 'se05x', 'optee-os-fio-se05x.inc', '', d)}

require optee-os-fio.inc

PV = "3.15.0+git"
SRCREV = "9623ef887aaf162d05b40e354c34e76c5bbf1c5b"
SRCBRANCH = "3.15+fio"

ALLOW_EMPTY:${PN}-ta-pkcs11 = "1"
