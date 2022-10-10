datarootdir := $(XDG_DATA_HOME)

.PHONY: all
all:

include common.mk

install:
	@echo Target ‘$@’ not implemented.

# ----------------------------------------------------------------------------

# launchd -- load environment for GUI apps
.PHONY: launchd/install
launchd/install: ~/Library/LaunchAgents/org.inescapable.setenv.plist
	cd $(XDG_CONFIG_HOME)/launchd && $(MAKE)
all: launchd/install

# shells -- create empty data directories
SHELL_DATA  =
SHELL_DATA += $(datadir)/sh
SHELL_DATA += $(datadir)/bash
SHELL_DATA += $(datadir)/fish
$(SHELL_DATA):
	mkdir -pv $@
all: | $(SHELL_DATA)

# shells -- create symlinks in $HOME
SHELL_FILES  =
SHELL_FILES += ~/.bash_profile
SHELL_FILES += ~/.bash_sessions_disable
SHELL_FILES += ~/.bashrc
SHELL_FILES += ~/.hushlogin
SHELL_FILES += ~/.profile
~/.bash_profile: bash/.bash_profile
~/.bash_sessions_disable: bash/.bash_sessions_disable
~/.bashrc: bash/.bashrc
~/.hushlogin: bash/.hushlogin
~/.profile: sh/.profile
$(SHELL_FILES):
	ln -sfv .config/$< $@
all: $(SHELL_FILES)

# Create symlinks in $HOME/Library/Application Support
.PHONY: appsupport
appsupport:
	$(XDG_CONFIG_HOME)/libexec/init-appsupport.sh
# all: appsupport

# 1password -- build fish completions
fish/completions/op.fish: /usr/local/bin/op
	/usr/local/bin/op completion fish >$@
/usr/local/bin/op: | /usr/local/bin/brew
	brew install --cask 1password/tap/1password-cli
all: fish/completions/op.fish

# bat -- install and/or (re)build syntaxes
.PHONY: bat/syntax
bat/syntax: $(XDG_CACHE_HOME)/bat/syntaxes.bin
$(XDG_CACHE_HOME)/bat/syntaxes.bin:
	$(XDG_CONFIG_HOME)/libexec/bat-syntaxes.fish
all: bat/syntax

# dircolors -- build .ls_colors files
$(XDG_CACHE_HOME)/dircolors/thirty2k.ls_colors.fish:
	cd $(XDG_CONFIG_HOME)/dircolors && $(MAKE)
all: $(XDG_CACHE_HOME)/dircolors/thirty2k.ls_colors.fish

# jq -- install modules
.PHONY: jq/install
jq:
	cd $(XDG_CONFIG_HOME)/jq && $(MAKE)
all: jq/install

# Maestral
# -- install .mignore file
# (Not a symlink because Maestral can't sync symlinks)
~/Dropbox/.mignore: maestral/.mignore
	$(INSTALL_DATA) -- $< $@
# -- install CLI w/ pip to workaround issues w/ macOS builtin Python
# <https://github.com/samschott/maestral/issues/533#issuecomment-987790457>
/usr/local/bin/maestral:
	pip3 install --upgrade 'maestral[gui]'
all: ~/Dropbox/.mignore /usr/local/bin/maestral

# mailcap -- install
$(datarootdir)/mailcap: mailcap/mailcap
	ln -sfv $(realpath $<) $@
all: $(datarootdir)/mailcap

# ruby -- install gems
.PHONY: ruby/install/gems
ruby/install/gems: ruby/Gemfile.lock
ruby/Gemfile.lock: ruby/Gemfile
	gem install --file=$(<F) --lock
all: ruby/install/gems

# rbenv -- create dirs and files
.PHONY: rbenv/install
rbenv/install: $(datadir)/rbenv/default-gems | $(datadir)/rbenv/version
$(datadir)/rbenv/default-gems: rbenv/default-gems | $(datadir)/rbenv
	ln -sfv $< $@
$(datadir)/rbenv/version: | $(datadir)/rbenv/versions
	rbenv global system
$(datadir)/rbenv $(datadir)/rbenv/versions:
	mkdir -pv $@
all: rbenv/install

# stow -- create symlink in $HOME
~/.stow-global-ignore: stow/.stow-global-ignore
	ln -sfv .config/$< $@
all: ~/.stow-global-ignore

# tmux -- create symlink in $HOME
~/.tmux.conf: tmux/.tmux.conf
	ln -sfv .config/$< $@
all: ~/.tmux.conf

# vim
# -- create symlink in $HOME
.PHONY: vim/install
vim/install: ~/.vimrc
~/.vimrc: vim/.vimrc
	ln -sfv .config/$< $@
# -- create cache & data dirs
vim/install: | $(datadir)/vim $(XDG_CACHE_HOME)/vim
$(datadir)/vim $(XDG_CACHE_HOME)/vim:
	mkdir -pv $@
# -- also install packages
vim/install: vim/install/pack
.PHONY: vim/install/pack
vim/install/pack: $(datadir)/vim/pack/.installed
$(datadir)/vim/pack/.installed:
	$(XDG_CONFIG_HOME)/libexec/init-vim-pack.fish && touch $@
all: vim/install

# vscode-extensions -- update fish completions
fish/completions/vsx.fish: bin/vsx
	$< completions >$@
all: fish/completions/vsx.fish

# Install Homebrew
.PHONY: homebrew
homebrew:
	cd $(XDG_CONFIG_HOME)/brew && $(MAKE)
# all: homebrew

# Install files to /etc and /usr/local/etc.
.PHONY: etc/install
etc/install:
	cd $(XDG_CONFIG_HOME)/etc && $(MAKE)
all: etc/install

# Install packages to ~/opt/stow
.PHONY: stow/install
stow/install:
	cd $(XDG_CONFIG_HOME)/stow && $(MAKE)
all: stow/install

# Install to ~/bin
.PHONY: bin/install
bin/install:
	cd $(XDG_CONFIG_HOME)/bin && $(MAKE)
all: bin/install

# Install manpdf
~/bin/manpdf: $(GIT_STAGING)/zgracem/manpdf/manpdf.sh | $(datarootdir)/doc/pdf
	ln -sfv $< $@
$(datarootdir)/doc/pdf:
	mkdir -pv $@
all: ~/bin/manpdf

# -----------------------------------------------------------------------------
# Generate a fake user-agent string to mask the activity of tools like wget.
# Use Homebrew's recipe for Google Chrome to avoid installing Chrome itself.
# ----------------------------------------------------------------------------

UA_OUTPUT_FILES = \
	aria2/aria2.conf \
	curl/.curlrc \
	wget/wgetrc \
	yt-dlp/config \
	../.private/yt-dlp/config

HB_FILE := /usr/local/Homebrew/Library/Taps/homebrew/homebrew-cask/Casks/google-chrome.rb
UA_FILE := $(XDG_CACHE_HOME)/dotfiles/user-agent.txt
$(UA_FILE): $(HB_FILE) | $(XDG_CACHE_HOME)/dotfiles
	$(XDG_CONFIG_HOME)/libexec/user-agent-get.fish >$@
$(XDG_CACHE_HOME)/dotfiles:
	mkdir -pv $@
$(UA_OUTPUT_FILES): $(UA_FILE)
$(HB_FILE): | /usr/local/bin/brew

$(UA_OUTPUT_FILES): %: %.m4
	m4 -D _HOME_="$(HOME)" -D _USER_AGENT_="$(shell cat $(UA_FILE))" $< >$@

.PHONY: user-agent
user-agent: $(UA_OUTPUT_FILES)

.PHONY: user-agent/clean
user-agent/clean:
	rm -fv $(UA_OUTPUT_FILES) $(UA_FILE)
