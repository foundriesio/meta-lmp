# Branch was forced pushed, drop it so bitbake can look for the tag
BRANCH = ""

# Align provides with meta-arm
PROVIDES += "virtual/trusted-firmware-a"

# Enable opteed as the main SPD provider (required for optee)
EXTRA_OEMAKE:append:zynqmp = " SPD=opteed"
