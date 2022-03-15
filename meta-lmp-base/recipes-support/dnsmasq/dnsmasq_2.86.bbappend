# Upstream is dual licensed on GPLv2 | GPLv3, so force GPLv2 in order
# to allow safe checks via image-license-checker
LICENSE = "GPLv2"

# Disabled by default to avoid conflicts with NM/systemd
SYSTEMD_AUTO_ENABLE = "disable"
