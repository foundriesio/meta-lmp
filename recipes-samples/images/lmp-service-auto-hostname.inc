# user can customize these options in machine conf
# LMP_HOSTNAME_MACHINE ?= "${MACHINE}"
# LMP_HOSTNAME_MODE ?= "serial"
# LMP_HOSTNAME_NETDEVICE ?= ""

# Auto hostname service package
CORE_IMAGE_BASE_INSTALL += " \
	lmp-auto-hostname \
"
