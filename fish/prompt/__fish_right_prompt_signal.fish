function __fish_right_prompt_signal --description 'Converts an exit code into a named signal or sysexit'
  set -l code $argv[1]
  set -l signals HUP INT QUIT ILL TRAP ABRT EMT FPE KILL BUS SEGV SYS PIPE ALRM TERM URG STOP TSTP CONT CHLD TTIN TTOU IO XCPU XFSZ VTALRM PROF WINCH PWR USR1 USR2 RTMIN RTMIN+1 RTMIN+2 RTMIN+3 RTMIN+4 RTMIN+5 RTMIN+6 RTMIN+7 RTMIN+8 RTMIN+9 RTMIN+10 RTMIN+11 RTMIN+12 RTMIN+13 RTMIN+14 RTMIN+15 RTMIN+16 RTMAX-15 RTMAX-14 RTMAX-13 RTMAX-12 RTMAX-11 RTMAX-10 RTMAX-9 RTMAX-8 RTMAX-7 RTMAX-6 RTMAX-5 RTMAX-4 RTMAX-3 RTMAX-2 RTMAX-1 RTMAX
  set -l sysexits USAGE DATAERR NOINPUT NOUSER NOHOST UNAVAILABLE SOFTWARE OSERR OSFILE CANTCREAT IOERR TEMPFAIL PROTOCOL NOPERM CONFIG

  if test $code -gt 128 -a $code -le 165
    echo -n $signals[(math "$code - 128")]
  else if test $code -ge 64 -a $code -le 78
    echo -n $sysexits[(math "$code - 63")]
  else
    echo -n $code
  end
end
