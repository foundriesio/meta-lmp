require optee-test-fio.inc

SRCREV = "526d5bac1b65f907f67c05cd07beca72fbab88dd"

# Due OpenSSL 3.0 deprecated warnings
CFLAGS += "-Wno-error=deprecated-declarations"
