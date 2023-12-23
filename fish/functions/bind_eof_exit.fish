set --erase --global __eof_press __eof_count __eof_timer

function bind_eof_exit
    set -l ignore_eof 3
    set -l timeout_eof 5

    set -l msg "Press Ctrl+D $ignore_eof times in $timeout_eof seconds to exit."

    # set timestamp
    set -l now (date +%s)
    set -gq __eof_press; or set -g __eof_press $now

    # reset timer if expired
    if test (math "$now - $__eof_press") -gt $timeout_eof
        echo $msg
        commandline --function repaint
        set -g __eof_press $now
        set -g __eof_count 0
    end

    # increment counter; start first if necessary
    set -gq __eof_count; or set -g __eof_count 0
    set -g __eof_count (math "$__eof_count + 1")

    # hasn't been pressed enough times
    if test $__eof_count -lt $ignore_eof
        echo $msg
        commandline --function repaint
        return 1
    end

    # byeeee
    exit
end
