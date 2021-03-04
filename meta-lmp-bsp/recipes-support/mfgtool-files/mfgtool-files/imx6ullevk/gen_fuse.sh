#!/bin/sh
#
# Copyright (C) 2021 Foundries.IO
#
# SPDX-License-Identifier: MIT
#

DIR=$(dirname $0)
FILE=${FUSE_DEST:-${DIR}/fuse.uuu}
FUSEBIN=${FUSEBIN:-cst-3.3.1/crts/SRK_1_2_3_4_fuse.bin}

usage() {
    echo -e "Usage: $0 [-s source_file] [-d destination_file]
where:
   source_file defaults to cst-3.3.1/crts/SRK_1_2_3_4_fuse.bin
   destination file defaults to ${DIR}/fuse.uuu
" 1>&2
    exit 1
}

while getopts ":s:d:" arg; do
    case "${arg}" in
        s)
            FUSEBIN="${OPTARG}"
            ;;
        d)
            FILE="${OPTARG}"
            ;;
        s)
            usage
            ;;
    esac
done

DIR=$(dirname ${FILE})
shift $((OPTIND-1))

if [ $# -gt 0 ]
then
    echo "Too many arguments" 1>&1
    usage
fi

if [ ! -f "${FUSEBIN}" ]
then
    echo "source file '${FUSEBIN}' not found" 1>&2
    usage
fi

mkdir -p "${DIR}"

if [ ! -d "${DIR}" ]
then
    echo "destination directory '${DIR}' missing"
fi

(cat << EOF
uuu_version 1.2.39

SDP: boot -f SPL-mfgtool.signed -dcdaddr 0x0907000 -cleardcd

SDPV: delay 1000
SDPV: write -f u-boot-mfgtool.itb
SDPV: jump

EOF

bank=3
idx=0
for val in $(hexdump -e '/4 "0x"' -e '/4 "%X""\n"' ${FUSEBIN})
do
	echo "FB: ucmd fuse prog -y ${bank} ${idx} ${val}"
	idx=$((idx+1))
done
echo "FB: acmd reset"
echo
echo "FB: DONE") > ${FILE}
