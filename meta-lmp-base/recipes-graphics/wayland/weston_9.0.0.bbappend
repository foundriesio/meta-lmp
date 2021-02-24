# Weston with Xwayland support (requires X11 and Wayland)
PACKAGECONFIG[xwayland] = "-Dxwayland=true,-Dxwayland=false,libxcursor"

PACKAGECONFIG_remove_apalis-imx6 = "kms"

# Clients support
SIMPLE_CLIENTS = "all"
SIMPLE_CLIENTS_apalis-imx6 = "damage,im,egl,shm,touch,dmabuf-v4l"
PACKAGECONFIG[clients] = "-Dsimple-clients=${SIMPLE_CLIENTS} -Ddemo-clients=true,-Dsimple-clients= -Ddemo-clients=false"
