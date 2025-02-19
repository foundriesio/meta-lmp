require optee-test-fio.inc

SRCREV = "695231ef8987866663a9ed5afd8f77d1bae3dc08"
LIC_FILES_CHKSUM = "file://LICENSE.md;md5=a8fa504109e4cd7ea575bc49ea4be560"

# Due OpenSSL 3.0 deprecated warnings
CFLAGS += "-Wno-error=deprecated-declarations"
