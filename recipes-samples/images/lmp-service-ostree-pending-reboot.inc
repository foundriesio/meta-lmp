# user can customize this to change how often reboot is checked (in minutes)
# OSTREE_PENDING_REBOOT_CHECK_MINUTES ?= "5"

# packages
CORE_IMAGE_BASE_INSTALL += " \
	ostree-pending-reboot \
"
