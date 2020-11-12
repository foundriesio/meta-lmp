# Only set default rprovides if kernel is different than linux-lmp, assuming
# it is older than 5.6 (version in which the module is provided by the kernel)
python __anonymous() {
    pn = d.getVar("PN")
    if d.getVar("PREFERRED_PROVIDER_virtual/kernel") != "linux-lmp":
        d.appendVar("RPROVIDES_" + pn, "kernel-module-wireguard")
}
