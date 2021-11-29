command -sq brew; or exit

# Don't display hints about setting environment variables
set -gx HOMEBREW_NO_ENV_HINTS 1

# Only auto-update every 10 minutes (default is 5 minutes)
set -gx HOMEBREW_AUTO_UPDATE_SECS 600

# Use `bat` for `brew cat`
set -gx HOMEBREW_BAT 1
set -gx HOMEBREW_BAT_CONFIG_PATH $XDG_CONFIG_HOME/bat/config_homebrew

# `brew bundle`
set -gx HOMEBREW_BUNDLE_FILE $XDG_CONFIG_HOME/brew/Brewfile

# Delete cached files after 30 days (default is 120 days)
set -gx HOMEBREW_CLEANUP_MAX_AGE_DAYS 30

# Print install times for each formula
set -gx HOMEBREW_DISPLAY_INSTALL_TIMES 1

# File listing default formulae for `brew livecheck` to check
set -gx HOMEBREW_LIVECHECK_WATCHLIST $XDG_CONFIG_HOME/brew/livecheck_watchlist

# `brew update` will only mention installed formulae
set -gx HOMEBREW_UPDATE_REPORT_ONLY_INSTALLED 1

# Always use the latest stable tag (even if developer commands have been run)
set -gx HOMEBREW_UPDATE_TO_TAG 1

# Check for macOS/iOS terminal clients w/ emoji support
switch $TERM_PROGRAM
    case Apple_Terminal 'iTerm*' Prompt_2 vscode
        switch (date +%B)
            case October
                # https://twitter.com/MacHomebrew/status/783028298351730688
                set -gx HOMEBREW_INSTALL_BADGE "🎃"
            case December
                set -gx HOMEBREW_INSTALL_BADGE "🎁"
        end
    case "*"
        set -gx HOMEBREW_NO_EMOJI 1
end

if set -q SSH_CONNECTION
    # make `brew home` et al. print the URL instead of launching a browser
    set -gx HOMEBREW_BROWSER (type -P echo)
end
