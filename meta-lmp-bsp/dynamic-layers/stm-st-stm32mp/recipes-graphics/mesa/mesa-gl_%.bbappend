PACKAGECONFIG:append:stm32mpcommon = " ${@bb.utils.contains('MACHINE_FEATURES', 'gpu', 'gallium', '', d)}"
