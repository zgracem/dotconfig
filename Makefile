include common.mk

install:
	@echo Target ‘$@’ not implemented.

# ----------------------------------------------------------------------------
# Create symlinks in $HOME
# ----------------------------------------------------------------------------

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

SYMLINKS  =
SYMLINKS += ~/.minirc.dfl
SYMLINKS += ~/.rbenv
SYMLINKS += ~/.stow-global-ignore
~/.minirc.dfl: minicom/minirc.dfl
~/.rbenv: ../.local/share/rbenv
~/.stow-global-ignore: stow/.stow-global-ignore

$(SHELL_FILES) $(SYMLINKS):
	$(LN) .config/$< $@

.PHONY: shellfiles symlinks
shellfiles: $(SHELL_FILES)
symlinks: $(SYMLINKS)

~/.basilisk_ii_prefs: .basilisk_ii_prefs
	$(INSTALL_DATA) -- $< $@

# -----------------------------------------------------------------------------
# Send a fake user-agent string to mask the activity of tools like wget.
# ----------------------------------------------------------------------------

USER_AGENT_VER = 131.0
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

$(M4_OUTPUT_FILES): $(CURDIR)/Makefile

.PHONY: user-agent
user-agent: $(M4_OUTPUT_FILES)

.PHONY: print-user-agent
print-user-agent:
	@echo "$(USER_AGENT)"
