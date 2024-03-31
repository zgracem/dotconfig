# ----------------------------------------------------------------------------
# Install LaunchAgents
# ----------------------------------------------------------------------------

srcdir ?= $(CURDIR)
outdir := $(wildcard ~/Library/LaunchAgents)

.PHONY: build
build: $(addsuffix .plist,$(basename $(wildcard $(srcdir)/*.yaml)))

include ../common.mk

.PHONY: install
install: $(outdir)/pink.phosphor.setenv.plist

$(outdir)/%.plist: $(srcdir)/%.plist
	launchctl unload $@ 2>/dev/null
	$(INSTALL_DATA) --backup=existing -- $< $@
	launchctl load $@

$(srcdir)/%.plist: $(srcdir)/%.yaml
	pyjamas --in=yaml --out=plist $(realpath $<) >$(realpath $@)

.PHONY: uninstall
uninstall: $(outdir)/pink.phosphor.setenv.plist
	launchctl unload $< 2>/dev/null && rm -fv $<
