# site-ffv
Gluon Site of Freifunk Vogtland

## Prebuild images

Already build images can be downloaded at http://firmware.freifunk-vogtland.net/firmware/

## building images from releases

    # configure build specific settings
    GLUON_VERSION="2023.2.1-1"
    SIGN_KEYDIR="/opt/freifunk/signkeys_ffv"
    MANIFEST_KEY="manifest_key"
    SITE_TAG=b20231014
    TARGET_BRANCH=stable
    GLUONDIR="gluon-ffv-${TARGET_BRANCH}"
    
    # set gluon env variables
    export GLUON_RELEASE="${SITE_TAG}"
    
    MAKEFLAGS=""
    
    # build
    git clone https://github.com/FreifunkVogtland/gluon.git "${GLUONDIR}" -b v"${GLUON_VERSION}"
    git clone https://github.com/FreifunkVogtland/site-ffv.git "${GLUONDIR}"/site -b "${SITE_TAG}"
    make -C "${GLUONDIR}" $MAKEFLAGS update
    for target in $(make -s -C "${GLUONDIR}" $MAKEFLAGS list-targets); do
        make -C "${GLUONDIR}" GLUON_TARGET="${target}" $MAKEFLAGS -j"$(nproc || echo 1)"
    done
    
    make -C "${GLUONDIR}" $MAKEFLAGS manifest
    "${GLUONDIR}"/contrib/sign.sh "${SIGN_KEYDIR}/${MANIFEST_KEY}" "${GLUONDIR}"/output/images/sysupgrade/"${TARGET_BRANCH}".manifest

## building single images

The actual name of the device and its target has to be has to be found. All
the targets are listed in `targets/` and devices are listed in each file.
For example `tp-link-tl-wr1043n-nd-v1` can be found in
`targets/ar71xx-generic`.

Most steps as shown above has to be used. But everything after
`make -C "${GLUONDIR}" update` has to be replaced with:

    make -C "${GLUONDIR}" GLUON_TARGET=ar71xx-generic GLUON_DEVICES="tp-link-tl-wr1043n-nd-v1" -j"$(nproc || echo 1)"
