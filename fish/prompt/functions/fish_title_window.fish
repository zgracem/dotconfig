function fish_title_window --description "Output the window title"
    switch $TERM_PROGRAM
    case vscode
        prompt_pwd -Z $PWD
    case '*'
        printf "%s@%s: %s" $USER $hostname (prompt_pwd -Z $PWD)
    end
end
