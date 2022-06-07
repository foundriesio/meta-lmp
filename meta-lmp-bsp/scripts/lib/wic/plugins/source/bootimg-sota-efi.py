# Copyright (c) 2014, Intel Corporation.
# Copyright (c) 2018, Open Source Foundries Ltd.
#
# SPDX-License-Identifier: GPL-2.0-only
#
# DESCRIPTION
# This implements the 'bootimg-sota-efi' source plugin class for 'wic'
#
# Heavily based on the bootimg-efi plugin from OE-core.

import logging
import os
import shutil
import re

from oe.path import copyhardlinktree
from glob import glob

from wic import WicError
from wic.engine import get_custom_config
from wic.pluginbase import SourcePlugin
from wic.misc import (exec_cmd, exec_native_cmd,
                      get_bitbake_var, BOOTDD_EXTRA_SPACE)

logger = logging.getLogger('wic')

class BootimgSotaEFIPlugin(SourcePlugin):
    """
    Create Sota EFI boot partition.
    This plugin supports GRUB 2 and systemd-boot bootloaders.
    """

    name = 'bootimg-sota-efi'

    @classmethod
    def do_configure_grubefi(cls, creator, cr_workdir):
        """
        Create loader-specific (grub-efi) config
        """
        configfile = creator.ks.bootloader.configfile

        if not configfile:
            logger.debug("Setting grub-ota.cfg as default configfile")
            configfile = "grub-ota.cfg"

        custom_cfg = None
        custom_cfg = get_custom_config(configfile)
        if custom_cfg:
            # Use a custom configuration for grub
            grubefi_conf = custom_cfg
            logger.debug("Using custom configuration file "
                         "%s for grub.cfg", configfile)
        else:
            raise WicError("configfile is specified but failed to "
                          "get it from %s." % configfile)

        logger.debug("Writing grubefi config %s/hdd/boot/EFI/BOOT/grub.cfg",
                     cr_workdir)
        cfg = open("%s/hdd/boot/EFI/BOOT/grub.cfg" % cr_workdir, "w")
        cfg.write(grubefi_conf)
        cfg.close()


    @classmethod
    def do_configure_systemdboot(cls, hdddir, part, creator):
        """
        Create loader-specific systemd-boot/gummiboot config
        """
        if part.rootfs_dir is None:
            raise WicError("Couldn't find --rootfs-dir, exiting")
        copyhardlinktree(part.rootfs_dir, hdddir)

        install_cmd = "install -d %s/EFI/systemd" % hdddir
        exec_cmd(install_cmd)

        install_cmd = "install -d %s/loader" % hdddir
        exec_cmd(install_cmd)

        bootloader = creator.ks.bootloader

        loader_conf = ""
        loader_conf += "timeout %d\n" % bootloader.timeout

        logger.debug("Writing systemd-boot config "
                     "%s/loader/loader.conf", hdddir)
        cfg = open("%s/loader/loader.conf" % hdddir, "w")
        cfg.write(loader_conf)
        cfg.close()


    @classmethod
    def do_configure_partition(cls, part, source_params, creator, cr_workdir,
                               oe_builddir, bootimg_dir, kernel_dir,
                               native_sysroot):
        """
        Called before do_prepare_partition(), creates loader-specific config
        """
        hdddir = "%s/hdd/boot" % cr_workdir

        install_cmd = "install -d %s/EFI/BOOT" % hdddir
        exec_cmd(install_cmd)

        try:
            if source_params['loader'] == 'grub-efi':
                cls.do_configure_grubefi(creator, cr_workdir)
            elif source_params['loader'] == 'systemd-boot':
                cls.do_configure_systemdboot(hdddir, part, creator)
            else:
                raise WicError("unrecognized bootimg-sota-efi loader: %s" % source_params['loader'])
        except KeyError:
            raise WicError("bootimg-sota-efi requires a loader, none specified")

        if get_bitbake_var("IMAGE_EFI_BOOT_FILES") is None:
            logger.debug('No boot files defined in IMAGE_EFI_BOOT_FILES')
        else:
            boot_files = None
            for (fmt, id) in (("_uuid-%s", part.uuid), ("_label-%s", part.label), (None, None)):
                if fmt:
                    var = fmt % id
                else:
                    var = ""

                boot_files = get_bitbake_var("IMAGE_EFI_BOOT_FILES" + var)
                if boot_files:
                    break

            logger.debug('Boot files: %s', boot_files)

            # list of tuples (src_name, dst_name)
            deploy_files = []
            for src_entry in re.findall(r'[\w;\-\./\*]+', boot_files):
                if ';' in src_entry:
                    dst_entry = tuple(src_entry.split(';'))
                    if not dst_entry[0] or not dst_entry[1]:
                        raise WicError('Malformed boot file entry: %s' % src_entry)
                else:
                    dst_entry = (src_entry, src_entry)

                logger.debug('Destination entry: %r', dst_entry)
                deploy_files.append(dst_entry)

            cls.install_task = [];
            for deploy_entry in deploy_files:
                src, dst = deploy_entry
                if '*' in src:
                    # by default install files under their basename
                    entry_name_fn = os.path.basename
                    if dst != src:
                        # unless a target name was given, then treat name
                        # as a directory and append a basename
                        entry_name_fn = lambda name: \
                                        os.path.join(dst,
                                                     os.path.basename(name))

                    srcs = glob(os.path.join(kernel_dir, src))

                    logger.debug('Globbed sources: %s', ', '.join(srcs))
                    for entry in srcs:
                        src = os.path.relpath(entry, kernel_dir)
                        entry_dst_name = entry_name_fn(entry)
                        cls.install_task.append((src, entry_dst_name))
                else:
                    cls.install_task.append((src, dst))

    @classmethod
    def do_prepare_partition(cls, part, source_params, creator, cr_workdir,
                             oe_builddir, bootimg_dir, kernel_dir,
                             rootfs_dir, native_sysroot):
        """
        Called to do the actual content population for a partition i.e. it
        'prepares' the partition to be incorporated into the image.
        In this case, prepare content for an EFI (grub) boot partition.
        """
        if not kernel_dir:
            kernel_dir = get_bitbake_var("DEPLOY_DIR_IMAGE")
            if not kernel_dir:
                raise WicError("Couldn't find DEPLOY_DIR_IMAGE, exiting")

        hdddir = "%s/hdd/boot" % cr_workdir

        if get_bitbake_var("IMAGE_EFI_BOOT_FILES"):
            for src_path, dst_path in cls.install_task:
                install_cmd = "install -m 0644 -D %s %s" \
                              % (os.path.join(kernel_dir, src_path),
                                 os.path.join(hdddir, dst_path))
                exec_cmd(install_cmd)

        try:
            if source_params['loader'] == 'grub-efi':
                shutil.copyfile("%s/hdd/boot/EFI/BOOT/grub.cfg" % cr_workdir,
                                "%s/grub.cfg" % cr_workdir)
                for mod in [x for x in os.listdir(kernel_dir) if x.startswith("grub-efi-")]:
                    cp_cmd = "cp %s/%s %s/EFI/BOOT/%s" % (kernel_dir, mod, hdddir, mod[9:])
                    exec_cmd(cp_cmd, True)
                shutil.move("%s/grub.cfg" % cr_workdir,
                            "%s/hdd/boot/EFI/BOOT/grub.cfg" % cr_workdir)
            elif source_params['loader'] == 'systemd-boot':
                for mod in [x for x in os.listdir(kernel_dir) if x.startswith("systemd-")]:
                    cp_cmd = "cp %s/%s %s/EFI/systemd/%s" % (kernel_dir, mod, hdddir, mod)
                    exec_cmd(cp_cmd, True)
                    cp_cmd = "cp %s/%s %s/EFI/BOOT/%s" % (kernel_dir, mod, hdddir, mod[8:])
                    exec_cmd(cp_cmd, True)
            else:
                raise WicError("unrecognized bootimg-sota-efi loader: %s" %
                               source_params['loader'])
        except KeyError:
            raise WicError("bootimg-sota-efi requires a loader, none specified")

        startup = os.path.join(kernel_dir, "startup.nsh")
        if os.path.exists(startup):
            cp_cmd = "cp %s %s/" % (startup, hdddir)
            exec_cmd(cp_cmd, True)

        du_cmd = "du -bks %s" % hdddir
        out = exec_cmd(du_cmd)
        blocks = int(out.split()[0])

        extra_blocks = part.get_extra_block_count(blocks)

        if extra_blocks < BOOTDD_EXTRA_SPACE:
            extra_blocks = BOOTDD_EXTRA_SPACE

        blocks += extra_blocks

        logger.debug("Added %d extra blocks to %s to get to %d total blocks",
                     extra_blocks, part.mountpoint, blocks)

        # dosfs image, created by mkdosfs
        bootimg = "%s/boot.img" % cr_workdir

        label = part.label if part.label else "efi"

        dosfs_cmd = "mkfs.vfat -F 32 -n %s -i %s -C %s %d" % \
                    (label, part.fsuuid, bootimg, blocks)
        exec_native_cmd(dosfs_cmd, native_sysroot)

        mcopy_cmd = "mcopy -i %s -s %s/* ::/" % (bootimg, hdddir)
        exec_native_cmd(mcopy_cmd, native_sysroot)

        chmod_cmd = "chmod 644 %s" % bootimg
        exec_cmd(chmod_cmd)

        du_cmd = "du -Lbks %s" % bootimg
        out = exec_cmd(du_cmd)
        bootimg_size = out.split()[0]

        part.size = int(bootimg_size)
        part.source_file = bootimg

    @classmethod
    def do_install_disk(cls, disk, disk_name, creator, workdir, oe_builddir,
                        bootimg_dir, kernel_dir, native_sysroot):
        """
        Called after all partitions have been prepared and assembled into a
        disk image.  In this case, we set boot flag for GPT.
        """
        full_path = creator._full_path(workdir, disk_name, "direct")
        if creator.ptable_format == 'gpt':
            exec_native_cmd("parted -s %s set 1 boot on" % \
                            full_path, native_sysroot)
