require go-riscv-1.15.inc

## Replace python generic block as we now have pie support for risc-v
# mips doesn't support -buildmode=pie, so skip the QA checking for mips and its
# variants.
python() {
    if 'mips' in d.getVar('TARGET_ARCH',True):
        d.appendVar('INSANE_SKIP_%s' % d.getVar('PN',True), " textrel")
}
