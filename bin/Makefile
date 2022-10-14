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
	$(INSTALL_PROGRAM) -- $< $@

$(bindir)/code: $(bindir)/code-wait
$(bindir)/code-wait: $(CURDIR)/code
	ln -sfv ./$(<F) $@

$(bindir)/pyjamas: | $(datadir)/npm/bin/json2cson
$(datadir)/npm/bin/json2cson: | $(datadir)/npm/lib/node_modules/cson
	npm install -g cson

PJ_GEMS = plist toml-rb
PJ_LIBS := $(addprefix -r,$(PJ_GEMS))
PJ_CACHE := $(XDG_CACHE_HOME)/dotfiles/.pyjamas-gems-installed
.PHONY: pyjamas/gems
pyjamas/gems: $(PJ_CACHE)
$(bindir)/pyjamas: | pyjamas/gems
$(PJ_CACHE): ../fish/packages/pyjamas/functions/pyjamas.fish
	ruby $(PJ_LIBS) -etrue 2>&1 || gem install $(PJ_GEMS) && touch $@

$(bindir)/manpdf: $(GIT_STAGING)/zgracem/manpdf/manpdf.sh | $(datarootdir)/doc/pdf
	$(INSTALL_PROGRAM) -- $< $@
$(datarootdir)/doc/pdf:
	mkdir -pv $@
TARGETS += $(bindir)/manpdf

install: $(TARGETS)

.PHONY: uninstall
uninstall:
	rm -fv $(TARGETS)
