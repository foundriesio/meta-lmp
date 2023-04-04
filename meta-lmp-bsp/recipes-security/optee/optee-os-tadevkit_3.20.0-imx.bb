# Needed an explicit PV setting due the require/include chain
PV = "3.20.0-imx"

require recipes-security/optee/optee-os-tadevkit_3.20.0.bb

DEFAULT_PREFERENCE = "-1"
