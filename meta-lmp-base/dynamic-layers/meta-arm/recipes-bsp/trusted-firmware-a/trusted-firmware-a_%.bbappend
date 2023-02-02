# Depend on virtual/optee-os based on machine-features
DEPENDS:remove = "optee-os"
DEPENDS += " ${@bb.utils.contains("MACHINE_FEATURES", "optee", "virtual/optee-os", "", d)}"

# Qemu (EBBR)
TFA_UBOOT:qemuarm64-secureboot-ebbr = "0"
TFA_UEFI:qemuarm64-secureboot-ebbr = "1"
