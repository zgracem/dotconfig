# ----------------------------------------------------------------------------
# Install files to ~/bin
# ----------------------------------------------------------------------------

SHELL := /usr/local/bin/bash
GNU := /usr/local/opt/coreutils/libexec/gnubin
INSTALL := $(GNU)/install -D --compare --mode=0755
BINDIR := $(HOME)/bin

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

TARGETS := $(addprefix $(BINDIR)/, $(SHIMS))

.PHONY: bin/all
bin/all: $(TARGETS)
$(TARGETS): $(BINDIR)/%: $(CURDIR)/%
	${INSTALL} -- $< $@

$(BINDIR)/code: $(BINDIR)/code-wait
$(BINDIR)/code-wait: $(CURDIR)/code
	${GNU}/ln -sf ./$(notdir $<) $@

$(BINDIR)/pyjamas: | $(XDG_DATA_HOME)/npm/bin/json2cson
$(XDG_DATA_HOME)/npm/bin/json2cson:
	npm install -g cson

.PHONY: pyjamas/gems
$(BINDIR)/pyjamas: | pyjamas/gems
pyjamas/gems:
	@ruby -rplist -rtoml-rb -etrue -c >/dev/null 2>&1 \
	|| gem install plist toml-rb

.PHONY: clean
clean:
	${GNU}/rm -fv $(TARGETS)
