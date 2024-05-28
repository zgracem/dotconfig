function art -d "Find art by name" -a search
    set -f art_dir "$HOME/Library/Mobile Documents/com~apple~CloudDocs/Images/art"

    fd --type=file \
        --base-directory=$art_dir \
        --fixed-strings --strip-cwd-prefix \
        $search \
        --exec-batch eza --long --no-quotes --sort=modified --reverse
end
