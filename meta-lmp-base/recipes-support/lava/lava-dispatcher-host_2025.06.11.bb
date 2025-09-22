SUMMARY = "LAVA dispatcher host tools"

require lava.inc

SRC_URI[sha256sum] = "ddb86e60174e3acb86a612aea523c0a0d40f317badf90ef1e4c8bdf9e944489b"

inherit systemd

SYSTEMD_SERVICE:${PN} = "lava-dispatcher-host.service lava-docker-worker.service"
#SYSTEMD_AUTO_ENABLE = "disable"

FILES:${PN} += "${localstatedir}/volatile"
INSANE_SKIP:${PN} += "empty-dirs"

RDEPENDS:${PN} += " \
    lava-common \
    python3-jinja2 \
    python3-pyudev \
    python3-requests \
"
