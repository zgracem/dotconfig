function strip_ansi
    cat $argv | sed -E "s/\x1b\[[0-9]+(;[0-9]+)*m//g"
end
