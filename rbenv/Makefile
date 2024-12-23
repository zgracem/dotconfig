# ----------------------------------------------------------------------------
# rbenv: create dirs and files
# ----------------------------------------------------------------------------

include ../common.mk

install: $(datadir)/rbenv/default-gems | $(datadir)/rbenv/version

$(datadir)/rbenv/default-gems: default-gems | $(datadir)/rbenv
	$(INSTALL_DATA) -- $(realpath $<) $@

$(datadir)/rbenv/version: | $(datadir)/rbenv/versions
	rbenv global system

$(datadir)/rbenv $(datadir)/rbenv/versions:
	$(MKDIR) $@
