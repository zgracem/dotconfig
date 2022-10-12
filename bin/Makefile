# ----------------------------------------------------------------------------
# Install files to ~/bin
# ----------------------------------------------------------------------------

include ../common.mk

SHIMS  =
SHIMS += airport
SHIMS += brew-env
SHIMS += code
SHIMS += git-cc
SHIMS += lockscreen
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

$(bindir)/code: $(bindir)/code-wait
$(bindir)/code-wait: $(CURDIR)/code
	ln -sfv ./$(<F) $@

$(CURDIR)/lockscreen: lockscreen.c
	clang -F /System/Library/PrivateFrameworks -framework login -o $@ $<

$(bindir)/pyjamas: | $(datadir)/npm/bin/json2cson
$(datadir)/npm/bin/json2cson:
	npm install -g cson

.PHONY: pyjamas/gems
$(bindir)/pyjamas: | pyjamas/gems
pyjamas/gems:
	@ruby -rplist -rtoml-rb -etrue >/dev/null 2>&1 \
	|| gem install plist toml-rb

.PHONY: uninstall
uninstall:
	rm -fv $(SHIM_TARGETS)
