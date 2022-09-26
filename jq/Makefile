GNU := /usr/local/opt/coreutils/libexec/gnubin
JQ_MODULES := $(wildcard $(CURDIR)/*.jq $(CURDIR)/*.json)
JQ_TARGETS := $(patsubst $(CURDIR)/%, $(HOME)/.jq/%, $(JQ_MODULES))

.PHONY: all
all: $(JQ_TARGETS)

$(JQ_TARGETS): $(HOME)/.jq/%: $(CURDIR)/%
	${GNU}/install --mode=0644 --preserve-timestamps -- $< $@
