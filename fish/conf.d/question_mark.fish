# As of fish 3.0.1, this requires `set -Ua fish_features qmark-noglob` to work
# like it does in bash -- i.e. as a bare `?`, not a quoted `"?"`
function '?' --description 'Prints the exit status of the last command'
  set -l last_exit $status

  if test $last_exit -eq 0
    set_color brgreen; echo "true"
    return 0
  end

  set -l signals HUP INT QUIT ILL TRAP ABRT EMT FPE KILL BUS SEGV SYS PIPE ALRM TERM URG STOP TSTP CONT CHLD TTIN TTOU IO XCPU XFSZ VTALRM PROF WINCH PWR USR1 USR2 RTMIN RTMIN+1 RTMIN+2 RTMIN+3 RTMIN+4 RTMIN+5 RTMIN+6 RTMIN+7 RTMIN+8 RTMIN+9 RTMIN+10 RTMIN+11 RTMIN+12 RTMIN+13 RTMIN+14 RTMIN+15 RTMIN+16 RTMAX-15 RTMAX-14 RTMAX-13 RTMAX-12 RTMAX-11 RTMAX-10 RTMAX-9 RTMAX-8 RTMAX-7 RTMAX-6 RTMAX-5 RTMAX-4 RTMAX-3 RTMAX-2 RTMAX-1 RTMAX
  set -l sysexits USAGE DATAERR NOINPUT NOUSER NOHOST UNAVAILABLE SOFTWARE OSERR OSFILE CANTCREAT IOERR TEMPFAIL PROTOCOL NOPERM CONFIG

  set_color brred
  echo -ns "false ($last_exit"

  if test $last_exit -gt 128 -a $last_exit -le 165
    echo -ns "=" $signals[(math "$last_exit - 128")]
  else if test $last_exit -ge 64 -a $last_exit -le 78
    echo -ns "=" $sysexits[(math "$last_exit - 63")]
  end

  echo ")"
  set_color normal
end
