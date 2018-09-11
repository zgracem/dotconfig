# Homebrew
# >> http://brew.sh/

HOMEBREW_BREW_FILE="$(command -v brew)"
if [ -n "$HOMEBREW_BREW_FILE" ]; then
  export HOMEBREW_BREW_FILE
else
  unset -v HOMEBREW_BREW_FILE
  return
fi

export HOMEBREW_PREFIX="${HOMEBREW_BREW_FILE%/bin/brew}"

if [ "${HOMEBREW_PREFIX#*linuxbrew}" != "$HOMEBREW_PREFIX" ]; then
  # HOME-based paths for Linuxbrew
  export HOMEBREW_CACHE="$XDG_CACHE_HOME/homebrew"
  export HOMEBREW_LOGS="$HOME/var/log/homebrew"
  export HOMEBREW_TEMP="$XDG_RUNTIME_DIR/homebrew"
fi

# Only automatically `brew update` once an hour
export HOMEBREW_AUTO_UPDATE_SECS=$(( 60 * 60 ))

# Clean up old versions when upgrading (same as `brew upgrade --cleanup`)
export HOMEBREW_UPGRADE_CLEANUP=1

# Check for macOS/iOS terminal clients w/ emoji support
case $TERM_PROGRAM in
  Apple_Terminal|iTerm*|Prompt_2|Coda)
    case "$(date +%B)" in
      "October")
        # Pumpkin Spice Homebrew!
        # >> https://twitter.com/MacHomebrew/status/783028298351730688
        export HOMEBREW_INSTALL_BADGE=$'\xf0\x9f\x8e\x83' # 🎃
        ;;
      "December")       
        # Santa brought me a bunch of software upgrades 
        export HOMEBREW_INSTALL_BADGE=$'\xf0\x9f\x8e\x81' # 🎁
        ;;
    esac
    ;;
  *)
    # don't print beer emoji
    export HOMEBREW_NO_EMOJI=true
    ;;
esac

if [ -n "$SSH_CONNECTION" ]; then
  # make `brew home` et al. print the URL instead of launching a browser
  export HOMEBREW_BROWSER=/bin/echo
fi
