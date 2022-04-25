# Needs to be included first as optee-os-fio.inc replaces configure/compile/install
require ${@bb.utils.contains('MACHINE_FEATURES', 'se05x', 'optee-os-fio-se05x.inc', '', d)}

require optee-os-fio.inc

PV = "3.15.0+git"
SRCREV = "b8fd9c6c83f028258afaf2ccbb969a99c7d5fce4"
SRCBRANCH = "3.15+fio"

ALLOW_EMPTY:${PN}-ta-pkcs11 = "1"
