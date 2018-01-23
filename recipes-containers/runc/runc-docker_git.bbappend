FILESEXTRAPATHS_prepend := "${THISDIR}/${PN}:"

# Additional bugfixes already available upstream
SRC_URI += " \
    file://0001-libcontainer-console_linux.go-Make-SaneTerminal-publ.patch \
"
