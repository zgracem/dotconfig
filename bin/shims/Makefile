# ----------------------------------------------------------------------------
# Install files to ~/bin
# ----------------------------------------------------------------------------

GNU := /usr/local/opt/coreutils/libexec/gnubin
INSTALL := $(GNU)/install -D --compare --mode=0755
BINDIR := $(HOME)/bin

SHIMS  =
SHIMS += airport
SHIMS += brew-env
SHIMS += code
SHIMS += code-wait
SHIMS += lsregister
SHIMS += PlistBuddy
SHIMS += trash
SHIMS += vsx
EASY_SHIMS = $(filter-out code-wait, $(SHIMS))

.PHONY: bin/all
bin/all: $(addprefix $(BINDIR)/, $(SHIMS))
$(addprefix $(BINDIR)/, $(EASY_SHIMS)): $(BINDIR)/%: $(CURDIR)/%
	${INSTALL} -- $< $@

$(BINDIR)/code-wait: $(CURDIR)/code
	${GNU}/ln -sf ./$(notdir $<) $@

.PHONY: clean
clean:
	${GNU}/rm -fv $(addprefix $(BINDIR)/, $(SHIMS))
