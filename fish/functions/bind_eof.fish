function bind_eof
    set -l cmd (set_color $fish_color_command)"exit"(set_color normal)
    echo >&2 "Use $cmd to leave the shell."
    commandline --function repaint
end
