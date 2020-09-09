# Depend on virtual/optee-os based on machine-features
DEPENDS_remove = "optee-os"
DEPENDS += " ${@bb.utils.contains("MACHINE_FEATURES", "optee", "virtual/optee-os", "", d)}"
