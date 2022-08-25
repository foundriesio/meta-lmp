# Foundries LmP staging area
#
# This class will implement some pending patches that we have
# and some workarounds needed in LmP.
#
# Copyright 2022 (C) Foundries.IO LTD

INHERIT_KERNEL_MODSIGN = ""

python __anonymous() {
    if bb.data.inherits_class('module', d):
        d.appendVar('DEPENDS', ' virtual/kernel')
        if 'modsign' in d.getVar('DISTRO_FEATURES'):
            d.setVar('INHERIT_KERNEL_MODSIGN', 'kernel-modsign')
}

inherit ${INHERIT_KERNEL_MODSIGN}
