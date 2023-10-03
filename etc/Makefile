# ----------------------------------------------------------------------------
# Install files to /etc and /usr/local/etc
# ----------------------------------------------------------------------------

include ../common.mk

# ----------------------------------------------------------------------------
# custom man.conf(5)

install: /etc/man.conf

/etc/man.conf: man.conf
	sudo $(INSTALL_DATA) --backup=existing -- $< $@

# ----------------------------------------------------------------------------
# fix console spam

RULES_FILE := /etc/emond.d/rules/SampleRules.plist
install: $(RULES_FILE)

$(RULES_FILE):
	sudo /usr/libexec/PlistBuddy -c "Set 0:enabled true" $@

.PHONY: emond/uninstall
emond/uninstall:
	sudo /usr/libexec/PlistBuddy -c "Set 0:enabled false" $(RULES_FILE)
