#!/bin/sh -e
#
# Copyright (c) 2012, Intel Corporation.
# Copyright (c) 2020, Foundries.IO Ltd
# All rights reserved.
#
# install.sh [device_name] [rootfs_name]
#

PATH=/sbin:/bin:/usr/sbin:/usr/bin

# minimal ESP partition size is 100mb
boot_size=100

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

disk_size=$(parted ${device} unit mb print | grep '^Disk .*: .*MB' | cut -d" " -f 3 | sed -e "s/MB//")

rootfs_size=$((disk_size-boot_size))

rootfs_start=$((boot_size))
rootfs_end=$((rootfs_start+rootfs_size))

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
find /dev/disk/by-id/ -name usb* | while read usbdev; do
    if readlink $usbdev | grep -q $TARGET_DEVICE_NAME; then
        rootwait="rootwait"
        break
    fi
done

bootfs=${device}${part_prefix}1
rootfs=${device}${part_prefix}2

echo
echo "Current partition table available on ${device}:"
echo
parted ${device} print

# Get user choice for partition table
while true; do
    echo "Erase and recreate partition table for device ${device}? (y / n): "
    read answer
    if [ "$answer" = "y" ]; then
        echo "Deleting partition table on ${device} ..."
        dd if=/dev/zero of=${device} bs=512 count=35

        echo "*****************"
        echo "Boot partition size:   $boot_size MB ($bootfs)"
        echo "Rootfs partition size: $rootfs_size MB ($rootfs)"
        echo "*****************"

        echo "Creating new partition table on ${device} ..."
        parted ${device} mklabel gpt

        echo "Creating boot partition on $bootfs"
        parted ${device} mkpart boot fat32 0% $boot_size
        parted ${device} set 1 boot on

        echo "Creating rootfs partition on $rootfs"
        parted ${device} mkpart root ext4 $rootfs_start 100%

        parted ${device} print

        echo "Waiting for device nodes..."
        sleep 1
        C=0
        while [ $C -ne 2 ] && [ ! -e $bootfs  -o ! -e $rootfs ]; do
            C=$(( C + 1 ))
            sleep 1
        done
        break
    elif [ "$answer" = "n" ]; then
        echo "Not erasing current partition table for device ${device}, assuming ${bootfs} as boot/ESP and ${rootfs} as rootfs."
        break
    fi
done

echo "Formatting $bootfs to vfat..."
mkfs.vfat -F 32 -n boot $bootfs

echo "Formatting $rootfs to ext4..."
mkfs.ext4 -F $rootfs

mkdir /tgt_root
mkdir /src_root
mkdir -p /boot

# Handling of the target root partition
mount $rootfs /tgt_root
mount -o rw,loop,noatime,nodiratime /run/media/$1/$2 /src_root
echo "Copying rootfs files..."
cp -a /src_root/* /tgt_root
# Update fstab at the ostree deploy folder
if [ -d /tgt_root/ostree/deploy/lmp/deploy ] ; then
    deploy_hash=$(ls /tgt_root/ostree/deploy/lmp/deploy/ | grep -m 1 -v "\.origin")
    boot_uuid=$(blkid -o value -s UUID ${bootfs})
    sed -i "s/LABEL=efi/UUID=${boot_uuid}/g" /tgt_root/ostree/deploy/lmp/deploy/${deploy_hash}/etc/fstab
fi

# Update boot args to include UUID and extra options
rootfs_uuid=$(blkid -o value -s UUID ${rootfs})
sed -i "s/root=LABEL=otaroot/root=UUID=${rootfs_uuid} ${rootwait}/g" \
    /tgt_root/boot/loader/grub.cfg /tgt_root/boot/loader/entries/*.conf

# LMP preloaded containers (containers and updated installed_versions)
if [ -d /run/media/$1/ostree/deploy/lmp/var/lib/docker ]; then
    cp -a /run/media/$1/ostree/deploy/lmp/var/lib/docker /tgt_root/ostree/deploy/lmp/var/lib/
    cp -a /run/media/$1/ostree/deploy/lmp/var/sota/import/installed_versions /tgt_root/ostree/deploy/lmp/var/sota/import/
fi
if [ -d /run/media/$1/ostree/deploy/lmp/var/sota/compose-apps ]; then
    # Delete preloaded containers previously available as part of rootfs.img (platform build)
    rm -rf /tgt_root/ostree/deploy/lmp/var/sota/compose-apps
    cp -a /run/media/$1/ostree/deploy/lmp/var/sota/compose-apps /tgt_root/ostree/deploy/lmp/var/sota/compose-apps
fi

# LMP specific customizations, if available (live media first partition, vfat)
if [ -d /run/media/${live_dev_name}1/lmp ]; then
    cp -a /run/media/${live_dev_name}1/lmp /tgt_root/ostree/deploy/lmp/var/
fi

umount /src_root

# Handling of the target boot partition
mount $bootfs /boot
echo "Preparing boot partition..."

EFIDIR="/boot/EFI/BOOT"
mkdir -p $EFIDIR
# Copy the efi loader
efiloader=`basename /run/media/$1/EFI/BOOT/boot*.efi`
cp /run/media/$1/EFI/BOOT/${efiloader} $EFIDIR

# Generate boot grub.cfg
cat << EOF > $EFIDIR/grub.cfg
search.fs_uuid ${rootfs_uuid} root
configfile /boot/loader/grub.cfg
EOF

# Make sure startup.nsh is also available at the boot partition
if [ -f /run/media/$1/startup.nsh ]; then
    cp /run/media/$1/startup.nsh /boot
fi

# Set default EFI boot entry
BOOTLABEL="LmP"
if [ -d /sys/firmware/efi/efivars ]; then
    # Delete old LmP entry
    bootnum=`efibootmgr | grep "^Boot[0-9]" | grep "${BOOTLABEL}$" | sed -e "s|Boot||" -e "s|\*.*||"`
    if [ -n "$bootnum" ]; then
        efibootmgr -b $bootnum -B
    fi

    # Add new LmP entry
    efibootmgr -c -d ${device} -p 1 -w -L ${BOOTLABEL} -l "\EFI\BOOT\\${efiloader}"
fi

umount /tgt_root
umount /boot

sync

echo "Installation successful. Remove your installation media and press ENTER to reboot."

read enter

echo "Rebooting..."
reboot -f
