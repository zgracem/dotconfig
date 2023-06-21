# ----------------------------------------------------------------------------
# Install files to ~/bin
# ----------------------------------------------------------------------------

datarootdir := $(XDG_DATA_HOME)

include ../common.mk

SHIMS  =
SHIMS += airport
SHIMS += brew-env
SHIMS += centre
SHIMS += code
SHIMS += git-cc
SHIMS += lsregister
SHIMS += manpdf
SHIMS += PlistBuddy
SHIMS += pyjamas
SHIMS += right
SHIMS += squirrel
SHIMS += tbcopy
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

$(bindir)/vs: ~/VS/www/vsdotcom/bin/vs.fish
	ln -sfv $(subst $(HOME),..,$<) $@
TARGETS += $(bindir)/vs

install: $(TARGETS)

# fish completions

$(XDG_CONFIG_HOME)/fish/completions/vs.fish: $(bindir)/vs
	$< complete print >$@
install: $(XDG_CONFIG_HOME)/fish/completions/vs.fish

$(XDG_CONFIG_HOME)/fish/completions/vsx.fish: $(CURDIR)/vsx
	$< completions >$@
install: $(XDG_CONFIG_HOME)/fish/completions/vsx.fish

# ----------------------------------------------------------------------------

.PHONY: uninstall
uninstall:
	rm -fv $(TARGETS)
