# ----------------------------------------------------------------------------
# dnsmasq: enable local .test TLD
# ----------------------------------------------------------------------------

prefix ?= /usr/local

include ../../common.mk

DNSMASQ_FILES =
DNSMASQ_FILES += $(sysconfdir)/dnsmasq.d/000-dnsmasq.conf
$(sysconfdir)/dnsmasq.d/000-dnsmasq.conf: dnsmasq.d/000-dnsmasq.conf
	$(INSTALL_DATA) -- $< $@

DNSMASQ_FILES += $(sysconfdir)/dnsmasq.d/001-resolver.conf
$(sysconfdir)/dnsmasq.d/001-resolver.conf: dnsmasq.d/001-resolver.conf
	$(INSTALL_DATA) -- $< $@

DNSMASQ_FILES += /etc/resolver/test
/etc/resolver/test: resolver/test
	sudo $(INSTALL_DATA) -- $< $@

install: $(DNSMASQ_FILES)

.PHONY: uninstall
uninstall:
	sudo rm -fv -- $(DNSMASQ_FILES)
