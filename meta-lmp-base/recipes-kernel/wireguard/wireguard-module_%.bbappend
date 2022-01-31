# Have a way to skip default rprovides in case a newer (>= 5.6) kernel is used
python __anonymous() {
    pn = d.getVar("PN")
    if d.getVar("KERNEL_BUILTIN_WIREGUARD") != "1":
        d.appendVar("RPROVIDES_" + pn, "kernel-module-wireguard")
}
