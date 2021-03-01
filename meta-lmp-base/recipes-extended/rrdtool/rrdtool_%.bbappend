# Disable rrd_graph as it requires cairo and pango
DEPENDS_remove = "cairo pango"
EXTRA_OECONF += " \
    --disable-rrd_graph \
"

# Fix perl install rdepends and path
RDEPENDS_${PN}_remove = "perl"
FILES_${PN}-perl = "${libdir}/perl5/vendor_perl"
