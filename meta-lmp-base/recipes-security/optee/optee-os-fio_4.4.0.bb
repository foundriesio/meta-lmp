require optee-os-fio.inc

SRCREV = "acfcdb74ce84219ff0a2faf7cd9f5a6fd1c0ac6c"
SRCBRANCH = "4.4.0+fio"

# ERROR: optee-os-fio-4.4.0-r0 do_package_qa: QA Issue: File /usr/lib/firmware/tee.elf in package optee-os-fio contains reference to TMPDIR [buildpaths]
INSANE_SKIP:${PN} += "buildpaths"
