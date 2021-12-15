# Needs to be included first as optee-os-fio.inc replaces configure/compile/install
require ${@bb.utils.contains('MACHINE_FEATURES', 'se05x', 'optee-os-fio-se05x.inc', '', d)}

require optee-os-fio.inc

PV = "3.15.0+git"
SRCREV = "d2061fc2c6d4dfc1fc10fe4b31f32c655d93f177"
SRCBRANCH = "3.15+fio"

ALLOW_EMPTY_${PN}-ta-pkcs11 = "1"
