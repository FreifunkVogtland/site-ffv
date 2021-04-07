#GLUON_GIT_URL := https://github.com/freifunk-gluon/gluon.git
#GLUON_GIT_REF := v2020.2.2

GLUON_GIT_URL := https://github.com/FreifunkVogtland/gluon.git
GLUON_GIT_REF := v2020.2.2-1

SITE_TAG := b20210407
TARGET_BRANCH := experimental
GLUONDIR := "gluon-ffv-${TARGET_BRANCH}"

SIGN_KEYDIR="/opt/freifunk/signkeys_ffv"
MANIFEST_KEY="manifest_key"

PATCH_DIR := ${GLUONDIR}/site/patches
SECRET_KEY_FILE ?= ${SIGN_KEYDIR}/${MANIFEST_KEY}

GLUON_TARGETS ?= \
	ar71xx-generic \
	ar71xx-tiny \
	ar71xx-nand \
	brcm2708-bcm2708 \
	brcm2708-bcm2709 \
	mpc85xx-generic \
	mpc85cc-p1020 \
	lantiq-xway \
	lantiq-xrx200 \
	ath79-generic \
	ramips-mt7621 \
	sunxi-cortexa7 \
	x86-generic \
	x86-geode \
	x86-64 \
	x86-legacy \
	ipq40xx-generic \
	ipq806x-generic \
	ramips-mt7620 \
	ramips-mt76x8 \
	ramips-rt305x

ifneq (,$(shell git describe --exact-match --tags 2>/dev/null))
	GLUON_BRANCH := stable
	GLUON_RELEASE := ${SITE_TAG}
else
	GLUON_BRANCH := experimental
	GLUON_RELEASE := ${SITE_TAG}-exp
endif

JOBS ?= $(shell cat /proc/cpuinfo | grep processor | wc -l)

GLUON_MAKE := ${MAKE} -j ${JOBS} -C ${GLUONDIR} \
	GLUON_RELEASE=${GLUON_RELEASE} \
	GLUON_BRANCH=${GLUON_BRANCH}

all: info
	${MAKE} manifest

info:
	@echo
	@echo '#########################'
	@echo '# FFV Firmware build'
	@echo '# Building release ${GLUON_RELEASE} for branch ${GLUON_BRANCH}'
	@echo

build: gluon-prepare
	for target in ${GLUON_TARGETS}; do \
		echo ""Building target $$target""; \
		${GLUON_MAKE} download all GLUON_TARGET="$$target"; \
	done

manifest: build
	${GLUON_MAKE} manifest
	mv ${GLUONDIR}/output .

sign: manifest
	${GLUONDIR}/contrib/sign.sh ${SECRET_KEY_FILE} output/images/sysupgrade/${GLUON_BRANCH}.manifest

${GLUONDIR}:
	git clone ${GLUON_GIT_URL} ${GLUONDIR}

gluon-prepare: output-clean ${GLUONDIR}
	cd ${GLUONDIR} \
		&& git remote set-url origin ${GLUON_GIT_URL} \
		&& git fetch origin \
		&& rm -rf packages \
		&& git checkout -q --force ${GLUON_GIT_REF} \
		&& git clean -fd;
	ln -sfT .. ${GLUONDIR}/site
	make gluon-patch
	${GLUON_MAKE} update

gluon-patch:
	echo "Applying Patches ..."
	(cd ${GLUONDIR})
			if [ `git branch --list patched` ]; then \
				(git branch -D patched) \
			fi
	(cd ${GLUONDIR}; git checkout -B patching)
	if [ -d "gluon-build/site/patches" -a "gluon-build/site/patches/*.patch" ]; then \
		(cd ${GLUONDIR}; git apply --ignore-space-change --ignore-whitespace --whitespace=nowarn site/patches/*.patch) || ( \
			cd ${GLUONDIR}; \
			git clean -fd; \
			git checkout -B patched; \
			git branch -D patching; \
			exit 1 \
		) \
	fi
	(cd ${GLUONDIR}; git branch -M patched)

gluon-clean:
	rm -rf ${GLUONDIR}

output-clean:
	rm -rf output

clean: gluon-clean output-clean