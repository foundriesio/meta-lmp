# Align provides with meta-arm
PROVIDES += "virtual/trusted-firmware-a"

# Enable opteed as the main SPD provider (required for optee)
EXTRA_OEMAKE:append:uz = " SPD=opteed"
ATF_CONSOLE:kv260 = "cadence1"
