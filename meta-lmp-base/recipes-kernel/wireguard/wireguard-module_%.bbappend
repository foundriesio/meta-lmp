# Only set default rprovides if kernel is different than linux-lmp, assuming
# it is older than 5.6 (version in which the module is provided by the kernel)
python __anonymous() {
    pn = d.getVar("PN")
    pprovider = d.getVar("PREFERRED_PROVIDER_virtual/kernel")
    if pprovider != "linux-lmp" and pprovider != "linux-lmp-lts" and pprovider != "linux-lmp-rt" \
            and pprovider != "linux-lmp-dev" and d.getVar("KERNEL_BUILTIN_WIREGUARD") != "1":
        d.appendVar("RPROVIDES_" + pn, "kernel-module-wireguard")
}
