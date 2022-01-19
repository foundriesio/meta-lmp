# There is no runtime dependency on readline if not built with support for it
RDEPENDS:${PN}:remove = "readline"
