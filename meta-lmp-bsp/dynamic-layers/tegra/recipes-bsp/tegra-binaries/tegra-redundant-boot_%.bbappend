SYSTEMD_AUTO_ENABLE:${PN} = "${@bb.utils.contains("MACHINE_FEATURES", "fioefi", "disable", "enable", d)}"
