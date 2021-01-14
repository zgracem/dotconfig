# Overrides $__fish_data_dir/functions/fish_status_to_signal.fish
# because different systems have different names for signals above 134.
function fish_status_to_signal --description "Convert an exit code into a named signal, if appropriate" -a code
    if test (count $argv) -ne 1
        echo "expected single integer argument" >&2
        return 1
    end

    if test $code -eq 0
        return 0
    end

    set -l output $code

    if test $code -gt 128
        set -l signals HUP INT QUIT ILL TRAP ABRT

        if test $code -gt 134
            for ext_sig in (command kill -l | string upper | string split " ")
                contains $ext_sig $signals; or set -a signals $ext_sig
            end
        end

        if test $code -le (math (count $signals) + 128)
            set output $signals[(math $code - 128)]
        end
    end

    echo $output
end
