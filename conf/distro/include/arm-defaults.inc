# This function changes the default tune for machines which
# are based on armv7a or armv7ve to use common tune value, note
# that we enforce hard-float which is default on Linux microPlatform.
# If you have one of those machines which are armv7a or armv7ve but
# can't support hard-float, please change tune = 'armv7athf' to
# tune = 'armv7at' below but then this is for your own distro.

def arm_tune_handler(d):
    features = d.getVar('TUNE_FEATURES').split()
    if 'armv7a' in features or 'armv7ve' in features:
        tune = 'armv7athf'
        if 'bigendian' in features:
            tune += 'b'
        if 'vfpv3' in features:
            tune += '-vfpv3'
        if 'vfpv3d16' in features:
            tune += '-vfpv3d16'
        if 'neon' in features:
            tune += '-neon'
        if 'vfpv4' in features:
            tune += '-vfpv4'
    else:
        tune = d.getVar('DEFAULTTUNE')
    return tune

DEFAULTTUNE_lmp := "${@arm_tune_handler(d)}"
