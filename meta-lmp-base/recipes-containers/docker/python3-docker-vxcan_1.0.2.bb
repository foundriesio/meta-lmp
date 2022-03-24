SUMMARY = "Docker NetworkDriver plugin providing CAN connectivity"
HOMEPAGE = "https://github.com/jhaws1982/docker-vxcan.git"
LICENSE = "MIT"
LIC_FILES_CHKSUM = "file://${COMMON_LICENSE_DIR}/MIT;md5=0835ade698e0bcf8506ecda2f7b4f302"

inherit setuptools3 systemd

SRC_URI = "git://github.com/jhaws1982/docker-vxcan.git;branch=master;protocol=https \
           file://docker-vxcan.service \
"
SRCREV = "813370f5bf1ec3a5254a6541c25ea9db33fde8de"

S = "${WORKDIR}/git"
B = "${S}"

RDEPENDS:${PN} += "\
    can-utils \
    ${PYTHON_PN}-gunicorn \
    ${PYTHON_PN}-flask \
    ${PYTHON_PN}-pyroute2 \
    ${PYTHON_PN}-sqlite3 \
    ${PYTHON_PN}-docker \
    ${PYTHON_PN}-docker-pycreds \
"

do_install:append() {
    install -d ${D}${systemd_system_unitdir}
    install -m 0644 ${WORKDIR}/docker-vxcan.service ${D}${systemd_system_unitdir}/
}

SYSTEMD_AUTO_ENABLE:${PN} = "enable"
SYSTEMD_SERVICE:${PN} = "docker-vxcan.service"
FILES:${PN} += "${systemd_system_unitdir}"
