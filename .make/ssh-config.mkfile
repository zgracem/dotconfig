# Aliases that aren't really output files but we can `make` anyway
.PHONY: ssh-config

PROXY_SERVER := 127.0.0.1
PROXY_PORT := 8080

# Directories to build
~/.local/ ~/.local/config/ ~/.ssh/:
	mkdir -p $@

# Hostnames that get their own config files
SSH_HOSTS := web538 web636 WS144966

# List of output files
SSH_FILES := ssh/config $(foreach host,$(SSH_HOSTS),local/$(host)/config/ssh_config)

# Define the template as a prerequisite for all output files
$(SSH_FILES): .src/ssh_config.erb

# Where and how to build the main SSH config file
ssh/config: | ~/.ssh/
	PROXY_SERVER=$(PROXY_SERVER) PROXY_PORT=$(PROXY_PORT) \
	erb -T- $< > $@

# Where and how to build local config files
local/%/config/ssh_config: | ~/.local/config/
	PROXY_SERVER=$(PROXY_SERVER) PROXY_PORT=$(PROXY_PORT) \
	SSH_HOST=$* \
	erb -T- $< > $@

# `make ssh-config` builds config files and symlinks the correct one to ~/.ssh
ssh-config: $(SSH_FILES)
	-if [ -f ~/.local/config/ssh_config ]; then \
		ln -s "../.local/config/ssh_config" ~/.ssh/config; \
	else \
		ln -s "../.config/ssh/config" ~/.ssh/config; \
	fi
