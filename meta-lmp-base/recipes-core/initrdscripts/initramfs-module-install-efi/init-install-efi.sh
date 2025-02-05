#!/bin/sh -e
#
# Copyright (c) 2012, Intel Corporation.
# Copyright (c) 2020, Foundries.IO Ltd
# All rights reserved.
#
# install.sh [device_name] [rootfs_name]
#

PATH=/sbin:/bin:/usr/sbin:/usr/bin

check_secure_boot() {
    if [ ! -d /sys/firmware/efi/efivars ]; then
        echo "EFI vars sysfs mount point not found"
	exit 1
    fi

    efi_secure=`efivar --name=8be4df61-93ca-11d2-aa0d-00e098032b8c-SecureBoot --print-decimal`
    efi_mode=`efivar --name=8be4df61-93ca-11d2-aa0d-00e098032b8c-SetupMode --print-decimal`
    if [ "${efi_secure}" -ne 1 ] || [ "${efi_mode}" -ne 0 ]; then
	echo "UEFI SecureBoot not enabled, installation aborted"
	exit 1
    fi
}

# Recommended ESP partition size is 512m
boot_size=512

# Get a list of hard drives
hdnamelist=""
live_dev_name=`cat /proc/mounts | grep ${1%/} | awk '{print $1}'`
live_dev_name=${live_dev_name#\/dev/}
# Only strip the digit identifier if the device is not an mmc
case $live_dev_name in
    mmcblk*)
    ;;
    nvme*)
    ;;
    *)
        live_dev_name=${live_dev_name%%[0-9]*}
    ;;
esac

echo "Searching for hard drives ..."

# Sleep for at least 5 seconds for USB device enumeration to happen
sleep 5

# Some eMMC devices have special sub devices such as mmcblk0boot0 etc
# we're currently only interested in the root device so pick them wisely
devices=`ls /sys/block/ | grep -v mmcblk` || true
mmc_devices=`ls /sys/block/ | grep "mmcblk[0-9]\{1,\}$"` || true
devices="$devices $mmc_devices"

for device in $devices; do
    case $device in
        mtdblock*)
            # skip mtd device
            ;;
        loop*)
            # skip loop device
            ;;
        sr*)
            # skip CDROM device
            ;;
        ram*)
            # skip ram device
            ;;
        *)
            # skip the device LiveOS is on
            # Add valid hard drive name to the list
            case $device in
                $live_dev_name*)
                # skip the device we are running from
                ;;
                *)
                    hdnamelist="$hdnamelist $device"
                ;;
            esac
            ;;
    esac
done

if [ -z "${hdnamelist}" ]; then
    echo "You need another device (besides the live device /dev/${live_dev_name}) to install the image. Installation aborted."
    exit 1
fi

TARGET_DEVICE_NAME=""
for hdname in $hdnamelist; do
    # Display found hard drives and their basic info
    echo "-------------------------------"
    echo /dev/$hdname
    if [ -r /sys/block/$hdname/device/vendor ]; then
        echo -n "VENDOR="
        cat /sys/block/$hdname/device/vendor
    fi
    if [ -r /sys/block/$hdname/device/model ]; then
        echo -n "MODEL="
        cat /sys/block/$hdname/device/model
    fi
    if [ -r /sys/block/$hdname/device/uevent ]; then
        echo -n "UEVENT="
        cat /sys/block/$hdname/device/uevent
    fi
    echo
done

# Get user choice
while true; do
    echo "Please select an install target or press n to exit ($hdnamelist ): "
    read answer
    if [ "$answer" = "n" ]; then
        echo "Installation manually aborted."
        exit 1
    fi
    for hdname in $hdnamelist; do
        if [ "$answer" = "$hdname" ]; then
            TARGET_DEVICE_NAME=$answer
            break
        fi
    done
    if [ -n "$TARGET_DEVICE_NAME" ]; then
        break
    fi
done

if [ -n "$TARGET_DEVICE_NAME" ]; then
    echo "Installing image on /dev/$TARGET_DEVICE_NAME ..."
else
    echo "No hard drive selected. Installation aborted."
    exit 1
fi

device=/dev/$TARGET_DEVICE_NAME

#
# The udev automounter can cause pain here, kill it
#
rm -f /etc/udev/rules.d/automount.rules
rm -f /etc/udev/scripts/mount*

#
# Unmount anything the automounter had mounted
#
umount ${device}* 2> /dev/null || /bin/true

mkdir -p /tmp

# Create /etc/mtab if not present
if [ ! -e /etc/mtab ] && [ -e /proc/mounts ]; then
    ln -sf /proc/mounts /etc/mtab
fi

disk_info=$(gdisk -l ${device} 2>&1 || true)
if echo ${disk_info} | grep -q "GPT: not present"; then
	echo "No valid GPT partition table found, creating one"
	echo -e "2\nw\nY\n" | gdisk ${device} > /dev/null
fi

# MMC devices are special in a couple of ways
# 1) they use a partition prefix character 'p'
# 2) they are detected asynchronously (need rootwait)
rootwait=""
part_prefix=""
if [ ! "${device#/dev/mmcblk}" = "${device}" ] || \
   [ ! "${device#/dev/nvme}" = "${device}" ]; then
    part_prefix="p"
    rootwait="rootwait"
fi

# USB devices also require rootwait
if [ -d /dev/disk/by-id ]; then
    find /dev/disk/by-id/ -name usb* | while read usbdev; do
        if readlink $usbdev | grep -q $TARGET_DEVICE_NAME; then
            rootwait="rootwait"
            break
        fi
    done
fi

bootfs=${device}${part_prefix}1
rootfs=${device}${part_prefix}2

echo
echo "Current partition table available on ${device}:"
echo
gdisk -l ${device}
echo

# Get user choice for partition table
while true; do
    echo "Erase and recreate partition table for device ${device}? (y / n): "
    read answer
    if [ "$answer" = "y" ]; then
        echo "Deleting partition table on ${device} ..."
        dd if=/dev/zero of=${device} bs=512 count=35

        echo "Creating new partition table on ${device} ..."
        echo -e "2\nw\nY\n" | gdisk ${device} > /dev/null 2>&1

        echo "Creating boot partition on $bootfs"
        echo -e "n\n1\n\n${boot_size}M\nef00\nc\nboot\nw\nY\n" | gdisk ${device} > /dev/null
        format_boot="y"

        echo "Creating rootfs partition on $rootfs"
        echo -e "n\n2\n\n\n8300\nc\n2\nroot\nw\nY\n" | gdisk ${device} > /dev/null

        echo
        gdisk -l ${device}
        echo

        echo "Waiting for device nodes..."
        sleep 1
        C=0
        while [ $C -ne 2 ] && [ ! -e $bootfs  -o ! -e $rootfs ]; do
            C=$(( C + 1 ))
            sleep 1
        done
        break
    elif [ "$answer" = "n" ]; then
        echo "Not erasing current partition table for device ${device}. Use ${bootfs} as boot/ESP and ${rootfs} as rootfs? (y - default / n)"
        echo
        read answer
        if [ "$answer" = "n" ]; then
            while true; do
                echo "Please define the partition to be used as boot/ESP (e.g. ${bootfs}): "
                echo
                read answer
                if [ -n "${answer}" ] && [ -b ${answer} ]; then
                    bootfs=${answer}
                    break;
                else
                    echo "Invalid block device for boot/ESP"
                fi
            done
            while true; do
                echo "Now please define the partition to be used as rootfs (e.g. ${rootfs}): "
                echo
                read answer
                if [ -n "${answer}" ] && [ -b ${answer} ]; then
                    rootfs=${answer}
                    break;
                else
                    echo "Invalid block device for rootfs"
                fi
            done
        fi
        echo
        echo "Format ${bootfs} (ESP) partition? (n - default / y): "
        read answer
        if [ "$answer" = "y" ]; then
            format_boot="y"
        fi
        break
    fi
done

if [ "$format_boot" = "y" ]; then
    echo "Formatting $bootfs to vfat..."
    mkfs.vfat -F 32 -n boot $bootfs
fi

echo "Formatting $rootfs to ext4..."
mkfs.ext4 -F $rootfs

mkdir /tgt_root
mkdir /src_root
mkdir -p /boot

# Path /run/media/<label>-sdX (check wks used)
install_mount=`ls /run/media | grep install-`
otaboot_mount=`ls /run/media | grep otaboot- || true`
rootfs_mount=`ls /run/media | grep image-`

# Handling of the target root partition
mount $rootfs /tgt_root

if cryptsetup isLuks /run/media/${rootfs_mount}/rootfs.img; then
    check_secure_boot
    echo "Handle encrypted rootfs..."
    echo -n "fiopassphrase" | cryptsetup luksOpen --key-file=- /run/media/${rootfs_mount}/rootfs.img rootfs_luks
    mount -o rw,loop,noatime,nodiratime /dev/mapper/rootfs_luks /src_root
else
    echo "Handle non-encrypted rootfs..."
    mount -o rw,loop,noatime,nodiratime /run/media/${rootfs_mount}/rootfs.img /src_root
fi

echo "Copying rootfs files..."
cp -a /src_root/* /tgt_root
umount /src_root

if cryptsetup isLuks /run/media/${rootfs_mount}/rootfs.img; then
    cryptsetup luksClose rootfs_luks
fi

# LMP preloaded containers (containers and updated installed_versions)
if [ -d /run/media/${rootfs_mount}/ostree/deploy/lmp/var/lib/docker ]; then
    cp -a /run/media/${rootfs_mount}/ostree/deploy/lmp/var/lib/docker /tgt_root/ostree/deploy/lmp/var/lib/
    cp -a /run/media/${rootfs_mount}/ostree/deploy/lmp/var/sota/import/installed_versions /tgt_root/ostree/deploy/lmp/var/sota/import/
fi
if [ -d /run/media/${rootfs_mount}/ostree/deploy/lmp/var/sota/compose-apps ]; then
    # Delete preloaded containers previously available as part of rootfs.img (platform build)
    rm -rf /tgt_root/ostree/deploy/lmp/var/sota/compose-apps
    cp -a /run/media/${rootfs_mount}/ostree/deploy/lmp/var/sota/compose-apps /tgt_root/ostree/deploy/lmp/var/sota/compose-apps
fi

# LMP specific customizations, if available (live media first partition, vfat)
if [ -d /run/media/${install_mount}/lmp ]; then
    cp -a /run/media/${install_mount}/lmp /tgt_root/ostree/deploy/lmp/var/
fi

# Handling of the target boot partition
mount $bootfs /boot
echo "Preparing boot partition..."

rootfs_uuid=$(blkid -o value -s UUID ${rootfs})

EFIDIR="/boot/EFI/BOOT"
mkdir -p $EFIDIR

# otaboot means systemd-boot
if [ -n "${otaboot_mount}" ]; then
    echo "Copying boot files..."
    cp -rf /run/media/${otaboot_mount}/* /boot
    # Generate default loader.conf
    cat << EOF > /boot/loader/loader.conf
timeout 1
EOF
    sed -i "s/root=LABEL=otaroot/root=UUID=${rootfs_uuid} ${rootwait}/g" /boot/loader/entries/*.conf
else
    # Generate default grub.cfg
    cat << EOF > $EFIDIR/grub.cfg
search.fs_uuid ${rootfs_uuid} root
configfile /boot/loader/grub.cfg
EOF
    sed -i "s/root=LABEL=otaroot/root=UUID=${rootfs_uuid} ${rootwait}/g" \
        /tgt_root/boot/loader/grub.cfg /tgt_root/boot/loader/entries/*.conf
fi

# Copy the efi loader
efiloader=`basename /run/media/${rootfs_mount}/EFI/BOOT/boot*.efi`
cp /run/media/${rootfs_mount}/EFI/BOOT/${efiloader} $EFIDIR
# Also duplicate systemd efi loader if available for compliance
if [ -d /run/media/${rootfs_mount}/EFI/systemd ]; then
    cp -rf /run/media/${rootfs_mount}/EFI/systemd /boot/EFI
fi

# Make sure startup.nsh is also available at the boot partition
if [ -f /run/media/${rootfs_mount}/startup.nsh ]; then
    cp /run/media/${rootfs_mount}/startup.nsh /boot
fi

# Set default EFI boot entry
BOOTLABEL="LmP"
if [ -d /sys/firmware/efi/efivars ]; then
    # Delete old LmP entry
    bootnum=`efibootmgr | grep "^Boot[0-9]" | grep "${BOOTLABEL}$" | sed -e "s|Boot||" -e "s|\*.*||"`
    if [ -n "$bootnum" ]; then
        efibootmgr -b $bootnum -B || true
    fi

    # Add new LmP entry
    efibootmgr -c -d ${device} -p 1 -w -L ${BOOTLABEL} -l "\EFI\BOOT\\${efiloader}" || true
fi

umount /tgt_root
umount /boot

sync

echo "Installation successful. Remove your installation media and press ENTER to reboot."

read enter

echo "Rebooting..."
reboot -f
