require optee-test-fio.inc

SRCREV = "9c872638bc38324d8c65b9296ebec3d124e19466"

# Due OpenSSL 3.0 deprecated warnings
CFLAGS += "-Wno-error=deprecated-declarations"
