# ----------------------------------------------------------------------------
# Install files to ~/bin
# ----------------------------------------------------------------------------

include ../common.mk

SHIMS  =
SHIMS += confupdate
SHIMS += pre-rg
SHIMS += relpath
SHIMS += tbcopy
SHIMS += trash
SHIMS += un1q

SHIM_TARGETS := $(addprefix $(bindir)/, $(SHIMS))
TARGETS := $(SHIM_TARGETS)

$(SHIM_TARGETS): $(bindir)/%: $(CURDIR)/% | $(bindir)
	ln -sf $(shell $(CURDIR)/relpath $< $(bindir)) $@

$(bindir):
	mkdir -p $(bindir)

install: $(TARGETS)

# ----------------------------------------------------------------------------

.PHONY: uninstall
uninstall:
	rm -fv $(TARGETS)
