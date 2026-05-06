features({
	'authorized-keys',
	'autoupdater',
	'config-mode-core',
	'config-mode-domain-select',
	'config-mode-geo-location-osm',
	'ebtables-filter-multicast',
	'ebtables-filter-ra-dhcp',
	'mesh-batman-adv-15',
	'mesh-batman-adv-brmldproxy',
	'mesh-vpn-fastd',
	'mesh-vpn-fastd-l2tp',
	'radv-filterd',
	'respondd',
	'setup-mode',
	'ssid-changer',
	'status-page',
	'web-advanced',
	'web-private-wifi',
	'web-wizard',
})

if target('x86') then
	packages({
		'kmod-usb-hid',
	})
end

packages({
	'ffffm-ath9k-broken-wifi-workaround',
	'iwinfo',
	'respondd-module-airtime',
})
