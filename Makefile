# ----------------------------------------------------------------------------
# Aliases
# ----------------------------------------------------------------------------

# `make` with no arguments executes the first rule in the file.
all:
	@echo Target ‘$@’ not implemented.

# Phony targets that we want to `make <alias>` anyway:
.PHONY: completions shell-files symlinks user-agent

# ----------------------------------------------------------------------------
# Targets
# ----------------------------------------------------------------------------

COMPLETIONS = \
	fish/completions/op.fish

SHELL_FILES = \
	~/.bash_profile \
	~/.bash_sessions_disable \
	~/.bashrc \
	~/.hushlogin \
	~/.profile

SYMLINKS = \
	~/.editorconfig \
	~/.jq \
	~/.stow-global-ignore \
	~/.stowrc \
	~/.tmux.conf \
	~/.vimrc

CUSTOM_UA = \
	aria2/aria2.conf \
	curl/.curlrc \
	wget/wgetrc \
	yt-dlp/config \
	../.private/yt-dlp/config

# Map aliases to groups of target files:
completions: $(COMPLETIONS)
shell-files: $(SHELL_FILES)
symlinks: $(SYMLINKS)
user-agent: user-agent.txt $(CUSTOM_UA)

# ----------------------------------------------------------------------------
# Prerequisites for targets
# ----------------------------------------------------------------------------

# completions

fish/completions/op.fish: /usr/local/bin/op

# shell-files

SKEL = .skel
~/.bash_profile: $(SKEL)/.bash_profile
~/.bash_sessions_disable: $(SKEL)/.bash_sessions_disable
~/.bashrc: $(SKEL)/.bashrc
~/.hushlogin: $(SKEL)/.hushlogin
~/.profile: $(SKEL)/.profile

# symlinks

~/.editorconfig: .editorconfig
~/.jq: jq
~/.stow-global-ignore: stow/stow-global-ignore
~/.stowrc: stow/stowrc
~/.tmux.conf: tmux/tmux.conf
~/.vimrc: vim/vimrc

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

$(SHELL_FILES):
	/usr/bin/install -p -m 0644 -- $< $@

$(SYMLINKS):
	/bin/ln -s .config/$< $@

user-agent.txt:
	bin/user-agent-get.fish > $@

USER_AGENT = $(shell cat $(CURDIR)/user-agent.txt)

$(CUSTOM_UA):
	m4 -D _HOME_="$(HOME)" -D _USER_AGENT_="$(USER_AGENT)" $< > $@
