# Aliases that aren't really output files but we can `make` anyway
.PHONY: user-agent

# -----------------------------------------------------------------------------
# custom user-agent string
# -----------------------------------------------------------------------------

# The custom user-agent string (change this periodically)
USER_AGENT := Mozilla/5.0 (Windows NT 6.1) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/69.0.3497.92 Safari/537.36

# List of output files that need a custom user-agent string
CUSTOM_UA := curl/.curlrc wget/wgetrc youtube-dl/config

# Mapping output files to input files
curl/.curlrc: .src/curlrc.m4
wget/wgetrc: .src/wgetrc.m4
youtube-dl/config: .src/youtube-dl.m4

# Define the action that creates all output files
$(CUSTOM_UA):
	mkdir -p $(XDG_CONFIG_HOME)/$(firstword $(subst /, ,$@))
	m4 -D _USER_AGENT_="$(USER_AGENT)" $< > $@

# Map the action to a short name so we can `make user-agent`
user-agent: $(CUSTOM_UA)
