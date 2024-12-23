prefix := $(wildcard ~/opt)
datarootdir := $(prefix)/share

include ../common.mk

STOW_DIR := $(wildcard ~/opt/stow)
srcdir := $(STOW_DIR)/.staging
STOW := cd $(STOW_DIR) && stow

# create config symlink in $HOME
~/.stow-global-ignore: .stow-global-ignore
	ln -sfv .config/$< $@
install: ~/.stow-global-ignore

PACKAGES  =
PACKAGES += brightness
PACKAGES += cronic
PACKAGES += css3FontConverter
PACKAGES += dayone2
PACKAGES += hunspell
PACKAGES += markdown
PACKAGES += ocr-cli
PACKAGES += tremc
PACKAGES += words

.PHONY: $(PACKAGES)
install: $(PACKAGES)

# -- brightness utility --------------------------------------------------------

brightness: $(bindir)/brightness

$(bindir)/brightness: $(STOW_DIR)/brightness/bin/brightness
	$(STOW) $(@F)

$(STOW_DIR)/brightness/bin/brightness: | $(GIT_STAGING)/nriley/brightness
	cd $| && $(MAKE) && $(MAKE) prefix=$(STOW_DIR)/brightness install && $(MAKE) clean

$(GIT_STAGING)/nriley/brightness:
	cd $(srcdir) && git clone git@github.com:nriley/brightness.git $@

# -- cronic --------------------------------------------------------------------

cronic: $(bindir)/cronic

$(bindir)/cronic: $(STOW_DIR)/cronic-v3/bin/cronic
	$(STOW) $(@F)

$(STOW_DIR)/cronic-v3/bin/cronic: $(srcdir)/cronic
	$(INSTALL_PROGRAM) -- $< $@

$(srcdir)/cronic:
	cd $(@D) && wget -q https://habilis.net/cronic/cronic

# -- css3FontConverter ---------------------------------------------------------

css3FontConverter: $(bindir)/convertFonts.sh

$(bindir)/convertFonts.sh: $(STOW_DIR)/css3FontConverter/bin/convertFonts.sh
	$(STOW) $(@F)

$(STOW_DIR)/css3FontConverter/bin/convertFonts.sh: $(GIT_STAGING)/zoltan-dulac/css3FontConverter/convertFonts.sh
	ln -sfv $< $@

$(STOW_DIR)/css3FontConverter/bin/convertFonts.sh: | $(GIT_STAGING)/zoltan-dulac/css3FontConverter
$(GIT_STAGING)/zoltan-dulac/css3FontConverter:
	cd $(GIT_STAGING) && git clone git@github.com:zoltan-dulac/css3FontConverter.git $@

# -- dayone2 -------------------------------------------------------------------

dayone2: $(bindir)/dayone2

$(bindir)/dayone2: $(STOW_DIR)/dayone2/bin/dayone2
	$(STOW) $(@F)

$(STOW_DIR)/dayone2/bin/dayone2: ~/Applications/DayOne.app/Contents/Resources/dayone2
	gzcat -v $^ >$@ && chmod -v u+x $@

~/Applications/DayOne.app/Contents/Resources/dayone2: ~/Applications/DayOne.app
~/Applications/DayOne.app:
	ln -sf "/Applications/Day One.app" $(HOME)/Applications/DayOne.app

# -- hunspell (for Sublime Merge) ----------------------------------------------

HUNSPELL_VERSION ?= 2020.12.07
LANG = en_CA

hunspell: $(datadir)/myspell

$(datadir)/myspell: $(STOW_DIR)/hunspell-$(LANG)/share/myspell/$(LANG).dic
	$(STOW) $(@F)

$(STOW_DIR)/hunspell-$(LANG)/share/myspell/$(LANG).dic: $(srcdir)/hunspell-$(LANG)-$(HUNSPELL_VERSION).zip
	unzip -u -j -d $(@D) $< && touch -r $< $@

$(srcdir)/hunspell-$(LANG)-$(HUNSPELL_VERSION).zip:
	cd $(@D) && wget -q http://downloads.sourceforge.net/wordlist/$(@F)

# -- Markdown ------------------------------------------------------------------

markdown: $(bindir)/Markdown.pl

$(bindir)/Markdown.pl: $(STOW_DIR)/markdown/bin/Markdown.pl
	$(STOW) markdown

$(STOW_DIR)/markdown/bin/Markdown.pl: $(srcdir)/Markdown.pl
	$(INSTALL_PROGRAM) -- $< $@

$(srcdir)/Markdown.pl: $(srcdir)/Markdown_1.0.1.zip
	unzip -u -j -d $(@D) $< '*.pl' && touch -r $< $@

$(srcdir)/Markdown_1.0.1.zip:
	cd $(srcdir) && wget -q https://daringfireball.net/projects/downloads/Markdown_1.0.1.zip

# -- command line OCR-----------------------------------------------------------

ocr-cli: $(bindir)/ocr-cli

$(bindir)/ocr-cli: $(STOW_DIR)/ocr-cli/bin/ocr-cli
	$(STOW) $(@F)

$(STOW_DIR)/ocr-cli/bin/ocr-cli: $(GIT_STAGING)/latorante/cli-macos-ocr/.build/release/ocr-cli
	$(INSTALL_PROGRAM) -- $< $@

$(GIT_STAGING)/latorante/cli-macos-ocr/.build/release/ocr-cli:
	cd $(GIT_STAGING)/latorante/cli-macos-ocr && swift build

# -- tremc ---------------------------------------------------------------------

tremc: $(bindir)/tremc

$(bindir)/tremc: $(STOW_DIR)/tremc/bin/tremc
	$(STOW) $(@F)

$(STOW_DIR)/tremc/bin/tremc: | $(GIT_STAGING)/tremc/tremc
	cd $| && $(MAKE) DESTDIR=$(STOW_DIR) PREFIX=/tremc install

$(GIT_STAGING)/tremc/tremc:
	cd $(srcdir) && git clone git@github.com:tremc/tremc.git $@

# -- share/words ---------------------------------------------------------------

words: $(datadir)/dict/words

$(datadir)/dict/words: $(STOW_DIR)/words/share/dict/words
	$(STOW) --delete $(@F) && stow $(@F)

DICTS = connectives propernames web2 web2a
DICT_FILES = $(addprefix /usr/share/dict/,$(DICTS))

$(STOW_DIR)/words/share/dict/words: $(DICT_FILES) | $(STOW_DIR)/words/share/dict
	cat $^ | sort -u >$@

$(STOW_DIR)/words/share/dict:
	$(MKDIR) $@
