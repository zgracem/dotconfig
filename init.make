.PHONY: default all
default:
	@echo Target ‘$@’ not implemented.

.NOTPARALLEL:

MAKEFLAGS = Lr
# -L = check symlinks' mtime and not their destinations'
# -r = don't use implicit rules
GNUMAKEFLAGS = --output-sync

GNU := /usr/local/opt/coreutils/libexec/gnubin
INSTALL := $(GNU)/install --mode=0644 --preserve-timestamps

STOW_DIR := ~/opt/stow

# ----------------------------------------------------------------------------

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
	ln -sfv $< $@
shell/files: $(SHELL_FILES)
all: shell/files

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
$(XDG_CACHE_HOME)/bat/syntaxes.bin: bat/syntaxes
	${XDG_CONFIG_HOME}/libexec/bat-syntaxes.fish
all: bat/syntaxes

# dircolors -- also build .ls_colors files
.PHONY: dircolors
dircolors:
	cd ${XDG_CONFIG_HOME}/dircolors && $(MAKE) all

# jq -- install modules
.PHONY: jq
jq:
	cd ${XDG_CONFIG_HOME}/jq && $(MAKE) all
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
.PHONY: mailcap
mailcap: $(XDG_DATA_HOME)/mailcap
$(XDG_DATA_HOME)/mailcap: mailcap/mailcap
	ln -sfv $< $@
all: mailcap

# ruby -- install gems
.PHONY: ruby/gems
ruby/gems: ruby/Gemfile.lock
ruby/Gemfile.lock: ruby/Gemfile
	gem install --file=$(basename $<) --lock
all: ruby/gems

# rbenv -- create dirs and files
.PHONY: rbenv
rbenv: ~/.rbenv/default-gems ~/.rbenv/version
~/.rbenv/default-gems: rbenv/default-gems | ~/.rbenv
	ln -sfv $< $@
~/.rbenv/version: | ~/.rbenv/versions
	rbenv global system
~/.rbenv ~/.rbenv/versions:
	mkdir -pv $@
all: rbenv

# stow -- create symlink in $HOME
.PHONY: stow
stow: ~/.stow-global-ignore
~/.stow-global-ignore: stow/stow-global-ignore
	ln -sfv $< $@
all: stow

# tmux -- create symlink in $HOME
.PHONY: tmux
tmux: ~/.tmux.conf
~/.tmux.conf: tmux/.tmux.conf
	ln -sfv $< $@
all: tmux

# vim -- create symlink in $HOME
.PHONY: vim
vim: ~/.vimrc
~/.vimrc: vim/.vimrc
	ln -sfv $< $@

# vim -- create cache & data dirs
vim: | $(XDG_DATA_HOME)/vim $(XDG_CACHE_HOME)/vim
$(XDG_DATA_HOME)/vim $(XDG_CACHE_HOME)/vim:
	mkdir -pv $@

# vim -- also install packages
.PHONY: vim/pack
vim/pack: $(XDG_DATA_HOME)/vim/pack/.installed
$(XDG_DATA_HOME)/vim/pack/.installed:
	${XDG_CONFIG_HOME}/libexec/init/vim-pack.fish && touch $@
vim: vim/pack
all: vim

# ----------------------------------------------------------------------------

# Generate a fake user-agent string to mask the activity of tools like wget.
# (Hooks into existing targets, including `all`.)
include make/user-agent.make

# Install Homebrew
.PHONY: install/homebrew
install/homebrew:
	cd ${XDG_CONFIG_HOME}/brew/init && $(MAKE) brew/install
all: install/homebrew

# Install files to /etc and /usr/local/etc.
.PHONY: install/etc
install/etc:
	cd ${XDG_CONFIG_HOME}/etc && $(MAKE) all
all: install/etc

# Install packages to ~/opt/stow
.PHONY: opt/stow
opt/stow:
	cd ${XDG_CONFIG_HOME}/stow && $(MAKE) all
all: opt/stow
