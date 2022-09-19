# ----------------------------------------------------------------------------
# Aliases
# ----------------------------------------------------------------------------

# `make` with no arguments executes the first rule in the file.
all:
	@echo Target ‘$@’ not implemented.

# Phony targets that we want to `make <alias>` anyway:
.PHONY: completions jq shell-files symlinks user-agent vscode-mac dnsmasq sudoer

# ----------------------------------------------------------------------------
# Targets
# ----------------------------------------------------------------------------

COMPLETIONS = \
	fish/completions/op.fish

DNSMASQ_FILES = \
	/usr/local/etc/dnsmasq.conf \
	/etc/resolver/test

JQ_MODULE_DIR := $(XDG_CONFIG_HOME)/jq
JQ_MODULES := $(wildcard $(JQ_MODULE_DIR)/*.jq $(JQ_MODULE_DIR)/*.json)
JQ_TARGETS := $(patsubst $(JQ_MODULE_DIR)/%, $(HOME)/.jq/%, $(JQ_MODULES))

SHELL_FILES = \
	~/.bash_logout \
	~/.bash_profile \
	~/.bash_sessions_disable \
	~/.bashrc \
	~/.hushlogin \
	~/.profile

HOMEDIR_SYMLINKS = \
	~/.editorconfig \
	~/.stow-global-ignore \
	~/.stowrc \
	~/.tmux.conf \
	~/.vimrc

VSCODE_MACOS_SYMLINKS = \
	~/Library/AppSupport/Code/User/settings.json \
	~/Library/AppSupport/Code/User/keybindings.json \
	~/Library/AppSupport/Code/User/snippets

CUSTOM_UA = \
	aria2/aria2.conf \
	curl/.curlrc \
	wget/wgetrc \
	yt-dlp/config \
	../.private/yt-dlp/config

# Map aliases to groups of target files:
completions: $(COMPLETIONS)
dnsmasq: $(DNSMASQ_FILES)
jq: $(JQ_TARGETS)
shell-files: $(SHELL_FILES)
sudoer: /etc/sudoers.d/sudoer_zozo
symlinks: $(HOMEDIR_SYMLINKS)
user-agent: user-agent.txt $(CUSTOM_UA)
vscode-mac: $(VSCODE_MACOS_SYMLINKS)

# ----------------------------------------------------------------------------
# Prerequisites for targets
# ----------------------------------------------------------------------------

# completions

fish/completions/op.fish: /usr/local/bin/op

# dnsmasq configuration

/usr/local/etc/dnsmasq.conf: etc/dnsmasq.conf
/etc/resolver/test: etc/resolver/test

# jq modules

$(JQ_TARGETS): $(HOME)/.jq/%: $(XDG_CONFIG_HOME)/jq/%

# shell-files

SKEL = .skel
~/.bash_logout: $(SKEL)/.bash_logout
~/.bash_profile: $(SKEL)/.bash_profile
~/.bash_sessions_disable: $(SKEL)/.bash_sessions_disable
~/.bashrc: $(SKEL)/.bashrc
~/.hushlogin: $(SKEL)/.hushlogin
~/.profile: $(SKEL)/.profile

# symlinks

~/.editorconfig: .editorconfig
~/.stow-global-ignore: stow/stow-global-ignore
~/.stowrc: stow/stowrc
~/.tmux.conf: tmux/tmux.conf
~/.vimrc: vim/vimrc
$(VSCODE_MACOS_SYMLINKS): $(HOME)/Library/AppSupport/%: $(XDG_CONFIG_HOME)/%

# user-agent

aria2/aria2.conf: aria2/aria2.conf.m4
curl/.curlrc: curl/.curlrc.m4
wget/wgetrc: wget/wgetrc.m4
yt-dlp/config: yt-dlp/config.m4
../.private/yt-dlp/config: ../.private/yt-dlp/config.m4
$(CUSTOM_UA): user-agent.txt

# ----------------------------------------------------------------------------
# Recipes for targets
# ----------------------------------------------------------------------------

GNU := /usr/local/opt/coreutils/libexec/gnubin
INSTALL := $(GNU)/install --mode=0644 --preserve-timestamps

fish/completions/op.fish:
	op completion fish > $@

$(JQ_TARGETS):
	$(INSTALL) -- $< $@

/usr/local/etc/dnsmasq.conf:
	$(INSTALL) -D -- $< $@

/etc/resolver/test:
	sudo $(INSTALL) -D -- $< $@

/etc/sudoers.d/%: etc/%
	sudo $(INSTALL) -D -- $< $@

$(SHELL_FILES):
	$(INSTALL) -- $< $@

$(HOMEDIR_SYMLINKS):
	$(GNU)/ln -s .config/$< $@

$(VSCODE_MACOS_SYMLINKS):
	$(GNU)/ln -s $< $@

user-agent.txt: /usr/local/Homebrew/Library/Taps/homebrew/homebrew-cask/Casks/google-chrome.rb
	.vscode/bin/user-agent-get.fish > $@

USER_AGENT = $(shell cat $(CURDIR)/user-agent.txt)

$(CUSTOM_UA):
	m4 -D _HOME_="$(HOME)" -D _USER_AGENT_="$(USER_AGENT)" $< > $@
