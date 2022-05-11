FILESEXTRAPATHS:prepend := "${THISDIR}/${BPN}:"

# Add in LMP credential helper
SRC_URI:append = " file://0001-config-Include-usr-lib-docker-in-search-path.patch"
