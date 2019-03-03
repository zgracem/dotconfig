# As of fish 3.0.2, this requires `set -Ua fish_features qmark-noglob` to work
# like it does in bash -- i.e. as a bare `?`, not a quoted `"?"`
function '?' --description 'Prints the exit status of the last command'
  set -l last_exit $status

  if test $last_exit -eq 0
    echo -ns (set_color brgreen) "OK"
    echo (set_color green) "($last_exit)"
    set_color normal
    return
  end

  # Source: `kill -l`
  set -l signals  HUP INT QUIT ILL TRAP ABRT EMT FPE KILL BUS SEGV SYS PIPE \
                  ALRM TERM URG STOP TSTP CONT CHLD TTIN TTOU IO XCPU XFSZ \
                  VTALRM PROF WINCH INFO USR1 USR2
  # Source: `man 3 sysexits`
  set -l sysexits USAGE DATAERR NOINPUT NOUSER NOHOST UNAVAILABLE SOFTWARE \
                  OSERR OSFILE CANTCREAT IOERR TEMPFAIL PROTOCOL NOPERM CONFIG

  set_color brred

  if test $last_exit -gt 128 -a $last_exit -le 165
    echo -ns "SIG" $signals[(math "$last_exit - 128")]
  else if test $last_exit -ge 64 -a $last_exit -le 78
    echo -ns "EX_" $sysexits[(math "$last_exit - 63")]
  else
    echo -ns "false"
  end

  echo (set_color red) "($last_exit)"
  set_color normal
end
