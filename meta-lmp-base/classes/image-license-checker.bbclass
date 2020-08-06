# Copyright (c) 2018 Arm Limited and Contributors. All rights reserved.
#
# SPDX-License-Identifier: MIT

# Purpose
# -------
# The image-license-checker class is for:
# * Preventing packages with blacklisted licenses from being used in a rootfs.
# * Preventing recipes with blacklisted licenses from contributing files to the
#   non-rootfs part of an image.
#
# Unlike the INCOMPATIBLE_LICENSE mechanism, this class works at a rootfs/image
# level rather than a package level. With this class you can allow blacklisted
# licensed packages to be built, but prevent them from being included in images
# whose recipes inherit from this class.
#
# Also unlike the INCOMPATIBLE_LICENSE mechanism, this class doesn't take into
# account ORs ("|"s) in license expressions. The INCOMPATIBLE_LICENSE mechanism
# will only prevent a package "package1" with license "lic1 | lic2" to be built
# when both lic1 and lic2 are blacklisted. That approach doesn't work because a
# dependent package "package2" might be using "package1" under the terms of a
# blacklisted license even if "package1" is also available under a different
# non-blacklisted license.
#
# Usage
# -----
# To use this class in a recipe for an image:
# * If you want to blacklist licenses in the rootfs, set
#   IMAGE_LICENSE_CHECKER_ROOTFS_BLACKLIST to a space delimited list of SPDX
#   license names to be blacklisted from the rootfs.
# * If you want to blacklist licenses in the non-rootfs parts of an image, set
#   IMAGE_LICENSE_CHECKER_NON_ROOTFS_BLACKLIST to a space delimited list of SPDX
#   license names to be blacklisted from the non-rootfs parts of the image.
# * Add the line "inherit image-license-checker".
#
# Example
# -------
# IMAGE_LICENSE_CHECKER_ROOTFS_BLACKLIST = "GPL-3.0 LGPL-3.0 AGPL-3.0"
# IMAGE_LICENSE_CHECKER_NON_ROOTFS_BLACKLIST = "GPL-3.0 LGPL-3.0 AGPL-3.0"
# inherit image-license-checker
#

IMAGE_LICENSE_CHECKER_ROOTFS_BLACKLIST ?= ""
IMAGE_LICENSE_CHECKER_NON_ROOTFS_BLACKLIST ?= ""


def bad_license(d, license, blacklist):
    """
    Check if a license string is blacklisted. The license string will be
    canonicalized before the check. This does not deal with license
    expressions, just single licenses, although it does take into account "+"s.
    I.e. if "GPL-3.0" is in the blacklist then this function will return true
    for a license string "GPLv3+".
    """
    return not oe.license.license_ok(
        canonical_license(d, license),
        blacklist)


def bad_license_expr(d, license_expr, blacklist):
    """
    Check if a license expression contains a bad blacklisted license. This does
    not take into acount ORs ("|"s) in the license expression.
    """
    licenses = oe.license.list_licenses(license_expr)
    return any(bad_license(d, license, blacklist) for license in licenses)


def license_expr_from_file(file, keys):
    """
    Get a license expression from a file where each line is of the form "KEY:
    VALUE". keys is a list of keys that might contain the license expression.
    """
    with open(file, "r") as f:
        for line in f.readlines():
            key, val = line.strip().split(": ", 1)
            if key in keys:
                return val
        bb.fatal("Failed to find license information in file \"{}\"".format(file))


def license_expr_for_installed_package(d, inst_package):
    """
    Get a license expression from the name of a package as installed in the
    rootfs. The installed package name might not be the same as the OE package
    name due to conversions to debian-style library package names.
    """
    file = os.path.join(
        d.getVar('PKGDATA_DIR'),
        'runtime-reverse',
        inst_package)

    package = package_name_for_installed_package(d, inst_package)
    keys_in_file = ["LICENSE", "LICENSE_{}".format(package)]
    return license_expr_from_file(file, keys_in_file)


def license_expr_for_recipe(d, recipe):
    """
    Get a license expression for a recipe.
    """
    file = os.path.join(d.getVar("LICENSE_DIRECTORY"), recipe, "recipeinfo")
    keys_in_file = ["LICENSE"]
    return license_expr_from_file(file, keys_in_file)


def package_name_for_installed_package(d, inst_package):
    """
    Get the OE package name from the name of the package installed on the
    rootfs. These might not be the same due to conversions to debian-style
    library package names.
    """
    file = os.path.join(
        d.getVar('PKGDATA_DIR'),
        'runtime-reverse',
        inst_package)

    return os.path.basename(os.readlink(file))


python check_rootfs_licenses() {
    """
    Check packages installed on the rootfs for blacklisted licenses.
    """
    blacklist = d.getVar('IMAGE_LICENSE_CHECKER_ROOTFS_BLACKLIST').split()

    bad_packages = []
    for inst_package in oe.rootfs.image_list_installed_packages(d):
        license_expr = license_expr_for_installed_package(d, inst_package)
        if bad_license_expr(d, license_expr, blacklist):
            package = package_name_for_installed_package(d, inst_package)
            bad_packages.append("{} ({})".format(package, license_expr))

    if bad_packages:
        bb.fatal("Packages have blacklisted licenses: {}".format(", ".join(bad_packages)))
}
ROOTFS_POSTPROCESS_COMMAND_prepend = "check_rootfs_licenses; "


python check_deploy_licenses() {
    """
    Check recipes that deploy files used in an image (e.g. U-Boot) for
    blacklisted licenses.
    """
    blacklist = d.getVar('IMAGE_LICENSE_CHECKER_NON_ROOTFS_BLACKLIST').split()

    bad_recipes = []
    for recipe in get_deployed_dependencies(d).keys():
        license_expr = license_expr_for_recipe(d, recipe)
        if bad_license_expr(d, license_expr, blacklist):
            bad_recipes.append("{} ({})".format(recipe, license_expr))

    if bad_recipes:
        bb.fatal("Deployed image dependencies have blacklisted licenses: {}".format(", ".join(bad_recipes)))
}
IMAGE_POSTPROCESS_COMMAND_prepend = "check_deploy_licenses; "
