HOSTNAME := $(shell /bin/hostname -f)
TEMPDIR := $(shell /usr/bin/mktemp -d -t dotfiles.XXXXXX)

XDG_CONFIG_HOME ?= ~/.config
XDG_DATA_HOME ?= ~/.local/share
XDG_CACHE_HOME ?= ~/var/cache

VPATH = .

include .make/shell-files.make
include .make/symlinks.make
include .make/user-agent.make

all:
	@echo Target ‘$@’ not implemented.
clean:
	@echo Target ‘$@’ not implemented.
