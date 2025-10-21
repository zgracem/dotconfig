function fish_title_window --description "Output the window title"
    switch $TERM_PROGRAM
    case vscode
        my-prompt-pwd -Z $PWD
    case '*'
        printf "%s@%s: %s" $USER $hostname (my-prompt-pwd -Z $PWD)
    end
end
