include common.mk

install:
	@echo Target ‘$@’ not implemented.

# ----------------------------------------------------------------------------

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
	ln -sfv .config/$< $@
shellfiles: $(SHELL_FILES)

# -----------------------------------------------------------------------------
# Send a fake user-agent string to mask the activity of tools like wget.
# ----------------------------------------------------------------------------

USER_AGENT_VER = 126.0
USER_AGENT = Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:$(USER_AGENT_VER)) Gecko/20100101 Firefox/$(USER_AGENT_VER)

M4_OUTPUT_FILES = \
	aria2/aria2.conf \
	curl/.curlrc \
	wget/wgetrc \
	yt-dlp/config \
	../.private/yt-dlp/config

M4FLAGS  =
M4FLAGS += -D _HOME_="$(HOME)" # yt-dlp only
M4FLAGS += -D _XDG_CONFIG_HOME_="$(XDG_CONFIG_HOME)" # yt-dlp only
M4FLAGS += -D _XDG_CACHE_HOME_="$(XDG_CACHE_HOME)" # wget only
M4FLAGS += -D _USER_AGENT_="$(USER_AGENT)"
$(M4_OUTPUT_FILES): %: %.m4
	m4 $(M4FLAGS) $< >$@

.PHONY: user-agent
user-agent: $(M4_OUTPUT_FILES)
