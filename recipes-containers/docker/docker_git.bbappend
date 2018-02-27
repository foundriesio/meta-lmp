FILESEXTRAPATHS_prepend := "${THISDIR}/${PN}:"

# Additional bugfixes already available upstream
SRC_URI += " \
    file://0001-fix-TestLogsFollowGoroutinesWithStdout-in-arm64.patch \
"

do_compile_append() {
	# Rebuild docker-proxy with the right linkmode to avoid using the host linker path
	go build -ldflags="-linkmode=external" -o ${S}/src/import/docker-proxy github.com/docker/libnetwork/cmd/proxy
}
