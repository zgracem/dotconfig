JQ_MODULES := $(wildcard $(CURDIR)/*.jq $(CURDIR)/*.json)
JQ_TARGETS := $(patsubst $(CURDIR)/%, $(XDG_DATA_HOME)/jq/%, $(JQ_MODULES))

GNU := /usr/local/opt/coreutils/libexec/gnubin
INSTALL:= ${GNU}/install -D --mode=0644 --preserve-timestamps

.PHONY: jq/all
jq/all: $(JQ_TARGETS)

$(JQ_TARGETS): $(XDG_DATA_HOME)/jq/%: $(CURDIR)/%
	${INSTALL} -- $< $@
