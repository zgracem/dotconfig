# ----------------------------------------------------------------------------
# Homebrew
# ----------------------------------------------------------------------------

include ../common.mk

# avoid shadowing HOMEBREW_REPOSITORY
HOMEBREW_REPO := $(shell $(XDG_CONFIG_HOME)/homebrew/install.sh --repo)

$(HOMEBREW_REPO)/README.md:
	DRY_RUN=false $(XDG_CONFIG_HOME)/homebrew/install.sh

BREWFILES  =
BREWFILES += brew/core
BREWFILES += brew/more
BREWFILES += brew/extra
CASKFILES  =
CASKFILES += cask/core
CASKFILES += cask/more
.PHONY: $(BREWFILES) $(CASKFILES)

$(BREWFILES): brew/%: bundle/%.Brewfile.lock.json
$(CASKFILES): cask/%: bundle/%.Caskfile.lock.json
bundle/%.lock.json: bundle/% | $(HOMEBREW_REPO)/README.md
	brew bundle --file=$<

.PHONY: brew/install cask/install
brew/install: $(BREWFILES)
cask/install: $(CASKFILES)
install: brew/install cask/install

LOCK_FILES  = $(patsubst brew/%,bundle/%.Brewfile.lock.json,$(BREWFILES))
LOCK_FILES += $(patsubst cask/%,bundle/%.Caskfile.lock.json,$(CASKFILES))
.PHONY: clean
clean:
	rm -fv $(LOCK_FILES)
