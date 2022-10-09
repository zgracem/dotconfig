include ../common.mk

srcdir ?= $(CURDIR)
outdir := $(wildcard ~/Library/LaunchAgents)

.PHONY: setenv
setenv: $(outdir)/org.inescapable.setenv.plist
install: setenv

$(outdir)/%.plist: $(srcdir)/%.plist
	launchctl unload $@ 2>/dev/null
	$(INSTALL_DATA) --backup=existing -- $< $@
	launchctl load $@

$(srcdir)/%.plist: $(srcdir)/%.yaml
	pyjamas --out=plist $(realpath $<) >$(realpath $@)

.PHONY: uninstall
uninstall: $(outdir)/org.inescapable.setenv.plist
	launchctl unload $< 2>/dev/null && rm -fv $<
