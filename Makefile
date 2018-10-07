HOSTNAME := $(shell hostname -f)
TEMPDIR := $(shell mktemp -d -t dotfiles.XXXXXX)

XDG_CONFIG_HOME ?= ~/.config
XDG_DATA_HOME ?= ~/.local/share
XDG_CACHE_HOME ?= ~/var/cache

VPATH = .

include .make/shell-files.mkfile
include .make/ssh-config.mkfile
include .make/symlinks.mkfile
include .make/user-agent.mkfile

all:
	@echo Target ‘$@’ not implemented.
clean:
	@echo Target ‘$@’ not implemented.
