# Make nvidia runtime available by default on tegra
DOCKER_DAEMON_JSON_CUSTOM:tegra = '"runtimes": { "nvidia": { "path": "nvidia-container-runtime", "runtimeArgs": [] } },'
RDEPENDS:${PN}:append:tegra = " nvidia-container-toolkit"
