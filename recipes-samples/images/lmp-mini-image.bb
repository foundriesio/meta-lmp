SUMMARY = "Minimal image that includes OTA+ support"

require lmp-image-common.inc

require lmp-feature-ota.inc
require lmp-feature-sbin-path-helper.inc
require lmp-feature-sysctl-hang-crash-helper.inc

require lmp-service-ostree-pending-reboot.inc

IMAGE_FEATURES += "ssh-server-dropbear"

# Enough free space for a full image update
IMAGE_OVERHEAD_FACTOR = "2.3"

# Extras (for development)
CORE_IMAGE_BASE_INSTALL += " \
    bash \
"
