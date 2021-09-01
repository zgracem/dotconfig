function fish_user_key_bindings
    # This only works if [ $fish_key_bindings = "fish_default_key_bindings" ].
    # TODO: Make this work in vi or hybrid mode.
    bind '!' bind_bang
    bind '$' bind_dollar

    # Ctrl-D exits if pressed multiple times quickly (like bash)
    bind \cd bind_eof_exit

    # Ctrl-/ redraws current line, not whole screen
    bind \c_ 'commandline -f repaint'
end
