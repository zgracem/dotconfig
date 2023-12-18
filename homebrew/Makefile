# ----------------------------------------------------------------------------
# Homebrew
# ----------------------------------------------------------------------------

include ../common.mk

# avoid shadowing HOMEBREW_REPOSITORY
HOMEBREW_REPO := $(shell $(XDG_CONFIG_HOME)/homebrew/install.sh --repo)

$(HOMEBREW_REPO)/README.md:
	DRY_RUN=false $(XDG_CONFIG_HOME)/homebrew/install.sh

BREWFILES  =
BREWFILES += brewfile/core
BREWFILES += brewfile/more
BREWFILES += brewfile/extra
CASKFILES  =
CASKFILES += caskfile/core
CASKFILES += caskfile/more
.PHONY: $(BREWFILES) $(CASKFILES)

$(BREWFILES): brewfile/%: bundle/%.Brewfile.lock.json
$(CASKFILES): caskfile/%: bundle/%.Caskfile.lock.json
bundle/%.lock.json: bundle/% | $(HOMEBREW_REPO)/README.md
	brew bundle --file=$<

.PHONY: brew/install cask/install
brew/install: $(BREWFILES)
cask/install: $(CASKFILES)

install: $(BREWFILES) $(CASKFILES)

LOCK_FILES  = $(patsubst brewfile/%,bundle/%.Brewfile.lock.json,$(BREWFILES))
LOCK_FILES += $(patsubst caskfile/%,bundle/%.Caskfile.lock.json,$(CASKFILES))
.PHONY: clean
clean:
	rm -fv $(LOCK_FILES)
