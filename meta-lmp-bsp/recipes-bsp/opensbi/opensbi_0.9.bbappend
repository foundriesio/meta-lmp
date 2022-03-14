# freedom-u540 has a default setting for RISCV_SBI_PAYLOAD
# This default means we can't let it equal None for the python check.
# Instead, we're forced to cleanup the broken setting here.
EXTRA_OEMAKE:remove:freedom-u540 = " ${@riscv_get_extra_oemake_image(d)}"

# Export fw_payloads to sysroot
SYSROOT_DIRS += "/share"
