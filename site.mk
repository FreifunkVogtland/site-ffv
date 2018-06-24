GLUON_FEATURES := \
	authorized-keys \
	autoupdater \
	config-mode-core \
	config-mode-domain-select \
	ebtables-filter-multicast \
	ebtables-filter-ra-dhcp \
	ebtables-limit-arp \
	mesh-batman-adv-15 \
	mesh-vpn-fastd \
	radvd \
	radv-filterd \
	respondd \
	setup-mode \
	ssid-changer \
	status-page \
	web-advanced \
	web-private-wifi \
	web-wizard

GLUON_SITE_PACKAGES := \
	ffffm-ath9k-broken-wifi-workaround \
	ffho-autoupdater-wifi-fallback \
	haveged \
	iwinfo \
	respondd-module-airtime

ifeq ($(GLUON_TARGET),x86-generic)
GLUON_SITE_PACKAGES += \
    kmod-usb-core \
    kmod-usb2 \
    kmod-usb-hid
endif

ifeq ($(GLUON_TARGET),x86-64)
GLUON_SITE_PACKAGES += \
    kmod-usb-core \
    kmod-usb2 \
    kmod-usb-hid
endif

ifeq ($(GLUON_TARGET),x86-geode)
GLUON_SITE_PACKAGES += \
    kmod-usb-core \
    kmod-usb2 \
    kmod-usb-hid
endif

DEFAULT_GLUON_RELEASE := b$(shell date '+%Y%m%d')-exp

GLUON_RELEASE ?= $(DEFAULT_GLUON_RELEASE)

GLUON_PRIORITY ?= 7

GLUON_LANGS ?= de
GLUON_REGION = eu
GLUON_ATH10K_MESH = 11s
GLUON_MULTIDOMAIN = 1
