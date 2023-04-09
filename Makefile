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
