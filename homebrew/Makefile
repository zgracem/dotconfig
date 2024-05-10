# ----------------------------------------------------------------------------
# Homebrew
# ----------------------------------------------------------------------------

include ../common.mk

# avoid shadowing HOMEBREW_REPOSITORY
HOMEBREW_REPO := $(shell $(CURDIR)/install.sh --repo)

$(HOMEBREW_REPO)/README.md:
	DRY_RUN=false $(CURDIR)/install.sh

Brewfile.lock.json: Brewfile | $(HOMEBREW_REPO)/README.md
	brew bundle --file=$<
install: Brewfile.lock.json

.PHONY: clean
clean:
	rm -fv Brewfile.lock.json
