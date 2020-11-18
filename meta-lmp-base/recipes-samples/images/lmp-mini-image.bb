SUMMARY = "Minimal image that includes OTA+ support"

require lmp-image-common.inc

require ${@bb.utils.contains('DISTRO_FEATURES', 'sota', 'lmp-feature-factory.inc', '', d)}
require lmp-feature-ota-utils.inc
require lmp-feature-wireguard.inc
require lmp-feature-sysctl-hang-crash-helper.inc

require ${@bb.utils.contains('SOTA_CLIENT', 'aktualizr', 'lmp-service-ostree-pending-reboot.inc', '', d)}

IMAGE_FEATURES += "ssh-server-dropbear"
