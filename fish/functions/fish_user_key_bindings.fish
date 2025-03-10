function fish_user_key_bindings
    # bash-like `!!` and `!$` shortcuts
    bind '!' bind_bang
    bind '$' bind_dollar

    # `xyz ??` -> `xyz; ?`
    bind '?' bind_qmark

    # Ctrl-D exits if pressed multiple times quickly (like bash)
    bind \cd bind_eof_exit

    # Ctrl-/ redraws current line, not whole screen
    set -l redraw_cmd 'commandline -f repaint'
    if fish-is-newer-than 4.0
        if string match -q vscode $TERM_PROGRAM
            bind ctrl-_ $redraw_cmd
        else
            bind ctrl-/ $redraw_cmd
        end
    else
        bind \c_ $redraw_cmd
    end

    # Ctrl-C cancels without erasing the commandline (restores pre-4.0 behaviour)
    # Source: https://github.com/fish-shell/fish-shell/issues/10935
    if fish-is-newer-than 4.0
        bind ctrl-c __fish_cancel_commandline
    end

    # Source: https://github.com/fish-shell/fish-shell/issues/8336#issuecomment-937370264
    # Right Arrow (→) accepts a single word from the autosuggestion
    bind \e\[C bind_smart_forward
    # Shift-Right Arrow accepts the entire autosuggestion
    bind \e\[1\;2C forward-char

    # Disable bindings from $__fish_data_dir/functions/__fish_shared_key_bindings.fish
    bind --erase \cx
    bind --erase \cv
end
