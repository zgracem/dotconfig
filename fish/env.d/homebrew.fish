command -q brew; or return

# Read brew.env
while read line
    eval (string replace -rf '(HOMEBREW_[^=]+)=(.*)' 'set -gx $1 $2' $line)
end <"$XDG_CONFIG_HOME/homebrew/brew.env"

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
