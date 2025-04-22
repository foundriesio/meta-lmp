# Disable rrd_graph as it requires cairo and pango
PACKAGECONFIG:remove = "graph"

# Fix perl install rdepends and path
RDEPENDS:${PN}:remove = "perl"
FILES:${PN}-perl = "${libdir}/perl5/vendor_perl"
