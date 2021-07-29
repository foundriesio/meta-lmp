PACKAGECONFIG_append_stm32mpcommon = " ${@bb.utils.contains('MACHINE_FEATURES', 'gpu', 'gallium', '', d)}"
