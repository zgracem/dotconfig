# -----------------------------------------------------------------------------
# Generate a fake user-agent string to mask the activity of tools like wget.
# Use Homebrew's recipe for Google Chrome to avoid installing Chrome itself.
# ----------------------------------------------------------------------------

hb-file := /usr/local/Homebrew/Library/Taps/homebrew/homebrew-cask/Casks/google-chrome.rb
ua-file := $(XDG_CACHE_HOME)/dotfiles/user-agent.txt
$(ua-file): $(hb-file) | $(XDG_CACHE_HOME)/dotfiles
	${XDG_CONFIG_HOME}/libexec/user-agent-get.fish > $@
$(XDG_CACHE_HOME)/dotfiles:
	mkdir -p $@

ua-output-files = \
	aria2/aria2.conf \
	curl/.curlrc \
	wget/wgetrc \
	yt-dlp/config \
	../.private/yt-dlp/config

$(ua-output-files): %: %.m4
	m4 -D _HOME_="${HOME}" -D _USER_AGENT_="$(shell cat ${ua-file})" $< > $@
$(ua-output-files): $(ua-file)

# .PHONY: user-agent user-agent-file
# user-agent-file: $(ua-file)
# user-agent: user-agent-file $(ua-output-files)

.PHONY: aria2/ua curl/ua wget/ua yt-dlp/ua
aria2/ua: aria2/aria2.conf
curl/ua: curl/.curlrc
wget/ua: wget/wgetrc
yt-dlp/ua: yt-dlp/config ../private/yt-dlp/config

aria2: aria2/ua
curl: curl/ua
wget: wget/ua
yt-dlp: yt-dlp/ua
yt-dlp/private: yt-dlp/ua
