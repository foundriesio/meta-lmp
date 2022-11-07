OS_RELEASE_FIELDS += "HOME_URL SUPPORT_URL DEFAULT_HOSTNAME LMP_MACHINE LMP_FACTORY LMP_FACTORY_TAG IMAGE_ID IMAGE_VERSION"
OS_RELEASE_UNQUOTED_FIELDS += "IMAGE_ID IMAGE_VERSION"

# Default values when not built via our factory CI
LMP_DEVICE_FACTORY ?= "lmp"
LMP_DEVICE_REGISTER_TAG ?= "master"
LMP_FACTORY_IMAGE ??= "lmp-factory-image"
H_BUILD ??= "local-image"

DEFAULT_HOSTNAME = "${MACHINE}"
HOME_URL = "https://foundries.io/"
SUPPORT_URL = "https://support.foundries.io/"
LMP_MACHINE = "${MACHINE}"
LMP_FACTORY = "${LMP_DEVICE_FACTORY}"
LMP_FACTORY_TAG = "${LMP_DEVICE_REGISTER_TAG}"
IMAGE_ID = "${LMP_FACTORY_IMAGE}"
IMAGE_VERSION = "${H_BUILD}"

PACKAGE_ARCH = "${MACHINE_ARCH}"

inherit deploy

do_deploy () {
    install -d ${DEPLOYDIR}
    install -m 0644 os-release ${DEPLOYDIR}
}

addtask do_deploy after do_install
