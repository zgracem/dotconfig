# ----------------------------------------------------------------------------
# custom sudoers(5) config
# ----------------------------------------------------------------------------

include ../../common.mk

install: /etc/sudoers.d/sudoer_zozo

/etc/sudoers.d/%: %
	sudo $(INSTALL_DATA) -- $< $@
