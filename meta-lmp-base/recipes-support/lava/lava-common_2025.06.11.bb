SUMMARY = "Linaro Automated Validation Architecture common"

require lava.inc

SRC_URI[sha256sum] = "28d35e177ab51d386663d5211420ac84c81b4c906e1ab9d7700f6ef323717085"

RDEPENDS:${PN} += " \
    python3 \
    python3-sentry-sdk \
    python3-voluptuous \
    python3-pyyaml \
"
