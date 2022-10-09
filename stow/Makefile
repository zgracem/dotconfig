STOW_DIR := $(wildcard ~/opt/stow)
STAGING := $(STOW_DIR)/.staging
STOW := cd $(STOW_DIR) && stow

include ../common.mk

.PHONY: stow/all
stow/all:

# -- BSD calendars -------------------------------------------------------------

.PHONY: calendar
calendar: ~/opt/share/calendar
# stow/all: calendar

~/opt/share/calendar: ~/opt/stow/calendar/share/calendar
	${STOW} calendar

~/opt/stow/calendar/share/calendar: $(STAGING)/calendars
	${INSTALL} -m0644 -- $< $@

$(STAGING)/calendars:
	cd ${STAGING} && git clone --sparse git@github.com:freebsd/calendar-data.git $(notdir $@)

# -- cronic --------------------------------------------------------------------

.PHONY: cronic
cronic: ~/opt/bin/cronic
stow/all: cronic

~/opt/bin/cronic: ~/opt/stow/cronic-v3/bin/cronic
	${STOW} cronic

~/opt/stow/cronic-v3/bin/cronic: $(STAGING)/cronic
	${INSTALL} -- $< $@

$(STAGING)/cronic:
	cd ${STAGING} && wget -q https://habilis.net/cronic/cronic

# -- css3FontConverter ---------------------------------------------------------

.PHONY: css3FontConverter
css3FontConverter: ~/opt/bin/convertFonts.sh
stow/all: css3FontConverter

FONTCON_REPO := zoltan-dulac/css3FontConverter

~/opt/bin/convertFonts.sh: ~/opt/stow/css3FontConverter/bin/convertFonts.sh
	${STOW} css3FontConverter

~/opt/stow/css3FontConverter/bin/convertFonts.sh: $(GIT_STAGING)/$(FONTCON_REPO)/convertFonts.sh
	${GNUBIN}/ln -sf $< $@

~/opt/stow/css3FontConverter/bin/convertFonts.sh: | $(GIT_STAGING)/$(FONTCON_REPO)
$(GIT_STAGING)/$(FONTCON_REPO):
	cd ${GIT_STAGING} && git clone git@github.com:$(FONTCON_REPO).git $(FONTCON_REPO)

# -- dayone2 -------------------------------------------------------------------

.PHONY: dayone2
dayone2: ~/opt/bin/dayone2
stow/all: dayone2

~/opt/bin/dayone2: ~/opt/stow/dayone2/bin/dayone2
	${STOW} dayone2

~/opt/stow/dayone2/bin/dayone2: ~/Applications/DayOne.app/Contents/Resources/dayone2
	gzcat -v $^ >$@ && chmod -v u+x $@

~/Applications/DayOne.app/Contents/Resources/dayone2: ~/Applications/DayOne.app
~/Applications/DayOne.app:
	${XDG_CONFIG_HOME}/libexec/init-dayone.sh

# -- hunspell (for Sublime Merge) ----------------------------------------------

HUNSPELL_VERSION ?= 2020.12.07
LANG = en_CA

.PHONY: hunspell
hunspell: ~/opt/share/myspell
stow/all: hunspell

~/opt/share/myspell: ~/opt/stow/hunspell-$(LANG)/share/myspell/$(LANG).dic
	${STOW} hunspell

~/opt/stow/hunspell-$(LANG)/share/myspell/$(LANG).dic: $(STAGING)/hunspell-$(LANG)-$(HUNSPELL_VERSION).zip
	unzip -u -j -d $(dir $@) $< && touch -r $< $@

$(STAGING)/hunspell-$(LANG)-$(HUNSPELL_VERSION).zip:
	cd ${STAGING} && wget -q http://downloads.sourceforge.net/wordlist/$(@F)

# -- Markdown ------------------------------------------------------------------

.PHONY: markdown
markdown: ~/opt/bin/Markdown.pl
# stow/all: markdown

~/opt/bin/Markdown.pl: ~/opt/stow/markdown/bin/Markdown.pl
	${STOW} markdown

~/opt/stow/markdown/bin/Markdown.pl: $(STAGING)/Markdown.pl
	${INSTALL} -- $< $@

$(STAGING)/Markdown.pl: $(STAGING)/Markdown_1.0.1.zip
	unzip -u -j -d $(dir $@) $< '*.pl' && touch -r $< $@

$(STAGING)/Markdown_1.0.1.zip:
	cd ${STAGING} && wget -q https://daringfireball.net/projects/downloads/Markdown_1.0.1.zip

# -- tremc ---------------------------------------------------------------------

.PHONY: tremc
tremc: ~/opt/bin/tremc
stow/all: tremc

~/opt/bin/tremc: ~/opt/stow/tremc/bin/tremc
	${STOW} tremc

~/opt/stow/tremc/bin/tremc: | $(GIT_STAGING)/tremc/tremc
	cd $| && $(MAKE) DESTDIR=${STOW_DIR} PREFIX=/tremc install

$(GIT_STAGING)/tremc/tremc:
	cd ${STAGING} && git clone git@github.com:tremc/tremc.git

# -- share/words ---------------------------------------------------------------

.PHONY: words
words: ~/opt/share/dict/words
# stow/all: words

~/opt/share/dict/words: ~/opt/stow/words/share/dict/words
	${STOW} words

DICTS = connectives propernames web2 web2a
DICT_FILES = $(addprefix /usr/share/dict/,$(DICTS))

~/opt/stow/words/share/dict/words: $(DICT_FILES) | ~/opt/stow/words/share/dict
	cat $^ | sort | uniq >$@

~/opt/stow/words/share/dict:
	mkdir -p $@
