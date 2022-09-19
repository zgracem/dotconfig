# This file is meant to be called by the wrapper script at ../bin/stow-install.

SHELL = /usr/local/bin/bash
STOW_DIR := $(HOME)/opt/stow
STAGING := $(STOW_DIR)/.staging

# ----------------------------------------------------------------------------
# Aliases
# ----------------------------------------------------------------------------

# `make` with no arguments executes the first rule in the file.
default:
	@echo Target ‘$@’ not implemented.

# Phony targets that we want to `make <alias>` anyway:
.PHONY: default cronic dayone2 hunspell markdown words

# Map aliases to targets
cronic: $(STOW_DIR)/cronic-v3/bin/cronic
dayone2: $(STOW_DIR)/dayone2/bin/dayone2
hunspell: $(STOW_DIR)/hunspell-en_CA/share/myspell/en_CA.dic
markdown: $(STOW_DIR)/markdown/bin/Markdown.pl
words: $(STOW_DIR)/words/share/dict/words

# ----------------------------------------------------------------------------
# Targets' prerequisites, and recipes
# ----------------------------------------------------------------------------

# ~/opt/bin/cronic
$(STOW_DIR)/cronic-v3/bin/cronic: $(STAGING)/cronic
	install -C -D -p -- $< $@

$(STAGING)/cronic:
	cd $(STAGING) && wget -q https://habilis.net/cronic/cronic

# ~/opt/bin/dayone2
# Requires existing symlink from /Applications/Day\ One.app -> ~/Applications/DayOne.app
$(STOW_DIR)/dayone2/bin/dayone2: $(HOME)/Applications/DayOne.app/Contents/Resources/dayone2
	gzcat -v $^ >$@ && chmod -v u+x $@

# ~/opt/share/myspell
HUNSPELL_VERSION ?= 2020.12.07
$(STOW_DIR)/hunspell-en_CA/share/myspell/en_CA.dic: $(STAGING)/hunspell-en_CA-$(HUNSPELL_VERSION).zip
	unzip -u -j -d $(dir $@) $< && touch -r $< $@

$(STAGING)/hunspell-en_CA-$(HUNSPELL_VERSION).zip:
	cd $(STAGING) && wget -q http://downloads.sourceforge.net/wordlist/$(@F)

# ~/opt/bin/Markdown.pl
$(STOW_DIR)/markdown/bin/Markdown.pl: $(STAGING)/Markdown.pl
	install -C -D -p -- $< $@

$(STAGING)/Markdown.pl: $(STAGING)/Markdown_1.0.1.zip
	unzip -u -j -d $(dir $@) $< '*.pl' && touch -r $< $@

$(STAGING)/Markdown_1.0.1.zip:
	cd $(STAGING) && wget -q https://daringfireball.net/projects/downloads/Markdown_1.0.1.zip

# ~/opt/share/dict/words
$(STOW_DIR)/words/share/dict/words: /usr/share/dict/connectives /usr/share/dict/propernames /usr/share/dict/web2 /usr/share/dict/web2a | $(STOW_DIR)/words/share/dict
	cat $^ | sort | uniq >$@

$(STOW_DIR)/words/share/dict:
	mkdir -p $@
