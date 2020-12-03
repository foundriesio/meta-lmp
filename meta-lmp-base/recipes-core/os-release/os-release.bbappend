OS_RELEASE_FIELDS += "HOME_URL SUPPORT_URL LMP_MACHINE LMP_FACTORY LMP_FACTORY_TAG"

# Default values when not built via our factory CI
LMP_DEVICE_FACTORY ?= "lmp"
LMP_DEVICE_REGISTER_TAG ?= "master"

HOME_URL = "https://foundries.io/"
SUPPORT_URL = "https://support.foundries.io/"
LMP_MACHINE = "${MACHINE}"
LMP_FACTORY = "${LMP_DEVICE_FACTORY}"
LMP_FACTORY_TAG = "${LMP_DEVICE_REGISTER_TAG}"
