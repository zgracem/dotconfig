SHELL = /usr/local/bin/bash
STOW_DIR := $(HOME)/opt/stow
STAGING := $(STOW_DIR)/.staging

GNU := /usr/local/opt/coreutils/libexec/gnubin
INSTALL := $(GNU)/install --preserve-timestamps

# `make` with no arguments executes the first rule in the file.
.PHONY: default
default:
	@echo Target ‘$@’ not implemented.

.PHONY: all

# -- BSD calendars -------------------------------------------------------------

.PHONY: calendar
calendar: ~/opt/share/calendar
# all: calendar

~/opt/share/calendar: $(STOW_DIR)/calendar/share/calendar
	cd ${STOW_DIR} && stow calendar

$(STOW_DIR)/calendar/share/calendar: $(STAGING)/calendars
	${INSTALL} -C -D -m0644 -- $< $@

$(STAGING)/calendars:
	cd ${STAGING} && git clone --sparse git@github.com:freebsd/calendar-data.git $(notdir $@)

# -- cronic --------------------------------------------------------------------

.PHONY: cronic
cronic: ~/opt/bin/cronic
all: cronic

~/opt/bin/cronic: $(STOW_DIR)/cronic-v3/bin/cronic
	cd ${STOW_DIR} && stow cronic

$(STOW_DIR)/cronic-v3/bin/cronic: $(STAGING)/cronic
	${INSTALL} -C -D -- $< $@

$(STAGING)/cronic:
	cd ${STAGING} && wget -q https://habilis.net/cronic/cronic

# -- css3FontConverter ---------------------------------------------------------

.PHONY: css3FontConverter
css3FontConverter: ~/opt/bin/convertFonts.sh
all: css3FontConverter

~/opt/bin/convertFonts.sh: $(STOW_DIR)/css3FontConverter/bin/convertFonts.sh
	cd ${STOW_DIR} && stow css3FontConverter

$(STOW_DIR)/css3FontConverter/bin/convertFonts.sh: $(STAGING)/css3FontConverter/convertFonts.sh
	${INSTALL} -C -D -- $< $@

$(STAGING)/css3FontConverter:
	cd ${STAGING} && git clone git@github.com:zoltan-dulac/css3FontConverter.git

# -- dayone2 -------------------------------------------------------------------

.PHONY: dayone2
dayone2: ~/opt/bin/dayone2
all: dayone2

~/opt/bin/dayone2: $(STOW_DIR)/dayone2/bin/dayone2
	cd ${STOW_DIR} && stow dayone2

$(STOW_DIR)/dayone2/bin/dayone2: $(HOME)/Applications/DayOne.app/Contents/Resources/dayone2
	gzcat -v $^ >$@ && chmod -v u+x $@

$(HOME)/Applications/DayOne.app/Contents/Resources/dayone2: $(HOME)/Applications/DayOne.app
$(HOME)/Applications/DayOne.app:
	${XDG_CONFIG_HOME}/libexec/init/dayone-link.sh

# -- hunspell (for Sublime Merge) ----------------------------------------------

HUNSPELL_VERSION ?= 2020.12.07
LANG = en_CA

.PHONY: hunspell
hunspell: ~/opt/share/myspell
all: hunspell

~/opt/share/myspell: $(STOW_DIR)/hunspell-$(LANG)/share/myspell/$(LANG).dic
	cd ${STOW_DIR} && stow hunspell

$(STOW_DIR)/hunspell-$(LANG)/share/myspell/$(LANG).dic: $(STAGING)/hunspell-$(LANG)-$(HUNSPELL_VERSION).zip
	unzip -u -j -d $(dir $@) $< && touch -r $< $@

$(STAGING)/hunspell-$(LANG)-$(HUNSPELL_VERSION).zip:
	cd ${STAGING} && wget -q http://downloads.sourceforge.net/wordlist/$(@F)

# -- Markdown ------------------------------------------------------------------

.PHONY: markdown
markdown: ~/opt/bin/Markdown.pl
# all: markdown

~/opt/bin/Markdown.pl: $(STOW_DIR)/markdown/bin/Markdown.pl
	cd ${STOW_DIR} && stow markdown

$(STOW_DIR)/markdown/bin/Markdown.pl: $(STAGING)/Markdown.pl
	${INSTALL} -C -D -- $< $@

$(STAGING)/Markdown.pl: $(STAGING)/Markdown_1.0.1.zip
	unzip -u -j -d $(dir $@) $< '*.pl' && touch -r $< $@

$(STAGING)/Markdown_1.0.1.zip:
	cd $(STAGING) && wget -q https://daringfireball.net/projects/downloads/Markdown_1.0.1.zip

# -- tremc ---------------------------------------------------------------------

.PHONY: tremc
tremc: ~/opt/bin/tremc
all: tremc

~/opt/bin/tremc: $(STOW_DIR)/tremc/bin/tremc
	cd ${STOW_DIR} && stow tremc

$(STOW_DIR)/tremc/bin/tremc: | $(STAGING)/tremc
	cd $| && $(MAKE) DESTDIR=${STOW_DIR} PREFIX=/tremc install

$(STAGING)/tremc:
	cd ${STAGING} && git clone git@github.com:tremc/tremc.git

# -- share/words ---------------------------------------------------------------

.PHONY: words
words: ~/opt/share/dict/words
# all: words

~/opt/share/dict/words: $(STOW_DIR)/words/share/dict/words
	cd ${STOW_DIR} && stow words

DICTS = connectives propernames web2 web2a
DICT_FILES = $(addprefix /usr/share/dict/,$(DICTS))

$(STOW_DIR)/words/share/dict/words: $(DICT_FILES) | $(STOW_DIR)/words/share/dict
	cat $^ | sort | uniq >$@

$(STOW_DIR)/words/share/dict:
	mkdir -p $@
