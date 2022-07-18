DEPENDS += "virtual/kernel"

INHIBIT_PACKAGE_DEBUG_SPLIT = "${@bb.utils.contains('DISTRO_FEATURES', 'modsign', '1', '', d)}"
