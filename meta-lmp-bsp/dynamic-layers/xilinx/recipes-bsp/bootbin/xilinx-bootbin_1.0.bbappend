include machine-xilinx-${SOC_FAMILY}-optee.inc

do_configure[vardeps] += "BIF_OPTEE_ATTR"

do_compile[depends] += "${@bb.utils.contains('MACHINE_FEATURES', 'optee', 'virtual/optee-os:do_deploy', '', d)}"
