PACKAGECONFIG_append_stm32mpcommon = " ${@bb.utils.contains('MACHINE_FEATURES', 'gpu', 'egl glesv2', '', d)}"
PACKAGECONFIG_remove_stm32mpcommon = "${@bb.utils.contains('MACHINE_FEATURES', 'gpu', 'opengl', '', d)}"
