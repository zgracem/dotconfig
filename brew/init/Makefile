# ----------------------------------------------------------------------------
# Homebrew
# ----------------------------------------------------------------------------

include ../../common.mk

.NOTPARALLEL:

# avoid shadowing HOMEBREW_REPOSITORY
HOMEBREW_REPO := $(shell ${XDG_CONFIG_HOME}/bin/init/bootstrap-brew.sh --repo)

.PHONY: brew/install
brew/install: | brew/all cask/all

.PHONY: brew/init
brew/init: | $(HOMEBREW_REPO)/.git
$(HOMEBREW_REPO)/.git:
	DRY_RUN=true ${XDG_CONFIG_HOME}/bin/init/bootstrap-brew.sh

BREWFILES  =
BREWFILES += brewfile/core
BREWFILES += brewfile/more
BREWFILES += brewfile/extra
CASKFILES  =
CASKFILES += caskfile/core
CASKFILES += caskfile/more
.PHONY: $(BREWFILES) $(CASKFILES)

$(BREWFILES): brewfile/%: %.Brewfile.lock.json
$(CASKFILES): caskfile/%: %.Caskfile.lock.json
%.lock.json: % | brew/init
	brew bundle --file=$<

.PHONY: brew/core brew/all cask/core cask/all
brew/core: | brewfile/core
brew/all: | $(BREWFILES)
cask/core: | caskfile/core
cask/all: | $(CASKFILES)
