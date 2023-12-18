function pbhist --description "Copy the last command to clipboard"
    history -n1 | tbcopy | fish_indent --ansi
end
