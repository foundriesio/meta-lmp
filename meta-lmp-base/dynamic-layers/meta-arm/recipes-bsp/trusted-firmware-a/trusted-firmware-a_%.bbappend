# Depend on virtual/optee-os based on machine-features
DEPENDS:remove = "optee-os"
DEPENDS += " ${@bb.utils.contains("MACHINE_FEATURES", "optee", "virtual/optee-os", "", d)}"
