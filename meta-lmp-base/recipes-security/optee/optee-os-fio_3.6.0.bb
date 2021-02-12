require optee-os-fio.inc

DEPENDS = "python3-pycrypto-native python3-pyelftools-native"

SRC_URI += " \
	file://0001-arm64-Disable-outline-atomics-when-compiling.patch \
"

PV = "3.6.0+git"
SRCREV = "b899c86098b4b7318d7cdebea5cb19f6e095b41d"
SRCBRANCH = "3.6.0+fio"

ALLOW_EMPTY_${PN}-ta-pkcs11 = "1"
