# ----------------------------------------------------------------------------
# Install files to ~/bin
# ----------------------------------------------------------------------------

datarootdir := $(XDG_DATA_HOME)

include ../common.mk

SHIMS  =
SHIMS += airport
SHIMS += brew-env
SHIMS += code
SHIMS += git-browse
SHIMS += git-cc
SHIMS += lsregister
SHIMS += manpdf
SHIMS += PlistBuddy
SHIMS += pre-rg
SHIMS += reldate
SHIMS += relpath
SHIMS += rot13
SHIMS += squirrel
SHIMS += tbcopy
SHIMS += trash
SHIMS += un1q
SHIMS += vsx

SHIM_TARGETS := $(addprefix $(bindir)/, $(SHIMS))
TARGETS := $(SHIM_TARGETS)

$(SHIM_TARGETS): $(bindir)/%: $(CURDIR)/%
	ln -sf $(shell $(CURDIR)/relpath $< $(bindir)) $@

$(bindir)/code: $(bindir)/code-wait
$(bindir)/code-wait: $(CURDIR)/code
	ln -sf ./$(<F) $@

$(bindir)/vs: ~/VS/www/vsdotcom/bin/vs.fish
	ln -sfv $(subst $(HOME),..,$<) $@
TARGETS += $(bindir)/vs

install: $(TARGETS)

# fish completions

FISH_COMP_DIR = $(XDG_CONFIG_HOME)/fish/packages/zgm-completions/completions
$(FISH_COMP_DIR)/vs.fish: $(bindir)/vs
	$< complete print >$@
install: $(FISH_COMP_DIR)/vs.fish

$(FISH_COMP_DIR)/vsx.fish: $(CURDIR)/vsx
	$< completions >$@
install: $(FISH_COMP_DIR)/vsx.fish

# ----------------------------------------------------------------------------

.PHONY: uninstall
uninstall:
	rm -fv $(TARGETS)
