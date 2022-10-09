.DEFAULT_GOAL = launchd/all

include ../common.mk

srcdir ?= $(CURDIR)
outdir := $(wildcard ~/Library/LaunchAgents)

.PHONY: launchd/all
launchd/all: $(outdir)/org.inescapable.setenv.plist

$(outdir)/%.plist: $(srcdir)/%.plist
	launchctl unload $@ 2>/dev/null
	$(INSTALL_DATA) --backup=existing -- $< $@
	launchctl load $@

$(srcdir)/%.plist: $(srcdir)/%.yaml
	pyjamas --out=plist $(realpath $<) >$(realpath $@)
