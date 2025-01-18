include ../../common.mk

HOSTNAME   ?= Pomona

CONFIG_SRC := $(HOME)/src/github.com/zgracem/dotconfig

HOME_FILES  =
HOME_FILES += ~/.hushlogin
HOME_FILES += ~/.bash_profile
HOME_FILES += ~/.bashrc
HOME_FILES += ~/.profile
HOME_DIRS   =
HOME_DIRS  += ~/.private

.PHONY: all
all: $(HOME_DIRS) $(HOME_FILES)
~/.hushlogin:
	touch $@
~/.bash_profile: $(CONFIG_SRC)/local/$(HOSTNAME)/.bash_profile
~/.bashrc: $(CONFIG_SRC)/bash/.bashrc
~/.profile: $(CONFIG_SRC)/sh/.profile

~/.private: $(realpath $(dir $(CONFIG_SRC))/dotprivate)

~/.bash_profile ~/.bashrc ~/.profile ~/.private:
	$(LN) $< $@

CONFIG_FILES  =
CONFIG_FILES += ~/.config/locale.conf
CONFIG_FILES += ~/.config/user-dirs.conf
# CONFIG_FILES += ~/.config/user-dirs.dirs
# CONFIG_FILES += ~/.config/user-dirs.locale
CONFIG_DIRS   =
CONFIG_DIRS  += ~/.config/bash
CONFIG_DIRS  += ~/.config/bin
CONFIG_DIRS  += ~/.config/btop
CONFIG_DIRS  += ~/.config/env.d
CONFIG_DIRS  += ~/.config/fastfetch
CONFIG_DIRS  += ~/.config/fish
CONFIG_DIRS  += ~/.config/micro
CONFIG_DIRS  += ~/.config/ripgrep
CONFIG_DIRS  += ~/.config/sh
CONFIG_DIRS  += ~/.config/tmux
CONFIG_DIRS  += ~/.config/wget

all: $(CONFIG_DIRS) $(CONFIG_FILES)
~/.config/%: $(CONFIG_SRC)/%
	$(LN) $< $@

all: ~/.local/config
~/.local/config: ~/.config/local/$(HOSTNAME) | ~/.config/local
	$(LN) $< $@
~/.config/local:
	$(MKDIR) $@

PI_FILES  =
PI_FILES += ~/.config/fastfetch/config.jsonc

all: $(PI_FILES)
~/.config/fastfetch/config.jsonc: ~/.local/config/fastfetch/config.jsonc | ~/.local/config
	$(LN) $< $@
