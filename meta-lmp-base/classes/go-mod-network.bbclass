# Foundries LmP Go Modules with network support
#
# In LmP layer we need network support to build Go Modules
#
# Copyright 2022 (C) Foundries.IO LTD
#
# SPDX-License-Identifier: MIT
#

inherit go-mod

python bb_utils_export_proxies() {
    bb.utils.export_proxies(d)
}

do_compile[prefuncs] += "bb_utils_export_proxies"
do_compile[network] = "1"
