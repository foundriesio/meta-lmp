# Needs to be included first as optee-os-fio.inc replaces configure/compile/install
require ${@bb.utils.contains('MACHINE_FEATURES', 'se05x', 'optee-os-fio-se05x.inc', '', d)}

require optee-os-fio.inc

PV = "3.15.0+git"
SRCREV = "f0446cdb3af8bc796228cb3dd6959a0e77cd7cad"
SRCBRANCH = "3.15+fio"

ALLOW_EMPTY_${PN}-ta-pkcs11 = "1"
