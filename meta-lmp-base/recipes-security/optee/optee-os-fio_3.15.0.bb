# Needs to be included first as optee-os-fio.inc replaces configure/compile/install
require ${@bb.utils.contains('MACHINE_FEATURES', 'se05x', 'optee-os-fio-se05x.inc', '', d)}

require optee-os-fio.inc

PV = "3.15.0+git"
SRCREV = "bf6c3463abd7dfdff0e3f726b25bca34a9064a45"
SRCBRANCH = "3.15+fio"

ALLOW_EMPTY_${PN}-ta-pkcs11 = "1"
