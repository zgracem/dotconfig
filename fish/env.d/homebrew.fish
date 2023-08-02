# See also: $XDG_CONFIG_HOME/homebrew/brew.env
in-path brew; or exit

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
    set -gx HOMEBREW_BROWSER (command -s echo)
end
