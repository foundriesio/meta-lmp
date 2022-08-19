require optee-test-fio.inc

SRCREV = "da5282a011b40621a2cf7a296c11a35c833ed91b"

# Due OpenSSL 3.0 deprecated warnings
CFLAGS += "-Wno-error=deprecated-declarations"
