# ----------------------------------------------------------------------------
# Install files to ~/bin
# ----------------------------------------------------------------------------

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

TARGETS := $(addprefix $(wildcard ~/bin/), $(SHIMS))

.PHONY: bin/all
bin/all: $(TARGETS)
$(TARGETS): $(wildcard ~/bin)/%: $(CURDIR)/%
	${INSTALL} -- $< $@

~/bin/code: ~/bin/code-wait
~/bin/code-wait: $(CURDIR)/code
	${GNUBIN}/ln -sf ./$(notdir $<) $@

~/bin/pyjamas: | $(XDG_DATA_HOME)/npm/bin/json2cson
$(XDG_DATA_HOME)/npm/bin/json2cson:
	npm install -g cson

.PHONY: pyjamas/gems
~/bin/pyjamas: | pyjamas/gems
pyjamas/gems:
	@ruby -rplist -rtoml-rb -etrue -c >/dev/null 2>&1 \
	|| gem install plist toml-rb

.PHONY: clean
clean:
	${GNUBIN}/rm -fv $(TARGETS)
