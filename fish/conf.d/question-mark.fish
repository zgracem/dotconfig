# Version check because it's located in `conf.d`
fish-is-older-than 3.0 # released Dec 2018
and return

# Requires `set -Ua fish_features qmark-noglob` to work like it does in bash --
# i.e. as a bare `?`, not a quoted `"?"`
status test-feature qmark-noglob
or set -Ua fish_features qmark-noglob

function '?' --description 'Prints the exit status of the last command'
    set -f code $status

    if test $code -eq 0
        set -f color green
    else if test $code -eq 141
        # SIGPIPE is not always an error
        set -f color yellow
    else
        set -f color red
    end

    set_color "br$color"

    if test $code -eq 0
        echo -n OK
    else
        echo -n (my-status-to-signal $code)
    end

    set_color $color
    echo -n " ($code)"
    set_color normal
    echo

    return $code
end
