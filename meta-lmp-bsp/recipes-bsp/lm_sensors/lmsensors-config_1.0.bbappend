FILESEXTRAPATHS:prepend := "${THISDIR}/${PN}:"

# /usr/bin/rrdcgi is provided by rrdtool
INSANE_SKIP:${PN}-cgi += "file-rdeps"
