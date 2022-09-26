.PHONY: default all
default:
	@echo Target ‘$@’ not implemented.

.NOTPARALLEL:

MAKEFLAGS = Lr
# -L = check symlinks' mtime and not their destinations'
# -r = don't use implicit rules
GNUMAKEFLAGS = --output-sync

DOTFILES := $(CURDIR)

GNU := /usr/local/opt/coreutils/libexec/gnubin
INSTALL := $(GNU)/install --mode=0644 --preserve-timestamps

STOW_DIR := ~/opt/stow

# any ~/dotfiles/*/$dir that can be simply stowed to $HOME
STOWED =

# ~/dotfiles/config
CONFIG  =
CONFIG += aria2
CONFIG += bash
CONFIG += bat
CONFIG += bundler
CONFIG += curl
CONFIG += fish
CONFIG += git
CONFIG += homebrew
CONFIG += htop
CONFIG += iterm2
CONFIG += jq
CONFIG += markdownlint
CONFIG += minecraft
CONFIG += nethack
CONFIG += netrc
CONFIG += npm
CONFIG += prettier
CONFIG += rbenv-default-gems
CONFIG += readline
CONFIG += rubocop
CONFIG += ruby
CONFIG += sh
CONFIG += smerge
CONFIG += st3
CONFIG += stow
CONFIG += syncplay
CONFIG += tmux
CONFIG += tremc
CONFIG += vim
CONFIG += vscode-mac
CONFIG += wget
CONFIG += xdg-basedirs
CONFIG += xdg-user-dirs-update
CONFIG += yt-dlp
.PHONY: $(CONFIG)
$(CONFIG):
	cd ${DOTFILES}/config && stow --target ~/ $@
all: $(CONFIG)
STOWED += $(CONFIG:%=config/%)

# ~/dotfiles/private
PRIVATE  =
PRIVATE += 1password/private
PRIVATE += bash/private
PRIVATE += fish/private
PRIVATE += git/private
PRIVATE += maestral/private
PRIVATE += netrc/private
PRIVATE += sh/private
PRIVATE += smerge/private
PRIVATE += ssh/private
PRIVATE += yt-dlp/private

.PHONY: $(PRIVATE)
$(PRIVATE):
	cd $(DOTFILES)/private && stow --target ~/ $(dir $@)
STOWED += $(PRIVATE:%/private=private/%)

# add private files as prerequisites to config files
bash: bash/private
fish: fish/private
git: git/private
netrc: netrc/private
sh: sh/private
smerge: smerge/private
yt-dlp: yt-dlp/private

# 1password -- top-level alias
.PHONY: 1password
1password: 1password/private
all: 1password

# ssh -- top-level alias
.PHONY: ssh
ssh: ssh/private
all: ssh

# ~/dotfiles/data
DATA  =
DATA += dircolors/data
DATA += mailcap/data
DATA += vim/data

.PHONY: $(DATA)
$(DATA): %/data: | $(XDG_DATA_HOME)/%
$(XDG_DATA_HOME)/%:
	cd ${DOTFILES}/data && stow --target ~/ $(notdir $@)
STOWED += $(DATA:%/data=data/%)

# ----------------------------------------------------------------------------

# mailcap -- add to all
all: mailcap/data

# shells -- create empty data directories
SHELL_DATA = bash/data fish/data sh/data
.PHONY: $(SHELL_DATA)
$(SHELL_DATA): %/data: | $(XDG_DATA_HOME)/%
	mkdir -p $|
bash: | bash/data
fish: | fish/data
sh: | sh/data

# 1password -- build fish completions
fish/1password: $(DOTFILES)/config/fish/.config/fish/completions/op.fish
$(DOTFILES)/config/fish/.config/fish/completions/op.fish: /usr/local/bin/op
	/usr/local/bin/op completion fish > $@
/usr/local/bin/op:
	brew install --cask 1password/tap/1password-cli
fish: fish/1password

# bat -- also install and/or (re)build syntaxes
.PHONY: bat/syntaxes
bat/syntaxes: $(XDG_CACHE_HOME)/bat/syntaxes.bin
$(XDG_CACHE_HOME)/bat/syntaxes.bin: $(XDG_CONFIG_HOME)/bat/syntaxes | config/bat
	${DOTFILES}/libexec/bat-syntaxes.fish
bat: bat/syntaxes

# cronic -- install
.PHONY: cronic
cronic: | wget
	cd ${DOTFILES}/config/stow && $(MAKE) cronic
all: cronic

# dircolors -- also build .ls_colors files
.PHONY: dircolors/init
dircolors/init: $(XDG_CACHE_HOME)/dircolors/thirty2k.ls_colors | dircolors/data
$(XDG_CACHE_HOME)/dircolors/%.ls_colors: $(XDG_DATA_HOME)/dircolors/%.dir_colors
	cd $(XDG_DATA_HOME)/dircolors && make all
all: dircolors/init

# Maestral -- top level alias
.PHONY: maestral
all: maestral

# Maestral -- install .mignore file
# (Not a symlink because Maestral can't sync symlinks)
.PHONY: maestral/config
maestral/config: ~/Dropbox/.mignore
~/Dropbox/.mignore: config/maestral/Dropbox/.mignore
	${INSTALL} -- $< $@
maestral: maestral/config

# Maestral -- install CLI w/ pip to workaround issues w/ macOS builtin Python
# <https://github.com/samschott/maestral/issues/533#issuecomment-987790457>
.PHONY: maestral/cli
maestral/cli: /usr/local/bin/maestral
/usr/local/bin/maestral:
	pip3 install --upgrade 'maestral[gui]'
maestral: maestral/cli

# ruby -- add support files as prereqs
ruby: | bundler rubocop

# ruby -- also install gems
.PHONY: ruby/gems
ruby/gems: $(XDG_CONFIG_HOME)/ruby/Gemfile.lock
$(XDG_CONFIG_HOME)/ruby/Gemfile.lock: $(XDG_CONFIG_HOME)/ruby/Gemfile | config/ruby
	gem install --file=$(basename $<) --lock
all: ruby/gems

# rbenv -- create dirs and files
.PHONY: rbenv
rbenv: rbenv-default-gems | ~/.rbenv ~/.rbenv/version
~/.rbenv ~/.rbenv/versions:
	mkdir -p $@
~/.rbenv/version: ~/.rbenv/versions
	rbenv global system
ruby: | rbenv

# smerge -- also install spellcheck dictionary
.PHONY: smerge/spell
smerge/spell: $(STOW_DIR)/hunspell-en_CA/share/myspell/en_CA.dic
$(STOW_DIR)/hunspell-en_CA/share/myspell/en_CA.dic:
	cd ${DOTFILES}/config/stow && $(MAKE) hunspell
smerge: smerge/spell

# Stardew Valley
.PHONY: sdv
sdv: $(XDG_CONFIG_HOME)/StardewValley
$(XDG_CONFIG_HOME)/StardewValley: ~/Dropbox/.config/StardewValley
	ln -sf $< $@
all: sdv

# vim -- add data files as prereqs
vim: vim/data

# vim -- create cache dir
vim: | $(XDG_CACHE_HOME)/vim
$(XDG_CACHE_HOME)/vim:
	mkdir -p $@

# vim -- also install packages
.PHONY: vim/pack
vim/pack: $(XDG_DATA_HOME)/vim/pack/.installed | vim/data
$(XDG_DATA_HOME)/vim/pack/.installed:
	${DOTFILES}/libexec/init/vim-pack.fish && touch $@
vim: vim/pack

# vscode-mac -- add extension configs as prereqs
.PHONY: vscode-extensions
vscode-extensions: \
	markdownlint \
	prettier
vscode-mac: vscode-extensions

# ----------------------------------------------------------------------------

# Generate a fake user-agent string to mask the activity of tools like wget.
# (Hooks into existing targets, including `all`.)
include make/user-agent.make

# Install Homebrew
.PHONY: homebrew/install
homebrew/install: | homebrew
	cd ${DOTFILES}/config/homebrew/init && $(MAKE) brew/install
all: homebrew/install

# Install files to /etc and /usr/local/etc.
.PHONY: etc
etc:
	cd ${DOTFILES}/etc && $(MAKE) all
all: etc

# Install packages to ~/opt/stow
.PHONY: opt/stow
opt/stow:
	cd ${DOTFILES}/config/stow && $(MAKE) all
all: opt/stow

# ----------------------------------------------------------------------------

.PHONY: unstow-all
unstow = cd ${DOTFILES}/$(dir $(pkg)) && stow --delete -t ~/ $(notdir $(pkg);)
unstow-all:
	$(foreach pkg,$(STOWED),$(unstow))

.PHONY: restow-all
restow = cd ${DOTFILES}/$(dir $(pkg)) && stow --restow -t ~/ $(notdir $(pkg);)
restow-all:
	$(foreach pkg,$(STOWED),$(unstow))
