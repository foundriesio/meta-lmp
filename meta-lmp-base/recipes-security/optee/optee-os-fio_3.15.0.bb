# Needs to be included first as optee-os-fio.inc replaces configure/compile/install
require ${@bb.utils.contains('MACHINE_FEATURES', 'se05x', 'optee-os-fio-se05x.inc', '', d)}

require optee-os-fio.inc

PV = "3.15.0+git"
SRCREV = "444d46a4d4caeaae559df48a86301e5725e66c42"
SRCBRANCH = "3.15+fio"

ALLOW_EMPTY:${PN}-ta-pkcs11 = "1"
