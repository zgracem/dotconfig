include ../common.mk

GEM_TARGETS  =
GEM_TARGETS += gems.cson
GEM_TARGETS += gems.json
GEM_TARGETS += gems.plist
GEM_TARGETS += gems.toml

install: $(GEM_TARGETS)

$(GEM_TARGETS): gems.yaml

gems.cson:
	pyjamas --out=cson $< >$@

gems.json:
	pyjamas --out=json $< | prettier --parser json --print-width=40 >$@

gems.plist:
	pyjamas --out=plist $< >$@

gems.toml:
	pyjamas --out=toml $< >$@

gems.txt: gems.json
	{ printf '%s\n' ruby topaz; jq -r '.|keys|.[]' $<; } | shuf >$@

install: gems.txt
