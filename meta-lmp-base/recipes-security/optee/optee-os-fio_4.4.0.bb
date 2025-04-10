require optee-os-fio.inc

SRCREV = "88da15801ac113be49ec6ad2e28f4019846402d7"
SRCBRANCH = "4.4.0+fio"

# ERROR: optee-os-fio-4.4.0-r0 do_package_qa: QA Issue: File /usr/lib/firmware/tee.elf in package optee-os-fio contains reference to TMPDIR [buildpaths]
INSANE_SKIP:${PN} += "buildpaths"
