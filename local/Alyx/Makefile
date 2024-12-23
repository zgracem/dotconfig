.PHONY: all

.NOTPARALLEL:
GNUMAKEFLAGS = --output-sync
MAKEFLAGS = L # check symlinks' mtime and not their destinations'

CONFIG_SRC := $(HOME)/src/github.com/zgracem/dotconfig

HOME_FILES  =
HOME_FILES += ~/.hushlogin
HOME_FILES += ~/.bash_profile
HOME_FILES += ~/.bashrc
HOME_FILES += ~/.profile
HOME_DIRS   =
HOME_DIRS  += ~/.private

all: $(HOME_DIRS) $(HOME_FILES)
~/.hushlogin:
	touch $@
~/.bash_profile: $(CONFIG_SRC)/local/Alyx/.bash_profile
~/.bashrc: $(CONFIG_SRC)/bash/.bashrc
~/.profile: $(CONFIG_SRC)/sh/.profile

~/.private: $(realpath $(dir $(CONFIG_SRC))/dotprivate)

~/.bash_profile ~/.bashrc ~/.profile ~/.private:
	ln -sf $< $@

CONFIG_FILES  =
CONFIG_FILES += ~/.config/locale.conf
CONFIG_FILES += ~/.config/user-dirs.conf
CONFIG_FILES += ~/.config/user-dirs.dirs
CONFIG_FILES += ~/.config/user-dirs.locale
CONFIG_DIRS   =
CONFIG_DIRS  += ~/.config/bash
CONFIG_DIRS  += ~/.config/bin
CONFIG_DIRS  += ~/.config/btop
CONFIG_DIRS  += ~/.config/env.d
CONFIG_DIRS  += ~/.config/fastfetch
CONFIG_DIRS  += ~/.config/fish
CONFIG_DIRS  += ~/.config/homebrew
CONFIG_DIRS  += ~/.config/micro
CONFIG_DIRS  += ~/.config/ripgrep
CONFIG_DIRS  += ~/.config/sh
CONFIG_DIRS  += ~/.config/tmux
CONFIG_DIRS  += ~/.config/wget

all: $(CONFIG_DIRS) $(CONFIG_FILES)
~/.config/%: $(CONFIG_SRC)/%
	ln -sf $< $@

all: ~/.local/config
~/.local/config: ~/.config/local/Alyx | ~/.config/local
	ln -sf $< $@
~/.config/local:
	$(MKDIR) $@

DECK_FILES  =
DECK_FILES += ~/.config/mimeapps.list
DECK_FILES += ~/.xscreensaver

all: $(DECK_FILES)
~/.config/mimeapps.list: $(CONFIG_SRC)/local/Alyx/mimeapps.list
	ln -sf $< $@
~/.xscreensaver: $(CONFIG_SRC)/.xscreensaver
	cp -af $< $@
