# imx weston-init tries to uncomment [shell] for some machines
# this is already uncommented for lmp-wayland weston.ini so remove here
INI_UNCOMMENT_ASSIGNMENTS:remove:imx-nxp-bsp = "\\[shell\\]"
