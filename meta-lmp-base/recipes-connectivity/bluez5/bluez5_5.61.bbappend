# This enables using BSD library libedit for client/mesh features

FILESEXTRAPATHS:prepend := "${THISDIR}/files:"

PACKAGECONFIG:append = " client "

PACKAGECONFIG[readline] = "--with-readline=readline,,readline,,,libedit"
PACKAGECONFIG[libedit] = "--with-readline=libedit,,libedit,,,readline"
PACKAGECONFIG[client] = "--enable-client,--disable-client"
PACKAGECONFIG[mesh] = "--enable-mesh,--disable-mesh"

SRC_URI += " \
    file://0001-build-add-initial-support-for-building.patch \
    file://0002-build-support-choosing-libedit-instead-readline.patch \
"
