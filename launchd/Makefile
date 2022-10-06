SOURCE_DIR := $(CURDIR)
DEST_DIR := $(HOME)/Library/LaunchAgents

SHELL := /usr/local/bin/bash
GNU := /usr/local/opt/coreutils/libexec/gnubin
INSTALL := $(GNU)/install --compare --mode=0644 --backup=existing --preserve-timestamps

.PHONY: setenv/all
setenv/all: $(DEST_DIR)/org.inescapable.setenv.plist

$(DEST_DIR)/%.plist: $(SOURCE_DIR)/%.plist
	launchctl unload $@ 2>/dev/null
	${INSTALL} -- $< $@
	launchctl load $@

$(SOURCE_DIR)/%.plist: $(SOURCE_DIR)/%.yaml
	ruby -rplist -ryaml -e'puts YAML.safe_load(File.read("$(realpath $<)")).to_plist' >$(realpath $@)
