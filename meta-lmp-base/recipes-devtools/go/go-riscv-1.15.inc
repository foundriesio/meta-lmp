FILESEXTRAPATHS_prepend := "${THISDIR}/files:"

export CGO_ENABLED_riscv64 = "1"

# From https://github.com/4a6f656c/go/commits/riscv64-cgo-1.15
SRC_URI_append_riscv64 = " \
	file://0001-cmd-link-add-support-for-external-linking-on-linux-r.patch \
	file://0002-cmd-link-cmd-internal-obj-riscv-add-TLS-support-for-.patch \
	file://0003-cmd-compile-cmd-internal-obj-riscv-move-g-register-o.patch \
	file://0004-cmd-dist-cmd-go-runtime-add-support-for-cgo-on-linux.patch \
	file://0005-cmd-compile-cmd-internal-sys-enable-non-exe-build-mo.patch \
"
