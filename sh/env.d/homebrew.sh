test -f "$XDG_CONFIG_HOME/homebrew/brew.env" && \
grep -E '^HOMEBREW_[A-Z_]+=.*$' "$XDG_CONFIG_HOME/homebrew/brew.env" \
| while read -r line; do eval "export $line"; done
