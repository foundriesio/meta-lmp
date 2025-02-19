# Needed an explicit PV setting due the require/include chain
PV = "4.4.0-imx"

require recipes-security/optee/optee-os-tadevkit_4.4.0.bb

DEFAULT_PREFERENCE = "-1"
