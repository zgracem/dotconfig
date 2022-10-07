# dnsmasq -- enable local .test TLD

SHELL := /usr/local/bin/bash
GNU := /usr/local/opt/coreutils/libexec/gnubin
INSTALL := $(GNU)/install -D --compare --mode=0644 --backup=existing

.PHONY: dnsmasq/all
dnsmasq/all:
	sudo brew services restart dnsmasq

dnsmasq/all: /usr/local/etc/dnsmasq.d/000-dnsmasq.conf
/usr/local/etc/dnsmasq.d/000-dnsmasq.conf: dnsmasq.d/000-dnsmasq.conf
	${INSTALL} -- $< $@

dnsmasq/all: /usr/local/etc/dnsmasq.d/001-resolver.conf
/usr/local/etc/dnsmasq.d/001-resolver.conf: dnsmasq.d/001-resolver.conf
	${INSTALL} -- $< $@

dnsmasq/all: /etc/resolver/test
/etc/resolver/test: resolver/test
	sudo ${INSTALL} -- $< $@
