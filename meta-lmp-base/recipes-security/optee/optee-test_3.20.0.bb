require optee-test-fio.inc

SRCREV = "5db8ab4c733d5b2f4afac3e9aef0a26634c4b444"

# Due OpenSSL 3.0 deprecated warnings
CFLAGS += "-Wno-error=deprecated-declarations"
