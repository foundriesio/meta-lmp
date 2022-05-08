# Allow EFUSE access, used by OP-TEE
YAML_COMPILER_FLAGS:append:zynqmp = " -DENABLE_EFUSE_ACCESS"
