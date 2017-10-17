FILESEXTRAPATHS_prepend := "${THISDIR}/${PN}:"

# Additional bugfixes already available upstream
SRC_URI += " \
    file://0001-fix-TestLogsFollowGoroutinesWithStdout-in-arm64.patch \
"
