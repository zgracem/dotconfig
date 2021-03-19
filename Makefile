# ----------------------------------------------------------------------------
# Aliases
# ----------------------------------------------------------------------------

# `make` with no arguments executes the first rule in the file.
all:
	@echo Target ‘$@’ not implemented.

# Phony targets that we want to `make <alias>` anyway:
.PHONY: shell-files symlinks user-agent

# ----------------------------------------------------------------------------
# Targets
# ----------------------------------------------------------------------------

SHELL_FILES = \
	~/.bash_logout \
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
	curl/.curlrc \
	wget/wgetrc \
	youtube-dl/config

# Map aliases to groups of target files:
shell-files: $(SHELL_FILES)
symlinks: $(SYMLINKS)
user-agent: user-agent.txt $(CUSTOM_UA)

# ----------------------------------------------------------------------------
# Prerequisites for targets
# ----------------------------------------------------------------------------

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
~/.jq: jq
~/.stow-global-ignore: stow/stow-global-ignore
~/.stowrc: stow/stowrc
~/.tmux.conf: tmux/tmux.conf
~/.vimrc: vim/vimrc

# user-agent

curl/.curlrc: curl/.curlrc.m4
wget/wgetrc: wget/wgetrc.m4
youtube-dl/config: youtube-dl/config.m4
$(CUSTOM_UA): user-agent.txt

# ----------------------------------------------------------------------------
# Recipes for targets
# ----------------------------------------------------------------------------

$(SHELL_FILES):
	/usr/bin/install -p -m 0644 -- $< $@

$(SYMLINKS):
	/bin/ln -s .config/$< $@

user-agent.txt:
	bin/get-user-agent.fish > $@

USER_AGENT = $(shell cat $(CURDIR)/user-agent.txt)

$(CUSTOM_UA):
	m4 -D _HOME_="$(HOME)" -D _USER_AGENT_="$(USER_AGENT)" $< > $@
