prefix := $(wildcard ~/opt)
datarootdir := $(prefix)/share

include ../common.mk

STOW_DIR := $(wildcard ~/opt/stow)
srcdir := $(STOW_DIR)/.staging
STOW := cd $(STOW_DIR) && stow

# -- BSD calendars -------------------------------------------------------------

.PHONY: calendar
calendar: $(datarootdir)/calendar
# install: calendar

$(datarootdir)/calendar: $(STOW_DIR)/calendar/share/calendar
	$(STOW) calendar

$(STOW_DIR)/calendar/share/calendar: $(srcdir)/calendars
	$(INSTALL_DATA) -- $< $@

$(srcdir)/calendars:
	cd $(@D) && git clone --sparse git@github.com:freebsd/calendar-data.git $(@F)

# -- cronic --------------------------------------------------------------------

.PHONY: cronic
cronic: $(bindir)/cronic
install: cronic

$(bindir)/cronic: $(STOW_DIR)/cronic-v3/bin/cronic
	$(STOW) cronic

$(STOW_DIR)/cronic-v3/bin/cronic: $(srcdir)/cronic
	$(INSTALL_PROGRAM) -- $< $@

$(srcdir)/cronic:
	cd $(@D) && wget -q https://habilis.net/cronic/cronic

# -- css3FontConverter ---------------------------------------------------------

.PHONY: css3FontConverter
css3FontConverter: $(bindir)/convertFonts.sh
install: css3FontConverter

FONTCON_REPO := zoltan-dulac/css3FontConverter

$(bindir)/convertFonts.sh: $(STOW_DIR)/css3FontConverter/bin/convertFonts.sh
	$(STOW) css3FontConverter

$(STOW_DIR)/css3FontConverter/bin/convertFonts.sh: $(GIT_STAGING)/$(FONTCON_REPO)/convertFonts.sh
	ln -sfv $< $@

$(STOW_DIR)/css3FontConverter/bin/convertFonts.sh: | $(GIT_STAGING)/$(FONTCON_REPO)
$(GIT_STAGING)/$(FONTCON_REPO):
	cd $(GIT_STAGING) && git clone git@github.com:$(FONTCON_REPO).git $(FONTCON_REPO)

# -- dayone2 -------------------------------------------------------------------

.PHONY: dayone2
dayone2: $(bindir)/dayone2
install: dayone2

$(bindir)/dayone2: $(STOW_DIR)/dayone2/bin/dayone2
	$(STOW) dayone2

$(STOW_DIR)/dayone2/bin/dayone2: ~/Applications/DayOne.app/Contents/Resources/dayone2
	gzcat -v $^ >$@ && chmod -v u+x $@

~/Applications/DayOne.app/Contents/Resources/dayone2: ~/Applications/DayOne.app
~/Applications/DayOne.app:
	$(XDG_CONFIG_HOME)/libexec/init-dayone.sh

# -- hunspell (for Sublime Merge) ----------------------------------------------

HUNSPELL_VERSION ?= 2020.12.07
LANG = en_CA

.PHONY: hunspell
hunspell: $(datarootdir)/myspell
install: hunspell

$(datarootdir)/myspell: $(STOW_DIR)/hunspell-$(LANG)/share/myspell/$(LANG).dic
	$(STOW) hunspell

$(STOW_DIR)/hunspell-$(LANG)/share/myspell/$(LANG).dic: $(srcdir)/hunspell-$(LANG)-$(HUNSPELL_VERSION).zip
	unzip -u -j -d $(@D) $< && touch -r $< $@

$(srcdir)/hunspell-$(LANG)-$(HUNSPELL_VERSION).zip:
	cd $(@D) && wget -q http://downloads.sourceforge.net/wordlist/$(@F)

# -- Markdown ------------------------------------------------------------------

.PHONY: markdown
markdown: $(bindir)/Markdown.pl
# install: markdown

$(bindir)/Markdown.pl: $(STOW_DIR)/markdown/bin/Markdown.pl
	$(STOW) markdown

$(STOW_DIR)/markdown/bin/Markdown.pl: $(srcdir)/Markdown.pl
	$(INSTALL_PROGRAM) -- $< $@

$(srcdir)/Markdown.pl: $(srcdir)/Markdown_1.0.1.zip
	unzip -u -j -d $(@D) $< '*.pl' && touch -r $< $@

$(srcdir)/Markdown_1.0.1.zip:
	cd $(srcdir) && wget -q https://daringfireball.net/projects/downloads/Markdown_1.0.1.zip

# -- tremc ---------------------------------------------------------------------

.PHONY: tremc
tremc: $(bindir)/tremc
install: tremc

$(bindir)/tremc: $(STOW_DIR)/tremc/bin/tremc
	$(STOW) tremc

$(STOW_DIR)/tremc/bin/tremc: | $(GIT_STAGING)/tremc/tremc
	cd $| && $(MAKE) DESTDIR=$(STOW_DIR) PREFIX=/tremc install

$(GIT_STAGING)/tremc/tremc:
	cd $(srcdir) && git clone git@github.com:tremc/tremc.git

# -- share/words ---------------------------------------------------------------

.PHONY: words
words: $(datarootdir)/dict/words
# install: words

$(datarootdir)/dict/words: $(STOW_DIR)/words/share/dict/words
	$(STOW) words

DICTS = connectives propernames web2 web2a
DICT_FILES = $(addprefix /usr/share/dict/,$(DICTS))

$(STOW_DIR)/words/share/dict/words: $(DICT_FILES) | $(STOW_DIR)/words/share/dict
	cat $^ | sort | uniq >$@

$(STOW_DIR)/words/share/dict:
	mkdir -pv $@
