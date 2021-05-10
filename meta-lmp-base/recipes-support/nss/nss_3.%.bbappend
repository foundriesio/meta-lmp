# Neoverse-N1 is ARMv8.2-a based but libatomic explicitly asks for
# -march=armv8.1-a which causes -march conflicts in gcc
TUNE_CCARGS_remove = "-mcpu=neoverse-n1+crc+crypto"
