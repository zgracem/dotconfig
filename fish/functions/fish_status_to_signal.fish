# Overrides $__fish_data_dir/functions/fish_status_to_signal.fish
# because different systems have different names for signals above 134.
function fish_status_to_signal -d "Convert an exit code into a named signal, if appropriate"
    argparse -X1 'i/int' -- $argv; or return

    set -l code $argv[1]
    test -z "$code"; or test $code -eq 0; and return 0

    if test $code -gt 128; and not set -q _flag_int
        set -l signals HUP INT QUIT ILL TRAP ABRT

        if test $code -gt 134
            set -a signals (command kill -l | string upper | string split " ")
        end

        if set -q signals[(math $code % 128)]
            set code $signals[(math $code % 128)]
        end
    end

    echo -n $code
end
