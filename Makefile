HOSTNAME := $(shell hostname -f)
TEMPDIR := $(shell mktemp -d -t dotfiles.XXXXXX)

XDG_CONFIG_HOME ?= ~/.config
XDG_DATA_HOME ?= ~/.local/share
XDG_CACHE_HOME ?= ~/var/cache

VPATH = .

include .make/shell-files.makefile
include .make/ssh-config.makefile
include .make/symlinks.makefile
include .make/user-agent.makefile

all:
	@echo Target ‘$@’ not implemented.
clean:
	@echo Target ‘$@’ not implemented.
