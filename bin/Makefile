# ----------------------------------------------------------------------------
# Install files to ~/bin
# ----------------------------------------------------------------------------

datarootdir := $(XDG_DATA_HOME)

include ../common.mk

SHIMS  =
SHIMS += airport
SHIMS += brew-env
SHIMS += code
SHIMS += git-cc
SHIMS += lsregister
SHIMS += PlistBuddy
SHIMS += pyjamas
SHIMS += trash
SHIMS += un1q
SHIMS += vsx

SHIM_TARGETS := $(addprefix $(bindir)/, $(SHIMS))
TARGETS := $(SHIM_TARGETS)

$(SHIM_TARGETS): $(bindir)/%: $(CURDIR)/%
	ln -sfv $(subst $(HOME),..,$<) $@

$(bindir)/code: $(bindir)/code-wait
$(bindir)/code-wait: $(CURDIR)/code
	ln -sfv ./$(<F) $@

$(bindir)/pyjamas: | $(datadir)/npm/bin/json2cson
$(datadir)/npm/bin/json2cson:
	npm install -g cson

.PHONY: pyjamas/gems
$(bindir)/pyjamas: | pyjamas/gems
pyjamas/gems:
	@ruby -rplist -rtoml-rb -etrue >/dev/null 2>&1 \
	|| gem install plist toml-rb

$(bindir)/manpdf: $(GIT_STAGING)/zgracem/manpdf/manpdf.sh | $(datarootdir)/doc/pdf
	ln -sfv $< $@
$(datarootdir)/doc/pdf:
	mkdir -pv $@
TARGETS += $(bindir)/manpdf

install: $(TARGETS)

.PHONY: uninstall
uninstall:
	rm -fv $(TARGETS)
