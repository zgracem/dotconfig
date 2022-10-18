datarootdir := $(XDG_DATA_HOME)

.PHONY: all
all:

include common.mk

install:
	@echo Target ‘$@’ not implemented.

# ----------------------------------------------------------------------------

define link-home =
ln -sfv .config/$< $@
endef

# shells: create empty data directories
.PHONY: shellfiles
SHELL_DATA  =
SHELL_DATA += $(datadir)/sh
SHELL_DATA += $(datadir)/bash
SHELL_DATA += $(datadir)/fish
$(SHELL_DATA):
	mkdir -pv $@
shellfiles: | $(SHELL_DATA)

# shells: create symlinks in $HOME
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
	$(link-home)
shellfiles: $(SHELL_FILES)
all: shellfiles

# Create symlinks in $HOME/Library/Application Support
.PHONY: appsupport
appsupport:
	$(XDG_CONFIG_HOME)/libexec/init-appsupport.sh
# all: appsupport

# Fix missing header file errors when building software
.PHONY: sdk
sdk: $(XDG_CACHE_HOME)/dotfiles/MacOSX-sdk-path.txt
dev_dir := /Applications/Xcode.app/Contents/Developer/Platforms/MacOSX.platform/Developer
$(XDG_CACHE_HOME)/dotfiles/MacOSX-sdk-path.txt: $(dev_dir)/SDKs/MacOSX.sdk | $(XDG_CACHE_HOME)/dotfiles
	xcrun --sdk macosx --show-sdk-path >$@
all: sdk

# 1password: build fish completions
fish/completions/op.fish: /usr/local/bin/op
	/usr/local/bin/op completion fish >$@
/usr/local/bin/op: | /usr/local/bin/brew
	brew install --cask 1password/tap/1password-cli
.PHONY: fish-completions
fish-completions: fish/completions/op.fish
all: fish-completions

# bat: install and/or (re)build syntaxes
.PHONY: bat/syntaxes
bat/syntaxes: $(XDG_CACHE_HOME)/bat/syntaxes.bin
$(XDG_CACHE_HOME)/bat/syntaxes.bin:
	$(XDG_CONFIG_HOME)/libexec/bat-syntaxes.fish
# all: bat/syntaxes

# Maestral: install .mignore file
# (Not a symlink because Maestral can't sync symlinks)
~/Dropbox/.mignore: maestral/.mignore
	$(INSTALL_DATA) -- $< $@
maestral/.mignore:
	maestral status | grep -Eq 'Cannot upload symlink' && \
	cd ~/Dropbox && fd -u -ts -tl --no-follow --strip-cwd-prefix | tee $(realpath $@)
# -- install CLI w/ pip to workaround issues w/ macOS builtin Python
# <https://github.com/samschott/maestral/issues/533#issuecomment-987790457>
/usr/local/bin/maestral:
	pip3 install --upgrade 'maestral[gui]'
all: ~/Dropbox/.mignore | /usr/local/bin/maestral

# mailcap: install
$(datarootdir)/mailcap: mailcap/mailcap
	$(INSTALL_DATA) -- $(realpath $<) $@
all: $(datarootdir)/mailcap

# ruby: install gems
.PHONY: ruby/install/gems
ruby/install/gems: ruby/Gemfile.lock
ruby/Gemfile.lock: ruby/Gemfile
	gem install --file=$< --lock
# all: ruby/install/gems

# rbenv: create dirs and files
.PHONY: rbenv/install
rbenv/install: $(datadir)/rbenv/default-gems | $(datadir)/rbenv/version
$(datadir)/rbenv/default-gems: rbenv/default-gems | $(datadir)/rbenv
	$(INSTALL_DATA) -- $(realpath $<) $@
$(datadir)/rbenv/version: | $(datadir)/rbenv/versions
	rbenv global system
$(datadir)/rbenv $(datadir)/rbenv/versions:
	mkdir -pv $@
all: rbenv/install

# stow: create symlink in $HOME
~/.stow-global-ignore: stow/.stow-global-ignore
	$(link-home)
all: ~/.stow-global-ignore

# vim: create symlink in $HOME
all: ~/.vimrc
~/.vimrc: vim/.vimrc
	$(link-home)
# -- create cache & data dirs
all: | $(datadir)/vim $(XDG_CACHE_HOME)/vim $(XDG_STATE_HOME)/vim
$(datadir)/vim $(XDG_CACHE_HOME)/vim $(XDG_STATE_HOME)/vim:
	mkdir -pv $@
# --  install packages
all: $(datadir)/vim/pack/.installed
$(datadir)/vim/pack/.installed:
	$(XDG_CONFIG_HOME)/libexec/init-vim-pack.fish && touch $@

# vscode-extensions: update fish completions
fish/completions/vsx.fish: bin/vsx
	$< completions >$@
fish-completions: fish/completions/vsx.fish

# vs: update/install fish completions
fish/completions/vs.fish: ~/bin/vs
	$< complete print >$@
fish-completions: fish/completions/vs.fish
~/bin/vs:
	cd $(XDG_CONFIG_HOME)/bin && $(MAKE) $@

# Install Homebrew
.PHONY: homebrew
homebrew:
	cd $(XDG_CONFIG_HOME)/brew && $(MAKE)
# all: homebrew

# Install to ~/bin
.PHONY: bin/install
bin/install:
	cd $(XDG_CONFIG_HOME)/bin && $(MAKE)
all: bin/install

# dircolors: build .ls_colors files
.PHONY: dircolors
dircolors:
	cd $(XDG_CONFIG_HOME)/dircolors && $(MAKE)
all: dircolors

# Install files to /etc and /usr/local/etc.
.PHONY: etc/install
etc/install:
	cd $(XDG_CONFIG_HOME)/etc && $(MAKE)
all: etc/install

# jq: install modules
.PHONY: jq/install
jq/install:
	cd $(XDG_CONFIG_HOME)/jq && $(MAKE)
all: jq/install

# launchd: load environment for GUI apps
.PHONY: launchd/install
launchd/install:
	cd $(XDG_CONFIG_HOME)/launchd && $(MAKE)
all: launchd/install

# Install packages to ~/opt/stow
.PHONY: stow/install
stow/install:
	cd $(XDG_CONFIG_HOME)/stow && $(MAKE)
all: stow/install

.PHONY: www/install
www/install: www/userContent.css
www/userContent.css: www/userContent.sass
	sass $< >$@ && \
	defaults write -app Safari UserStyleSheetEnabled -bool true && \
	defaults write -app Safari UserStyleSheetLocationURLString $(realpath $@)
all: www/install

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

M4FLAGS  =
M4FLAGS += -D _HOME_="$(HOME)"
M4FLAGS += -D _USER_AGENT_="$(shell cat $(UA_FILE))"
M4FLAGS += -D _XDG_CACHE_HOME_="$(XDG_CACHE_HOME)"
$(UA_OUTPUT_FILES): %: %.m4
	m4 $(M4FLAGS) $< >$@

.PHONY: user-agent
user-agent: $(UA_OUTPUT_FILES)

.PHONY: user-agent/clean
user-agent/clean:
	rm -fv $(UA_OUTPUT_FILES) $(UA_FILE)
