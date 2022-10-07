SOURCE_DIR := $(CURDIR)
DEST_DIR := $(wildcard ~/Library/LaunchAgents)

include ../common.mk

.PHONY: setenv/all
setenv/all: $(DEST_DIR)/org.inescapable.setenv.plist

$(DEST_DIR)/%.plist: $(SOURCE_DIR)/%.plist
	launchctl unload $@ 2>/dev/null
	${INSTALL} --backup=existing --mode=0644 -- $< $@
	launchctl load $@

$(SOURCE_DIR)/%.plist: $(SOURCE_DIR)/%.yaml
	pyjamas --out=plist $(realpath $<) >$(realpath $@)
