XDG_CONFIG_HOME ?= ~/.config
XDG_DATA_HOME ?= ~/.local/share
XDG_CACHE_HOME ?= ~/var/cache

ifeq ($(shell uname -s),Darwin)
SHELL := /usr/local/bin/bash
GNUBIN := /usr/local/opt/coreutils/libexec/gnubin
else
SHELL := /bin/bash
GNUBIN := /usr/bin
endif

GIT_STAGING := $(wildcard ~/src/github.com)
INSTALL := $(GNUBIN)/install -D --compare
