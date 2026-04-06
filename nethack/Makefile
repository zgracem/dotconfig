prefix ?= /usr/local

include ../common.mk

$(prefix)/opt/nethack/libexec/sysconf: nethack_sysconf.patch
	patch --input $< $@

install: $(prefix)/opt/nethack/libexec/sysconf
