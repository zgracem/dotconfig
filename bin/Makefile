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

SHIM_TARGETS := $(addprefix $(bindir)/, $(SHIMS))
TARGETS := $(SHIM_TARGETS)

$(SHIM_TARGETS): $(bindir)/%: $(CURDIR)/%
	ln -sf $(shell $(CURDIR)/relpath $< $(bindir)) $@

install: $(TARGETS)

# ----------------------------------------------------------------------------

.PHONY: uninstall
uninstall:
	rm -fv $(TARGETS)
