.PHONY: all

.NOTPARALLEL:
GNUMAKEFLAGS = --output-sync
MAKEFLAGS = L # check symlinks' mtime and not their destinations'

CONFIG_SRC := $(HOME)/src/github.com/zgracem/dotconfig

HOME_FILES  =
HOME_FILES += ~/.hushlogin
HOME_FILES += ~/.bash_profile
HOME_FILES += ~/.profile
HOME_DIRS   =
HOME_DIRS  += ~/.config/sh
HOME_DIRS  += ~/.private
HOME_DIRS  += ~/.ssh

all: $(HOME_DIRS) $(HOME_FILES)
~/.hushlogin: # $(CONFIG_SRC)/bash/.hushlogin
	touch $@

~/.config/sh: $(CONFIG_SRC)/sh
~/.private: $(realpath $(dir $(CONFIG_SRC))/dotprivate)
~/.ssh: ~/.private/ssh | ~/.private

~/.bash_profile: $(CONFIG_SRC)/deck/.bash_profile
~/.profile: ~/.config/sh/.profile | ~/.config/sh

~/.config/sh ~/.private ~/.ssh ~/.bash_profile ~/.profile:
	ln -sf $< $@

CONFIG_FILES  =
CONFIG_FILES += ~/.config/locale.conf
CONFIG_FILES += ~/.config/user-dirs.conf
CONFIG_FILES += ~/.config/user-dirs.dirs
CONFIG_FILES += ~/.config/user-dirs.locale
CONFIG_DIRS   =
CONFIG_DIRS  += ~/.config/bin
CONFIG_DIRS  += ~/.config/btop
CONFIG_DIRS  += ~/.config/env.d
CONFIG_DIRS  += ~/.config/fastfetch
CONFIG_DIRS  += ~/.config/fish
CONFIG_DIRS  += ~/.config/homebrew
CONFIG_DIRS  += ~/.config/local/Alyx
CONFIG_DIRS  += ~/.config/micro
CONFIG_DIRS  += ~/.config/ripgrep
CONFIG_DIRS  += ~/.config/sh
CONFIG_DIRS  += ~/.config/tmux
CONFIG_DIRS  += ~/.config/wget

all: $(CONFIG_DIRS) $(CONFIG_FILES)
~/.config/%: $(CONFIG_SRC)/%
	ln -sf $< $@
~/.config/local/Alyx: | ~/.config/local
~/.config/local:
	mkdir -pv $@

DECK_FILES  =
DECK_FILES += ~/.config/mimeapps.list
DECK_FILES += ~/.xscreensaver

all: $(DECK_FILES)
~/.config/mimeapps.list: $(CONFIG_SRC)/deck/mimeapps.list
	ln -sf $< $@
~/.xscreensaver: $(CONFIG_SRC)/.xscreensaver
	cp -af $< $@
