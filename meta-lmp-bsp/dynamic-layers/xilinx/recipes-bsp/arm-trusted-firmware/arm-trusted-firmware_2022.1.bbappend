FILESEXTRAPATHS:prepend := "${THISDIR}/${PN}:"

SRC_URI:append:versal = " \
	file://plat-versal-support-raw-bin.patch \
"

# Align provides with meta-arm
PROVIDES += "virtual/trusted-firmware-a"

# Enable opteed as the main SPD provider (required for optee)
EXTRA_OEMAKE:append:zynqmp = " SPD=opteed"
EXTRA_OEMAKE:append:versal = " SPD=opteed"
ATF_CONSOLE:kv260 = "cadence1"
