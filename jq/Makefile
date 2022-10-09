JQ_MODULES := $(wildcard $(CURDIR)/*.jq $(CURDIR)/*.json)
JQ_TARGETS := $(patsubst $(CURDIR)/%, $(XDG_DATA_HOME)/jq/%, $(JQ_MODULES))

include ../common.mk

.PHONY: jq/all
jq/all: $(JQ_TARGETS)

$(JQ_TARGETS): $(XDG_DATA_HOME)/jq/%: $(CURDIR)/%
	$(INSTALL_DATA) -- $< $@
