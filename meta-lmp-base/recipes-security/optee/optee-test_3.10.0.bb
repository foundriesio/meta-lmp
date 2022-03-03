require optee-test.inc

SRCREV = "30efcbeaf8864d0f2a5c4be593a5411001fab31b"

SRC_URI += " \
    file://0001-os_test-disable-c-tests.patch \
    file://0001-regression-remove-7000-series.patch \
    file://0001-xtest-remove-compilation-of-regression_7000.c.patch \
"
