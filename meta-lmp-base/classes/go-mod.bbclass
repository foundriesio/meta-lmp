# Handle Go Modules support
#
# When using Go Modules, the the current working directory MUST be at or below
# the location of the 'go.mod' file when the go tool is used, and there is no
# way to tell it to look elsewhere.  It will automatically look upwards for the
# file, but not downwards.
#
# To support this use case, we provide the `GO_WORKDIR` variable, which defaults
# to `GO_IMPORT` but allows for easy override.
#
# Copyright 2020 (C) O.S. Systems Software LTDA.

# The '-modcacherw' option ensures we have write access to the cached objects so
# we avoid errors during clean task as well as when removing the TMPDIR.
GOBUILDFLAGS_append = " -modcacherw"

inherit go

# Export proxies for mod download (done as part of go build/install)
python do_compile() {
    bb.utils.export_proxies(d)
    bb.build.exec_func('go_do_compile', d)
}
GO_WORKDIR ?= "${GO_IMPORT}"
go_do_compile[dirs] += "${B}/src/${GO_WORKDIR}"
