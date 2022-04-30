# Do not assume one by default as we also support different providers
require ${@bb.utils.contains('PREFERRED_PROVIDER_virtual/optee-os', 'optee-os-fio', 'optee-os-fio-bsp.inc', '', d)}
require ${@bb.utils.contains('PREFERRED_PROVIDER_virtual/optee-os', 'optee-os-fio-mfgtool', 'optee-os-fio-bsp-mfgtool.inc', '', d)}
