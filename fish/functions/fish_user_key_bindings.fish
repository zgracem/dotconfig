function fish_user_key_bindings
    # bash-like `!!` and `!$` shortcuts
    bind '!' bind_bang
    bind '$' bind_dollar

    # `xyz ??` -> `xyz; ?`
    bind '?' bind_qmark

    # Ctrl-D exits if pressed multiple times quickly (like bash)
    bind \cD bind_eof_exit

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
        bind \cC __fish_cancel_commandline
    end

    # Source: https://github.com/fish-shell/fish-shell/issues/8336#issuecomment-937370264
    if fish-is-newer-than 4.0
        # Right Arrow (→) accepts a single word from the autosuggestion
        bind right bind_smart_forward
        # Shift-Right Arrow accepts the entire autosuggestion
        bind shift-right forward-char
    else
        # backwards compatible, but hard to read
        bind \e\[C bind_smart_forward
        bind \e\[1\;2C forward-char
    end

    # Disable bindings from $__fish_data_dir/functions/__fish_shared_key_bindings.fish
    bind --erase --preset \cX
    bind --erase --preset \cV
end
