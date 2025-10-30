function my-status-to-signal -d "Convert exit code to signal name" -a code
    # Source: `man 3 sysexits`
    set -f sysexits USAGE DATAERR NOINPUT NOUSER NOHOST UNAVAILABLE SOFTWARE \
        OSERR OSFILE CANTCREAT IOERR TEMPFAIL PROTOCOL NOPERM CONFIG
    # Source: <https://github.com/fish-shell/fish-shell/blob/master/src/builtins/shared.rs>
    set -f fishexits EXPAND_ERROR READ_TOO_MUCH ILLEGAL_CMD UNMATCHED_WILDCARD \
        125_unused NOT_EXECUTABLE CMD_UNKNOWN

    if test $code -gt 128 -a $code -lt 160
        fish_status_to_signal $code
    else if test $code -gt 120 -a $code -lt 128
        echo -s "STATUS_" $fishexits[(math "$code - 120")]
    else if test $code -gt 63 -a $code -lt 79
        echo -s "EX_" $sysexits[(math "$code - 63")]
    else
        echo $code
    end
end
