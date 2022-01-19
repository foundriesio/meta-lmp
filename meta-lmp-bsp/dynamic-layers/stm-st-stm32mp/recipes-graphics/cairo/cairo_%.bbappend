PACKAGECONFIG:append:stm32mpcommon = " ${@bb.utils.contains('MACHINE_FEATURES', 'gpu', 'egl glesv2', '', d)}"
PACKAGECONFIG:remove:stm32mpcommon = "${@bb.utils.contains('MACHINE_FEATURES', 'gpu', 'opengl', '', d)}"
