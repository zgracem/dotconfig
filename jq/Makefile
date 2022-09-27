JQ_MODULES := $(wildcard $(CURDIR)/*.jq $(CURDIR)/*.json)
JQ_TARGETS := $(patsubst $(CURDIR)/%, $(HOME)/.jq/%, $(JQ_MODULES))

GNU := /usr/local/opt/coreutils/libexec/gnubin
INSTALL:= ${GNU}/install --mode=0644 --preserve-timestamps

.PHONY: jq/all
jq/all: $(JQ_TARGETS)

$(JQ_TARGETS): $(HOME)/.jq/%: $(CURDIR)/%
	${INSTALL} -- $< $@
