require optee-os-fio.inc

DEPENDS = "python3-pycrypto-native python3-pyelftools-native"

PV = "3.6.0+git"
SRCREV = "c67d7defe31a71d96dfd082e7987ecdbf7d3638d"
SRCBRANCH = "3.6.0+fio"

ALLOW_EMPTY_${PN}-ta-pkcs11 = "1"
