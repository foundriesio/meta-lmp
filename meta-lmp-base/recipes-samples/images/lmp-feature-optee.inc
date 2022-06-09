# OP-TEE/SKS packages
CORE_IMAGE_BASE_INSTALL += " \
    optee-client \
    ${@bb.utils.contains('PREFERRED_PROVIDER_virtual/optee-os', 'optee-os-fio', 'optee-os-fio-ta', '', d)} \
    optee-test \
"
