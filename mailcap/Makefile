# ----------------------------------------------------------------------------
# mailcap
# ----------------------------------------------------------------------------

include ../common.mk

install: $(datarootdir)/mailcap

$(datarootdir)/mailcap: mailcap
	$(INSTALL_DATA) -- $(realpath $<) $@
