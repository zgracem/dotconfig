function _errno_sysexit -a num
  test "$num" -ge 64 -a "$num" -le 78
  or return

  # Source: `man 3 sysexits`
  set -l sysexits USAGE DATAERR NOINPUT NOUSER NOHOST UNAVAILABLE SOFTWARE \
                  OSERR OSFILE CANTCREAT IOERR TEMPFAIL PROTOCOL NOPERM CONFIG

  set -l ex_USAGE "The command was used incorrectly"
  set -l ex_DATAERR "The user's input data was incorrect in some way"
  set -l ex_NOINPUT "An input file (not a system file) did not exist or was not readable"
  set -l ex_NOUSER "The user specified did not exist"
  set -l ex_NOHOST "The host specified did not exist"
  set -l ex_UNAVAILABLE "A service, support program, or file is unavailable"
  set -l ex_SOFTWARE "An internal (non-OS) software error has been detected"
  set -l ex_OSERR "An operating system error has been detected"
  set -l ex_OSFILE "A system file does not exist, cannot be opened, or has some sort of error"
  set -l ex_CANTCREAT "A user specified output file cannot be created"
  set -l ex_IOERR "An error occurred while doing I/O on some file"
  set -l ex_TEMPFAIL "Temporary failure, indicating something that is not really an error"
  set -l ex_PROTOCOL "The remote system returned something that was 'not possible' during a protocol exchange"
  set -l ex_NOPERM "You did not have sufficient permission to perform the operation"

  set -l sysexit $sysexits[(math "$num - 63")]
  echo -es "EX_" $sysexit "\n    " (eval "echo \$ex_$sysexit") "."
end
