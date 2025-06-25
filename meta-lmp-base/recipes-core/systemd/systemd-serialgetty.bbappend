# FIXME:
#   This should be fixed within the oe-core archiver bbclass instead of in the recipe.
#   but I prefer we leave it as is, and when we switch everything to spdx and drop
#   the archiver bbclass, we can discard it as well.
#
# fix archiver
# tar: /srv/oe/build/tmp-lmp/work/intel_corei7_64-lmp-linux/systemd-serialgetty/1.0/archiver-work//sources/systemd-serialgetty-1.0: Cannot open: No such file or directory
S = "${UNPACKDIR}"
