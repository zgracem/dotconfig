# dnsmasq -- enable local .test TLD

include ../../common.mk

.PHONY: dnsmasq/all
dnsmasq/all: | /usr/local/sbin/dnsmasq
	sudo brew services restart dnsmasq

/usr/local/sbin/dnsmasq: | /usr/local/bin/brew
	brew install dnsmasq

dnsmasq/all: /usr/local/etc/dnsmasq.d/000-dnsmasq.conf
/usr/local/etc/dnsmasq.d/000-dnsmasq.conf: dnsmasq.d/000-dnsmasq.conf
	${INSTALL} --mode=0644 -- $< $@

dnsmasq/all: /usr/local/etc/dnsmasq.d/001-resolver.conf
/usr/local/etc/dnsmasq.d/001-resolver.conf: dnsmasq.d/001-resolver.conf
	${INSTALL} --mode=0644 -- $< $@

dnsmasq/all: /etc/resolver/test
/etc/resolver/test: resolver/test
	sudo ${INSTALL} --mode=0644 -- $< $@
