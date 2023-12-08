# Needed an explicit PV setting due the require/include chain
PV = "3.21.0-imx"

require recipes-security/optee/optee-os-tadevkit_3.21.0.bb

DEFAULT_PREFERENCE = "-1"
