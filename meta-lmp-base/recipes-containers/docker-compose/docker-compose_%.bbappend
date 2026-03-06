FILESEXTRAPATHS:prepend := "${THISDIR}/${PN}:"

SRC_URI:append:lmp = " \
	file://cli-config-support-default-system-config.patch;patchdir=../vcs_cache/5a943d69020f5a43c45569ee422d339cf415d78724c142bb4bcc7c026f13ba05 \
"
