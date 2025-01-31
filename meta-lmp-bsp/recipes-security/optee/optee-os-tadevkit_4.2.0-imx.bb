# Needed an explicit PV setting due the require/include chain
PV = "4.2.0-imx"

require recipes-security/optee/optee-os-tadevkit_4.2.0.bb

DEFAULT_PREFERENCE = "-1"
