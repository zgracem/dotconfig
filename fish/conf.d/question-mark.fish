# Version check because it's located in `conf.d`
fish-is-older-than 3.0 # released Dec 2018
and return

# Requires `set -Ua fish_features qmark-noglob` to work like it does in bash --
# i.e. as a bare `?`, not a quoted `"?"`
status test-feature qmark-noglob
or set -Ua fish_features qmark-noglob

function '?' --description 'Prints the exit status of the last command'
    set -l last_exit $status

    if test $last_exit -eq 0
        set_color brgreen
        echo -n OK
        set_color green
        echo -n " ($last_exit)"
        set_color normal
        return
    end

    # Source: `man 3 sysexits`
    set -l sysexits USAGE DATAERR NOINPUT NOUSER NOHOST UNAVAILABLE SOFTWARE \
        OSERR OSFILE CANTCREAT IOERR TEMPFAIL PROTOCOL NOPERM CONFIG

    set_color brred

    if test $last_exit -gt 128 -a $last_exit -le 159
        echo -ns (fish_status_to_signal $last_exit)
    else if test $last_exit -ge 64 -a $last_exit -le 78
        echo -ns EX_ $sysexits[(math "$last_exit - 63")]
    else
        echo -ns false
    end

    set_color red
    echo "($last_exit)"
    set_color normal
end
