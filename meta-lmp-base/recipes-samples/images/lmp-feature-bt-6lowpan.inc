# NOTE: should use lmp-feature-bluetooth.inc

# user can customize this option in machine conf
# BT_6LOWPAN_NETWORK ?= "fe80:0:0:0:d4e7::1/80"

CORE_IMAGE_BASE_INSTALL += " \
	bt-6lowpan-setup \
"
