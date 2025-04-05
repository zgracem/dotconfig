function no_color
    set -f regex \e'\[(?:\d+(?:;\d+)*)?m|'\e'\(B'
    if isatty stdin
        string replace -ar $regex '' $argv
    else
        cat | string replace -ar $regex ''
    end
end
