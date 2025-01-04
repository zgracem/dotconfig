include ../common.mk

# create config symlink in $HOME
~/.stow-global-ignore: .stow-global-ignore
	ln -sfv .config/stow/$< $@
install: ~/.stow-global-ignore

PACKAGES  =
PACKAGES += brightness
PACKAGES += cronic
PACKAGES += css3FontConverter
PACKAGES += hunspell
PACKAGES += ocr-cli
PACKAGES += words

.PHONY: $(PACKAGES)
install: $(PACKAGES)

# -- brightness utility --------------------------------------------------------

brightness: $(bindir)/brightness

$(bindir)/brightness: | $(GIT_STAGING)/nriley/brightness
	cd $| && $(MAKE) && $(MAKE) prefix=$(abspath $(wildcard $(XDG_DATA_HOME)/..)) install && $(MAKE) clean

$(GIT_STAGING)/nriley/brightness:
	cd $(GIT_STAGING) && git clone git@github.com:nriley/brightness.git $@

# -- cronic --------------------------------------------------------------------

cronic: $(bindir)/cronic

$(bindir)/cronic:
	cd $(@D) && wget -q https://habilis.net/cronic/cronic

# -- css3FontConverter ---------------------------------------------------------

css3FontConverter: $(bindir)/convertFonts.sh

$(bindir)/convertFonts.sh: $(GIT_STAGING)/zoltan-dulac/css3FontConverter/convertFonts.sh
	ln -sfv $< $@

$(GIT_STAGING)/zoltan-dulac/css3FontConverter/convertFonts.sh: | $(GIT_STAGING)/zoltan-dulac/css3FontConverter
$(GIT_STAGING)/zoltan-dulac/css3FontConverter:
	cd $(GIT_STAGING) && git clone git@github.com:zoltan-dulac/css3FontConverter.git $@

# -- hunspell (for Sublime Merge) ----------------------------------------------

HUNSPELL_VERSION ?= 2020.12.07
LANG = en_CA

hunspell: $(datadir)/myspell/$(LANG).dic

$(datadir)/myspell/$(LANG).dic: $(HOME)/Downloads/hunspell-$(LANG)-$(HUNSPELL_VERSION).zip
	unzip -u -j -d $(@D) $< && touch -r $< $@

$(HOME)/Downloads/hunspell-$(LANG)-$(HUNSPELL_VERSION).zip:
	cd $(@D) && wget -q http://downloads.sourceforge.net/wordlist/$(@F)

# -- command line OCR-----------------------------------------------------------

ocr-cli: $(bindir)/ocr-cli

$(bindir)/ocr-cli: $(GIT_STAGING)/latorante/cli-macos-ocr/.build/release/ocr-cli
	$(INSTALL_PROGRAM) -- $< $@

$(GIT_STAGING)/latorante/cli-macos-ocr/.build/release/ocr-cli:
	cd $(GIT_STAGING)/latorante/cli-macos-ocr && swift build

# -- share/words ---------------------------------------------------------------

words: $(datadir)/dict/words

DICTS = connectives propernames web2 web2a
DICT_FILES = $(addprefix /usr/share/dict/,$(DICTS))

$(datadir)/dict/words: $(DICT_FILES) | $(datadir)/dict
	cat $^ | sort -u >$@

$(datadir)/dict:
	$(MKDIR) $@
