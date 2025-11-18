# this file is required to store the initramfs on the sstate cache
# oe-core patch not accepted
# https://patchwork.yoctoproject.org/project/oe-core/patch/20230713110244.3169513-2-jose.quaresma@foundries.io/

# override sstate.bbclass sstate_report_unihash
python sstate_report_unihash() {
    report_unihash = getattr(bb.parse.siggen, 'report_unihash', None)

    if report_unihash:
        ss = sstate_state_fromvars(d)
        if ss['task'] == 'image_complete':
            os.environ['PSEUDO_DISABLED'] = '1'
        report_unihash(os.getcwd(), ss['task'], d)
}

SSTATE_SKIP_CREATION:task-image-qa = "0"
# this needs the sstate_report_unihash override
SSTATE_SKIP_CREATION:task-image-complete = "0"

inherit nopackages
