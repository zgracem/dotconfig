# -----------------------------------------------------------------------------
# ~/.config/fish/bindings.fish
# -----------------------------------------------------------------------------

# bash-like `!!` and `!$` shortcuts
bind '!' bind_bang
bind '$' bind_dollar

# Ctrl-D exits if pressed multiple times quickly (like bash)
bind \cd bind_eof_exit

# Ctrl-/ redraws current line, not whole screen
bind \c_ 'commandline -f repaint'

# Source: https://github.com/fish-shell/fish-shell/issues/8336#issuecomment-937370264
# Right Arrow (→) accepts a single word from the autosuggestion
bind \e\[C bind_smart_forward
# Shift-Right Arrow accepts the entire autosuggestion
bind \e\[1\;2C forward-char

# Disable bindings from $__fish_data_dir/functions/__fish_shared_key_bindings.fish
bind --erase \cx \cv
