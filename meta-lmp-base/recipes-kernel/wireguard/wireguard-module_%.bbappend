# Only set default rprovides if kernel is different than linux-lmp, assuming
# it is older than 5.6 (version in which the module is provided by the kernel)
python __anonymous() {
    if d.getVar("KERNEL_BUILTIN_WIREGUARD") == "0":
        pn = d.getVar("PN")
        d.appendVar("RPROVIDES:" + pn, "kernel-module-wireguard")
}
