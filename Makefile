# `make` with no arguments executes the first rule in the file.
.PHONY: default
default:
	@echo Target ‘$@’ not implemented.

.NOTPARALLEL:

MAKEFLAGS = Lr
# -L = check symlinks' mtime and not their destinations'
# -r = don't use implicit rules
GNUMAKEFLAGS = --output-sync

STOW_DIR := ~/opt/stow

SHELL := /usr/local/bin/bash
GNU := /usr/local/opt/coreutils/libexec/gnubin
INSTALL := $(GNU)/install --mode=0644 --preserve-timestamps

.PHONY: all

# ----------------------------------------------------------------------------

# environment -- load for GUI apps
.PHONY: setenv
setenv: ~/Library/LaunchAgents/org.inescapable.setenv.plist
	cd ${XDG_CONFIG_HOME}/launchd && $(MAKE)
all: setenv

# shells -- create empty data directories
SHELL_DATA  =
SHELL_DATA += $(XDG_DATA_HOME)/sh
SHELL_DATA += $(XDG_DATA_HOME)/bash
SHELL_DATA += $(XDG_DATA_HOME)/fish
.PHONY: shell/data
$(SHELL_DATA):
	mkdir -pv $@
shell/data: | $(SHELL_DATA)
all: shell/data

# shells -- create symlinks in $HOME
SHELL_FILES  =
SHELL_FILES += ~/.bash_profile
SHELL_FILES += ~/.bash_sessions_disable
SHELL_FILES += ~/.bashrc
SHELL_FILES += ~/.hushlogin
SHELL_FILES += ~/.profile
.PHONY: shell/files
~/.bash_profile: bash/.bash_profile
~/.bash_sessions_disable: bash/.bash_sessions_disable
~/.bashrc: bash/.bashrc
~/.hushlogin: bash/.hushlogin
~/.profile: sh/.profile
$(SHELL_FILES):
	ln -sfv .config/$< $@
shell/files: $(SHELL_FILES)
all: shell/files

# misc -- create symlinks in $HOME/Library/Application Support
.PHONY: appsupport
appsupport:
	${XDG_CONFIG_HOME}/bin/init/appsupport-links.sh
all: appsupport

# 1password -- build fish completions
.PHONY: 1password/fish
1password/fish: fish/completions/op.fish
fish/completions/op.fish: /usr/local/bin/op
	/usr/local/bin/op completion fish >$@
/usr/local/bin/op:
	brew install --cask 1password/tap/1password-cli
all: 1password/fish

# bat -- also install and/or (re)build syntaxes
.PHONY: bat/syntaxes
bat/syntaxes: $(XDG_CACHE_HOME)/bat/syntaxes.bin
$(XDG_CACHE_HOME)/bat/syntaxes.bin:
	${XDG_CONFIG_HOME}/bin/bat-syntaxes.fish
all: bat/syntaxes

# dircolors -- also build .ls_colors files
.PHONY: dircolors
dircolors:
	cd ${XDG_CONFIG_HOME}/dircolors && $(MAKE)
all: dircolors

# jq -- install modules
.PHONY: jq
jq:
	cd ${XDG_CONFIG_HOME}/jq && $(MAKE)
all: jq

# Maestral -- install .mignore file
# (Not a symlink because Maestral can't sync symlinks)
.PHONY: maestral
maestral: ~/Dropbox/.mignore
~/Dropbox/.mignore: maestral/.mignore
	${INSTALL} -- $< $@

# Maestral -- install CLI w/ pip to workaround issues w/ macOS builtin Python
# <https://github.com/samschott/maestral/issues/533#issuecomment-987790457>
.PHONY: maestral/cli
maestral/cli: /usr/local/bin/maestral
/usr/local/bin/maestral:
	pip3 install --upgrade 'maestral[gui]'
maestral: maestral/cli
all: maestral

# mailcap -- install
.PHONY: data/mailcap
data/mailcap: $(XDG_DATA_HOME)/mailcap
$(XDG_DATA_HOME)/mailcap: $(XDG_CONFIG_HOME)/mailcap/mailcap
	ln -sfv $(realpath $<) $@
all: data/mailcap

# ruby -- install gems
.PHONY: ruby/gems
ruby/gems: ruby/Gemfile.lock
ruby/Gemfile.lock: ruby/Gemfile
	gem install --file=$(basename $<) --lock
all: ruby/gems

# rbenv -- create dirs and files
.PHONY: rbenv
rbenv: $(XDG_DATA_HOME)/rbenv/default-gems | $(XDG_DATA_HOME)/rbenv/version
$(XDG_DATA_HOME)/rbenv/default-gems: $(XDG_CONFIG_HOME)/rbenv/default-gems | $(XDG_DATA_HOME)/rbenv
	ln -sfv $< $@
$(XDG_DATA_HOME)/rbenv/version: | $(XDG_DATA_HOME)/rbenv/versions
	rbenv global system
$(XDG_DATA_HOME)/rbenv $(XDG_DATA_HOME)/rbenv/versions:
	mkdir -pv $@
all: rbenv

# stow -- create symlink in $HOME
.PHONY: stow
stow: ~/.stow-global-ignore
~/.stow-global-ignore: stow/.stow-global-ignore
	ln -sfv .config/$< $@
all: stow

# tmux -- create symlink in $HOME
.PHONY: tmux
tmux: ~/.tmux.conf
~/.tmux.conf: tmux/.tmux.conf
	ln -sfv .config/$< $@
all: tmux

# vim -- create symlink in $HOME
.PHONY: vim
vim: ~/.vimrc
~/.vimrc: vim/.vimrc
	ln -sfv .config/$< $@

# vim -- create cache & data dirs
vim: | $(XDG_DATA_HOME)/vim $(XDG_CACHE_HOME)/vim
$(XDG_DATA_HOME)/vim $(XDG_CACHE_HOME)/vim:
	mkdir -pv $@

# vim -- also install packages
.PHONY: vim/pack
vim/pack: $(XDG_DATA_HOME)/vim/pack/.installed
$(XDG_DATA_HOME)/vim/pack/.installed:
	${XDG_CONFIG_HOME}/bin/init/vim-pack.fish && touch $@
vim: vim/pack
all: vim

# vscode-extensions -- update fish completions
.PHONY: vsx/fish
vsx/fish: fish/completions/vsx.fish
fish/completions/vsx.fish: $(XDG_CONFIG_HOME)/bin/vscode-extensions
	$< completions >$@
all: vsx/fish

# Install Homebrew
.PHONY: install/homebrew
install/homebrew:
	cd ${XDG_CONFIG_HOME}/brew/init && $(MAKE)
# all: install/homebrew

# Install files to /etc and /usr/local/etc.
.PHONY: install/etc
install/etc:
	cd ${XDG_CONFIG_HOME}/etc && $(MAKE)
all: install/etc

# Install packages to ~/opt/stow
.PHONY: opt/stow
opt/stow:
	cd ${XDG_CONFIG_HOME}/stow && $(MAKE)
all: opt/stow

# Install shims to ~/bin
.PHONY: shims
shims:
	cd ${XDG_CONFIG_HOME}/bin/shims && $(MAKE)
all: shims

# Install manpdf
.PHONY: manpdf
manpdf: ~/bin/manpdf | $(XDG_DATA_HOME)/doc/pdf
~/bin/manpdf: ~/src/github.com/zgracem/manpdf/manpdf.sh
	ln -sfv $< $@
$(XDG_DATA_HOME)/doc/pdf:
	mkdir -pv $@
all: manpdf

# Rebuild files in ./.data
.PHONY: data
data:
	cd ${XDG_CONFIG_HOME}/.data && $(MAKE)
all: data

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
	${XDG_CONFIG_HOME}/bin/user-agent-get.fish > $@
$(XDG_CACHE_HOME)/dotfiles:
	mkdir -pv $@
$(UA_OUTPUT_FILES): $(UA_FILE)

$(UA_OUTPUT_FILES): %: %.m4
	m4 -D _HOME_="${HOME}" -D _USER_AGENT_="$(shell cat ${UA_FILE})" $< >$@

.PHONY: user-agent
user-agent: $(UA_OUTPUT_FILES)
