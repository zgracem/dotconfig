# See $__fish_config_dir/conf.d/question-mark.fish
function bind_qmark
    switch (commandline --current-token)[-1]
        case "?"
            commandline --function backward-delete-char backward-delete-char
            commandline --append "; ?"
            commandline --function end-of-line repaint
        case "*"
            commandline --insert "?"
    end
end
