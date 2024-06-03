#!/bin/sh

set -e

SCRIPT=$(readlink -f "$0")
SCRIPT_DIR=$(dirname "$SCRIPT")
EFI_DIR=/boot/efi/EFI/UpdateCapsule
CAP_FILE=tegra-bl.cap

rc=0
cp $SCRIPT_DIR/$CAP_FILE $EFI_DIR || rc=1
oe4t-set-uefi-OSIndications || rc=1

exit $rc