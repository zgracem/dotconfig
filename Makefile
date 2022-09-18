# ----------------------------------------------------------------------------
# Aliases
# ----------------------------------------------------------------------------

# `make` with no arguments executes the first rule in the file.
all:
	@echo Target ‘$@’ not implemented.

# Phony targets that we want to `make <alias>` anyway:
.PHONY: completions jq shell-files symlinks user-agent vscode-mac

# ----------------------------------------------------------------------------
# Targets
# ----------------------------------------------------------------------------

COMPLETIONS = \
	fish/completions/op.fish

JQ_MODULE_DIR := $(XDG_CONFIG_HOME)/jq
JQ_MODULES = $(wildcard $(JQ_MODULE_DIR)/*.jq $(JQ_MODULE_DIR)/*.json)
JQ_TARGETS = $(patsubst $(JQ_MODULE_DIR)/%, $(HOME)/.jq/%, $(JQ_MODULES))

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
jq: $(JQ_TARGETS)
shell-files: $(SHELL_FILES)
symlinks: $(HOMEDIR_SYMLINKS)
user-agent: user-agent.txt $(CUSTOM_UA)
vscode-mac: $(VSCODE_MACOS_SYMLINKS)

# ----------------------------------------------------------------------------
# Prerequisites for targets
# ----------------------------------------------------------------------------

# completions

fish/completions/op.fish: /usr/local/bin/op

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

fish/completions/op.fish:
	op completion fish > $@

$(JQ_TARGETS):
	/bin/cp -a -- $< $@

$(SHELL_FILES):
	/usr/bin/install -p -m 0644 -- $< $@

$(HOMEDIR_SYMLINKS):
	/bin/ln -s .config/$< $@

$(VSCODE_MACOS_SYMLINKS):
	/bin/ln -s $< $@

user-agent.txt:
	.vscode/bin/user-agent-get.fish > $@

USER_AGENT = $(shell cat $(CURDIR)/user-agent.txt)

$(CUSTOM_UA):
	m4 -D _HOME_="$(HOME)" -D _USER_AGENT_="$(USER_AGENT)" $< > $@
