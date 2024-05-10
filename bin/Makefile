# ----------------------------------------------------------------------------
# Install files to ~/bin
# ----------------------------------------------------------------------------

datarootdir := $(XDG_DATA_HOME)

include ../common.mk

SHIMS  =
SHIMS += pre-rg
SHIMS += relpath
SHIMS += tbcopy
SHIMS += trash
SHIMS += un1q
SHIMS += vsx

SHIM_TARGETS := $(addprefix $(bindir)/, $(SHIMS))
TARGETS := $(SHIM_TARGETS)

$(SHIM_TARGETS): $(bindir)/%: $(CURDIR)/%
	ln -sf $(shell $(CURDIR)/relpath $< $(bindir)) $@

install: $(TARGETS)

# fish completions

FISH_COMP_DIR = $(XDG_CONFIG_HOME)/fish/packages/zgm-completions/completions

$(FISH_COMP_DIR)/vsx.fish: $(CURDIR)/vsx
	$< completions >$@
install: $(FISH_COMP_DIR)/vsx.fish

# ----------------------------------------------------------------------------

.PHONY: uninstall
uninstall:
	rm -fv $(TARGETS)
