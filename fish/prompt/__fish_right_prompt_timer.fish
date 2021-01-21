function __fish_right_prompt_timer -a ms
    set -l time

    if test "$ms" -eq 0
        return 1
    else if test "$ms" -lt 1000
        # < 1.0s
        set time $ms"ms"
    else if test "$ms" -lt 60000
        # < 60.0s
        set time (math -s1 "$ms / 1000")"s"
    else if test "$ms" -lt 3600000
        # < 60.0m
        set time (math -s1 "$ms / 1000 / 60")"m"
    else if test "$ms" -lt 86400000
        # < 24.0h
        set time (math -s1 "$ms / 1000 / 60 / 60")"h"
    else
        # >= 24.0h
        set time (math -s2 "$ms / 1000 / 60 / 60 / 24")"d"
    end

    set_color $fish_prompt_color_duration
    echo -n $time

    set_color normal
    echo -n " "
end
