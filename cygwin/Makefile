datarootdir := $(XDG_DATA_HOME)

.PHONY: all
all:

include ../common.mk

# Packages you must install:
# - cmake
# - fish
# - gcc-core
# - jq
# - patch
# - unzip

export CYGWIN := winsymlinks:nativestrict
WINPROFILE := $(shell cygpath -au "$(USERPROFILE)")
DOWNLOADS := $(WINPROFILE)/Downloads

# ----------------------------------------------------------------------------
# Basic stuff
# ----------------------------------------------------------------------------

# Targets from ../Makefile that work on Cygwin
BASIC  =
BASIC += dircolors
BASIC += shellfiles
BASIC += ~/.stow-global-ignore

.PHONY: dircolors
.PHONY: shellfiles

.PHONY: basic
basic: $(BASIC)

$(BASIC):
	cd $(XDG_CONFIG_HOME) && $(MAKE) $@

all: $(BASIC)

# ----------------------------------------------------------------------------
# Config for GUI apps
# ----------------------------------------------------------------------------

.PHONY: appdata
# all: appdata
appdata:
	$(XDG_CONFIG_HOME)/libexec/init/cygwin.sh

# -- metapad -------------------------------------------------------------------

METAPAD_DIR := $(WINPROFILE)/Applications/metapad
.PHONY: metapad
all: metapad

metapad: | $(METAPAD_DIR)/metapad.exe
$(METAPAD_DIR)/metapad.exe: | $(DOWNLOADS)/metapad36.zip
	unzip -u -j -d $(@D) $< '*.exe'

$(DOWNLOADS)/metapad36.zip:
	cd $(DOWNLOADS) && curl -OJ https://liquidninja.com/metapad/downloads/$(<F)

metapad: $(METAPAD_DIR)/metapad.ini
$(METAPAD_DIR)/metapad.ini: $(XDG_CONFIG_HOME)/metapad/metapad.ini | $(METAPAD_DIR)
	$(INSTALL_DATA) -- $< $@

$(METAPAD_DIR):
	mkdir -pv $@

# -- NetHack -------------------------------------------------------------------

.PHONY: nethack
all: nethack
nethack: | $(WINPROFILE)/Nethack/.nethackrc
$(WINPROFILE)/Nethack/.nethackrc: $(XDG_CONFIG_HOME)/nethack/nethackrc_windows
	ln -sfv $< $@

# -- PuTTY ---------------------------------------------------------------------

.PHONY: putty
# all: putty
putty:
	cd $(XDG_CONFIG_HOME)/putty && $(MAKE)

# ----------------------------------------------------------------------------
# install files to ~/bin
# ----------------------------------------------------------------------------

SHIMS  =
SHIMS += git-cc
SHIMS += pyjamas
SHIMS += un1q
SHIMS += vsx

SHIM_TARGETS := $(addprefix $(bindir)/, $(SHIMS))

install: $(SHIM_TARGETS)
$(SHIM_TARGETS): | $(bindir)
$(bindir):
	mkdir -pv $@

$(SHIM_TARGETS): $(bindir)/%: $(XDG_CONFIG_HOME)/bin/%
	ln -sfv $(subst $(HOME),..,$<) $@
all: install

.PHONY: pyjamas/gems
$(bindir)/pyjamas: | pyjamas/gems
pyjamas/gems:
	@ruby -rplist -rtoml-rb -etrue >/dev/null 2>&1 \
	|| gem install plist toml-rb

.PHONY: uninstall
uninstall:
	rm -fv $(SHIM_TARGETS)
