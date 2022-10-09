# ----------------------------------------------------------------------------
# Install files to ~/bin
# ----------------------------------------------------------------------------

.DEFAULT_GOAL := bin/all

include ../common.mk

SHIMS  =
SHIMS += airport
SHIMS += brew-env
SHIMS += code
SHIMS += lsregister
SHIMS += PlistBuddy
SHIMS += pyjamas
SHIMS += trash
SHIMS += un1q
SHIMS += vsx

TARGETS := $(addprefix $(bindir)/, $(SHIMS))

.PHONY: bin/all
bin/all: $(TARGETS)
$(TARGETS): $(bindir)/%: $(CURDIR)/%
	ln -sfv $(subst $(HOME),..,$<) $@

~/bin/code: ~/bin/code-wait
~/bin/code-wait: $(CURDIR)/code
	ln -sfv ./$(notdir $<) $@

~/bin/pyjamas: | $(datadir)/npm/bin/json2cson
$(datadir)/npm/bin/json2cson:
	npm install -g cson

.PHONY: pyjamas/gems
~/bin/pyjamas: | pyjamas/gems
pyjamas/gems:
	@ruby -rplist -rtoml-rb -etrue -c >/dev/null 2>&1 \
	|| gem install plist toml-rb

.PHONY: clean
clean:
	rm -fv $(TARGETS)
