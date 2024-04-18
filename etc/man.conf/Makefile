# ----------------------------------------------------------------------------
# Install files to /etc and /usr/local/etc
# ----------------------------------------------------------------------------

include ../../common.mk

# ----------------------------------------------------------------------------
# custom man.conf(5)

install: /etc/man.conf

/etc/man.conf: $(CURDIR)/man.conf
	sudo $(INSTALL_DATA) --backup=existing -- $< $@
