# Overrides $__fish_data_dir/functions/fish_status_to_signal.fish
# and $__fish_data_dir/functions/__fish_make_completion_signals.fish
# because different systems have different names for signals above 134.
#
# Fixed for 3.4 in fish-shell/pull/8530, but I prefer my implementation.
function __fish_make_completion_signals
    set -q __my_kill_signals; and return
    set -g __my_kill_signals HUP INT QUIT ILL TRAP ABRT
    set -a __my_kill_signals (command kill -l | string upper | string split " ")
end

function fish_status_to_signal -d "Convert an exit code into a named signal, if appropriate"
    argparse -X1 'i/int' -- $argv; or return

    __fish_make_completion_signals

    set -l code $argv[1]
    test -z "$code"; or test $code -eq 0; and return 0

    if test $code -gt 128; and not set -q _flag_int
        set -l idx (math $code % 128)
        if set -q __my_kill_signals[$idx]
            set code $__my_kill_signals[$idx]
        end
    end

    echo -n $code
end
