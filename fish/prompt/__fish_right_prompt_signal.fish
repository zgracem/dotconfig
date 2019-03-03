function __fish_right_prompt_signal --description 'Converts an exit code into a named signal or sysexit' -a code
  # Source: `kill -l`
  set -l signals  HUP INT QUIT ILL TRAP ABRT EMT FPE KILL BUS SEGV SYS PIPE \
                  ALRM TERM URG STOP TSTP CONT CHLD TTIN TTOU IO XCPU XFSZ \
                  VTALRM PROF WINCH INFO USR1 USR2
  # Source: `man 3 sysexits`
  set -l sysexits USAGE DATAERR NOINPUT NOUSER NOHOST UNAVAILABLE SOFTWARE \
                  OSERR OSFILE CANTCREAT IOERR TEMPFAIL PROTOCOL NOPERM CONFIG

  if test $code -gt 128 -a $code -le 165
    set exit $signals[(math "$code - 128")]
  else if test $code -ge 64 -a $code -le 78
    set exit $sysexits[(math "$code - 63")]
  else
    set exit $code
  end

  echo -n "$exit "
end
