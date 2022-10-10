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

SHIM_TARGETS := $(addprefix $(bindir)/, $(SHIMS))

install: $(SHIM_TARGETS)
$(SHIM_TARGETS): $(bindir)/%: $(CURDIR)/%
	ln -sfv $(subst $(HOME),..,$<) $@

~/bin/code: ~/bin/code-wait
~/bin/code-wait: $(CURDIR)/code
	ln -sfv ./$(<F) $@

~/bin/pyjamas: | $(datadir)/npm/bin/json2cson
$(datadir)/npm/bin/json2cson:
	npm install -g cson

.PHONY: pyjamas/gems
~/bin/pyjamas: | pyjamas/gems
pyjamas/gems:
	@ruby -rplist -rtoml-rb -etrue -c >/dev/null 2>&1 \
	|| gem install plist toml-rb

.PHONY: uninstall
uninstall:
	rm -fv $(SHIM_TARGETS)
