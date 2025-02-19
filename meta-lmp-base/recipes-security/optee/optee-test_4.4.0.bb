require optee-test-fio.inc

SRCREV = "695231ef8987866663a9ed5afd8f77d1bae3dc08"

# Due OpenSSL 3.0 deprecated warnings
CFLAGS += "-Wno-error=deprecated-declarations"
