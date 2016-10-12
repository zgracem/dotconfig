# -----------------------------------------------------------------------------
# error codes -- /usr/include/sysexits.h
# -----------------------------------------------------------------------------

EX_OK=0             # successful termination

EX_USAGE=64         # malformed command
EX_DATAERR=65       # bad user input data
EX_NOINPUT=66       # can't find/read user input file
EX_NOUSER=67        # user DNE
EX_NOHOST=68        # host DNE
EX_UNAVAILABLE=69   # support program/file DNE
EX_SOFTWARE=70      # internal (non-OS) software error detected
EX_OSERR=71         # operating system error detected
EX_OSFILE=72        # can't read/find/process system file
EX_CANTCREAT=73     # can't create user-requested output file
EX_IOERR=74         # error while doing I/O on a file
EX_TEMPFAIL=75      # temporary error, try again later
EX_PROTOCOL=76      # impossible response from remote system
EX_NOPERM=77        # insufficient permission (not file-related)
EX_CONFIG=78        # configuration error

# -----------------------------------------------------------------------------

# declare -ix ${!EX_*}
unset -v ${!EX_*}

errexits()
{
  head -n-8 "${BASH_SOURCE[0]}"
}
