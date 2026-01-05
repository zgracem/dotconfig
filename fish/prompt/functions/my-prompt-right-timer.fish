function my-prompt-right-timer -a ms
    set_color $fish_color_prompt_duration
    __fish_human_readable_ms $ms

    set_color normal
    echo -n " "
end

function __fish_human_readable_ms -a ms
    if test $ms -lt 1000
        # < 1.0s
        set -f time $ms"ms"
    else if test $ms -lt 60000
        # < 60.0s
        set -f time (math -s1 "$ms / 1000")"s"
    else if test $ms -lt 3600000
        # < 60.0m
        set -f time (math -s1 "$ms / 1000 / 60")"m"
    else if test $ms -lt 86400000
        # < 24.0h
        set -f time (math -s1 "$ms / 1000 / 60 / 60")"h"
    else
        # >= 24.0h
        set -f time (math -s2 "$ms / 1000 / 60 / 60 / 24")"d"
    end

    echo -n $time
end
