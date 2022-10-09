.DEFAULT_GOAL = jq/all

include ../common.mk

srcdir ?= $(CURDIR)
outdir := $(datadir)/jq

JQ_MODULES := $(wildcard $(srcdir)/*.jq $(srcdir)/*.json)
JQ_TARGETS := $(patsubst $(srcdir)/%, $(outdir)/%, $(JQ_MODULES))

.PHONY: jq/all
jq/all: $(JQ_TARGETS)

$(JQ_TARGETS): $(outdir)/%: $(srcdir)/%
	$(INSTALL_DATA) -- $< $@

.PHONY: uninstall
uninstall:
	rm -fv $(JQ_TARGETS)
