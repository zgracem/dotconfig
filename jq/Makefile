include ../common.mk

srcdir ?= $(CURDIR)
outdir := $(datadir)/jq

JQ_MODULES := $(wildcard $(srcdir)/*.jq $(srcdir)/*.json)
JQ_TARGETS := $(patsubst $(srcdir)/%, $(outdir)/%, $(JQ_MODULES))

install: $(JQ_TARGETS)

$(JQ_TARGETS): $(outdir)/%: $(srcdir)/%
	$(INSTALL_DATA) -- $< $@

.PHONY: uninstall
uninstall:
	rm -fv $(JQ_TARGETS)
