# -----------------------------------------------------------------------------
# ~zozo/.config/sh/profile
# -----------------------------------------------------------------------------

if [ -d "$HOME/.config/sh/profile.d" ]; then
    for file in "$HOME/.config/sh/profile.d/"*.sh; do
        if [ -r "$file" ]; then
            # debug_echo "# sourcing $file..."
            . "$file"
        fi
    done
fi
