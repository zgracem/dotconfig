# Cyme looks for its JSON config file in `~/Library/Application Support` instead
# of $XDG_CONFIG_HOME, which is annoying but easy to fix.

include ../common.mk

# Makefiles don't support paths with spaces in them, so fall back to the
# `~/Library/AppSupport` symbolic link that should already exist.
APP_SUPPORT = $(HOME)/Library/AppSupport

$(APP_SUPPORT)/cyme/cyme.json: $(CURDIR)/cyme.json | $(APP_SUPPORT)/cyme
	$(LN) $< $@

$(APP_SUPPORT)/cyme:
	test -L $(APP_SUPPORT) && $(MKDIR) $@

install: $(APP_SUPPORT)/cyme/cyme.json
