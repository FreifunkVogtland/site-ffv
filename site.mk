GLUON_FEATURES := \
	authorized-keys \
	autoupdater \
	config-mode-core \
	config-mode-domain-select \
	config-mode-geo-location-osm \
	ebtables-filter-multicast \
	ebtables-filter-ra-dhcp \
	mesh-batman-adv-15 \
	mesh-vpn-fastd \
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
	iwinfo \
	respondd-module-airtime

ifeq ($(GLUON_TARGET),x86-generic)
GLUON_SITE_PACKAGES += \
    kmod-usb-hid
endif

ifeq ($(GLUON_TARGET),x86-64)
GLUON_SITE_PACKAGES += \
    kmod-usb-hid
endif

ifeq ($(GLUON_TARGET),x86-geode)
GLUON_SITE_PACKAGES += \
    kmod-usb-hid
endif

DEFAULT_GLUON_RELEASE := b$(shell date '+%Y%m%d')-exp

GLUON_RELEASE ?= $(DEFAULT_GLUON_RELEASE)
GLUON_AUTOUPDATER_ENABLED ?= 1
GLUON_AUTOUPDATER_BRANCH ?= experimental

GLUON_PRIORITY ?= 7

GLUON_LANGS ?= de
GLUON_REGION = eu
GLUON_MULTIDOMAIN = 1
GLUON_DEPRECATED = 1
