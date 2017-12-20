# site-ffv
Gluon Site of Freifunk Vogtland

## Prebuild images

Already build images can be downloaded at http://firmware.freifunk-vogtland.net/firmware/

## building images from releases

    # configure build specific settings
    GLUON_VERSION="2017.1.4-2"
    SIGN_KEYDIR="/opt/freifunk/signkeys_ffv"
    MANIFEST_KEY="manifest_key"
    SITE_TAG=b20170719-v
    TARGET_BRANCH=experimental
    GLUONDIR="gluon-ffv-${TARGET_BRANCH}"
    
    # set gluon env variables
    export GLUON_OPKG_KEY="${SIGN_KEYDIR}/gluon-opkg-key"
    export GLUON_RELEASE="${SITE_TAG}"
    
    TARGETS="\
        ar71xx-generic \
        ar71xx-tiny \
        ar71xx-nand \
        brcm2708-bcm2708 \
        brcm2708-bcm2709 \
        mpc85xx-generic \
        x86-generic \
        x86-geode \
        x86-64 \
        \
        ar71xx-mikrotik \
        ipq806x \
        mvebu \
        ramips-mt7621 \
        ramips-mt7628 \
        ramips-rt305x \
        sunxi \
    "
    
    # build
    git clone https://github.com/FreifunkVogtland/gluon.git "${GLUONDIR}" -b v"${GLUON_VERSION}"
    git clone https://github.com/FreifunkVogtland/site-ffv.git "${GLUONDIR}"/site -b "${SITE_TAG}"
    make -C "${GLUONDIR}" update
    for target in ${TARGETS}; do
        make -C "${GLUONDIR}" GLUON_TARGET="${target}" BROKEN=1 clean -j"$(nproc || echo 1)"
        make -C "${GLUONDIR}" GLUON_TARGET="${target}" BROKEN=1 GLUON_BRANCH="${TARGET_BRANCH}" -j"$(nproc || echo 1)"
    done
    
    make -C "${GLUONDIR}" GLUON_BRANCH="${TARGET_BRANCH}" BROKEN=1 manifest
    "${GLUONDIR}"/contrib/sign.sh "${SIGN_KEYDIR}/${MANIFEST_KEY}" "${GLUONDIR}"/output/images/sysupgrade/"${TARGET_BRANCH}".manifest
