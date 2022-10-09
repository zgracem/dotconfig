SOURCE_DIR := $(CURDIR)
DEST_DIR := $(wildcard ~/Library/LaunchAgents)

include ../common.mk

.PHONY: setenv/all
setenv/all: $(DEST_DIR)/org.inescapable.setenv.plist

$(DEST_DIR)/%.plist: $(SOURCE_DIR)/%.plist
	launchctl unload $@ 2>/dev/null
	$(INSTALL_DATA) --backup=existing -- $< $@
	launchctl load $@

$(SOURCE_DIR)/%.plist: $(SOURCE_DIR)/%.yaml
	pyjamas --out=plist $(realpath $<) >$(realpath $@)
