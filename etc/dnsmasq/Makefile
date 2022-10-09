# ----------------------------------------------------------------------------
# dnsmasq -- enable local .test TLD
# ----------------------------------------------------------------------------

.DEFAULT_GOAL = dnsmasq/all

include ../../common.mk

.PHONY: dnsmasq/all
dnsmasq/all: | /usr/local/sbin/dnsmasq

/usr/local/sbin/dnsmasq: | /usr/local/bin/brew
	brew install dnsmasq && sudo brew services restart dnsmasq

DNSMASQ_FILES =
DNSMASQ_FILES += /usr/local/etc/dnsmasq.d/000-dnsmasq.conf
/usr/local/etc/dnsmasq.d/000-dnsmasq.conf: dnsmasq.d/000-dnsmasq.conf
	$(INSTALL_DATA) -- $< $@

DNSMASQ_FILES += /usr/local/etc/dnsmasq.d/001-resolver.conf
/usr/local/etc/dnsmasq.d/001-resolver.conf: dnsmasq.d/001-resolver.conf
	$(INSTALL_DATA) -- $< $@

DNSMASQ_FILES += /etc/resolver/test
/etc/resolver/test: resolver/test
	sudo $(INSTALL_DATA) -- $< $@

dnsmasq/all: $(DNSMASQ_FILES)

.PHONY: uninstall
uninstall:
	sudo rm -fv -- $(DNSMASQ_FILES)
