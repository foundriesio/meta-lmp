SUMMARY = "Minimal image that includes OTA+ support"

require lmp-image-common.inc

IMAGE_FEATURES += "ssh-server-dropbear"

# Extras (for development)
CORE_IMAGE_BASE_INSTALL += " \
    bash \
"
