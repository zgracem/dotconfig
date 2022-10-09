XDG_CONFIG_HOME ?= ~/.config
XDG_DATA_HOME ?= ~/.local/share
XDG_CACHE_HOME ?= ~/var/cache

ifeq ($(shell uname -s),Darwin)

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

GIT_STAGING := $(wildcard ~/src/github.com)
INSTALL := $(GNUBIN)/install -D --compare

/usr/local/bin/brew:
	cd $(XDG_CONFIG_HOME)/brew && $(MAKE) init
