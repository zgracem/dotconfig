.PHONY: all

.NOTPARALLEL:
GNUMAKEFLAGS = --output-sync
MAKEFLAGS = Lr
# -L = check symlinks' mtime and not their destinations'
# -r = don't use implicit rules

CONFIG_SRC := $(HOME)/src/github.com/zgracem/dotconfig

DECK_FILES  =
DECK_FILES += ~/.config/mimeapps.list
DECK_FILES += ~/.xscreensaver

all: $(DECK_FILES)
~/.config/mimeapps.list: $(CONFIG_SRC)/deck/mimeapps.list
	ln -sf $< $@
~/.xscreensaver: $(CONFIG_SRC)/.xscreensaver
	cp -af $< $@
