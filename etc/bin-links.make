# bin-links.make: Populate ~/bin with links to my own scripts
#
# Usage:
#     make -Bn -f $XDG_CONFIG_HOME/etc/bin-links.make

all: bin-links

BINDIR = ~/bin
DROPBOX = ../Dropbox
SCRIPT_SRC = $(DROPBOX)/scripts
BIN_SRC = $(DROPBOX)/bin

# list of symlinks
BIN_LINKS = \
	$(BINDIR)/btadd \
	$(BINDIR)/extractm4a \
	$(BINDIR)/fdcheck \
	$(BINDIR)/fixchmod \
	$(BINDIR)/itunes-album-art \
	$(BINDIR)/makemp3 \
	$(BINDIR)/mcmap \
	$(BINDIR)/md2rtf \
	$(BINDIR)/rot13 \
	$(BINDIR)/sunlight \
	$(BINDIR)/tconv \
	$(BINDIR)/trash \
	$(BINDIR)/brew-env \
	$(BINDIR)/code \
	$(BINDIR)/code-wait \
	$(BINDIR)/opconfsync \
	$(BINDIR)/subl \
	$(BINDIR)/subl-wait \
	$(BINDIR)/vsconfsync \
	$(BINDIR)/manpdf \
	$(BINDIR)/vsx

# maps to source files
$(BINDIR)/btadd: $(BIN_SRC)/btadd
$(BINDIR)/extractm4a: $(BIN_SRC)/extractm4a
$(BINDIR)/fdcheck: $(BIN_SRC)/fdcheck
$(BINDIR)/fixchmod: $(BIN_SRC)/fixchmod
$(BINDIR)/itunes-album-art: $(BIN_SRC)/itunes-album-art
$(BINDIR)/makemp3: $(BIN_SRC)/makemp3
$(BINDIR)/mcmap: $(BIN_SRC)/mcmap
$(BINDIR)/md2rtf: $(BIN_SRC)/md2rtf
$(BINDIR)/rot13: $(BIN_SRC)/rot13
$(BINDIR)/sunlight: $(BIN_SRC)/sunlight
$(BINDIR)/tconv: $(BIN_SRC)/tconv
$(BINDIR)/trash: $(BIN_SRC)/trash

$(BINDIR)/brew-env: $(SCRIPT_SRC)/homebrew/brew-env.sh
$(BINDIR)/code: $(SCRIPT_SRC)/macos-code.fish
$(BINDIR)/code-wait: $(SCRIPT_SRC)/macos-code.fish
$(BINDIR)/opconfsync: $(SCRIPT_SRC)/libexec/confsync.sh
$(BINDIR)/subl: $(SCRIPT_SRC)/macos-subl.sh
$(BINDIR)/subl-wait: $(SCRIPT_SRC)/macos-subl.sh
$(BINDIR)/vsconfsync: $(SCRIPT_SRC)/libexec/confsync.sh

$(BINDIR)/manpdf: $(DROPBOX)/Projects/manpdf/manpdf.sh
$(BINDIR)/vsx: ../.config/bin/vscode-extensions

# recipe
$(BIN_LINKS):
	/bin/ln -s $< $@

# alias
.PHONY: bin-links
bin-links: $(BIN_LINKS)
