SUMMARY = "Minimal image that includes OTA+ support"

require lmp-image-common.inc

IMAGE_FEATURES += "ssh-server-dropbear"

# Base packages
CORE_IMAGE_BASE_INSTALL += " \
    96boards-tools \
    aktualizr-host-tools \
    networkmanager \
    sudo \
"

# OTA+ extras (OSF device provisioning)
CORE_IMAGE_BASE_INSTALL += " \
    lmp-device-register \
    python3-requests \
"

# Extras (for development)
CORE_IMAGE_BASE_INSTALL += " \
    bash \
    git \
"
