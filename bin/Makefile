# ----------------------------------------------------------------------------
# Install files to ~/.local/bin
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
	$(LN) $(shell $(CURDIR)/relpath $< $(bindir)) $@

$(bindir):
	$(MKDIR) $(bindir)

install: $(TARGETS)

# ----------------------------------------------------------------------------

.PHONY: uninstall
uninstall:
	rm -fv $(TARGETS)
