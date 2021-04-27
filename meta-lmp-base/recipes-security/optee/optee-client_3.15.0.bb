require optee-client.inc

SRCREV = "182874320395787a389e5b0f7df02b32f3c0a1b0"

SRC_URI += " \
	file://0001-FIO-extras-pkcs11-change-UUID-to-avoid-conflict-with.patch \
"

DEFAULT_PREFERENCE = "-1"
