# Clear implicit suffix rules
.SUFFIXES:

# Homebrew, `mkdir -p` aren't safe to run in parallel
.NOTPARALLEL:

MAKEFLAGS = Lr
# -L = check symlinks' mtime and not their destinations'
# -r = don't use implicit rules
GNUMAKEFLAGS = --output-sync

# XDG base directories
XDG_CONFIG_HOME ?= ~/.config
XDG_DATA_HOME ?= ~/.local/share
XDG_CACHE_HOME ?= ~/var/cache

# Other important directories
GIT_STAGING := $(wildcard ~/src/github.com)

# Use Homebrew tools on macOS
OS = $(shell uname -s)
ifeq ($(OS),Darwin)
ifeq ($(shell command -v brew),/usr/local/bin/brew)
SHELL := /usr/local/bin/bash
GNUBIN := /usr/local/opt/coreutils/libexec/gnubin
else
SHELL := /bin/bash
GNUBIN := /usr/bin
endif
else
SHELL := /bin/bash
GNUBIN := /usr/bin
endif

# Every Makefile should define the variable INSTALL, which is the basic command
# for installing a file into the system.
INSTALL := $(GNUBIN)/install

# Every Makefile should also define the variables INSTALL_PROGRAM and
# INSTALL_DATA. Then it should use those variables as the commands for actual
# installation, for executables and non-executables respectively.
INSTALL_PROGRAM := $(INSTALL) -D --compare
INSTALL_DATA := $(INSTALL) -D --compare -m 644

/usr/local/bin/brew:
	cd $(XDG_CONFIG_HOME)/brew && $(MAKE) init
