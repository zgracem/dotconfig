# -----------------------------------------------------------------------------
# flags
# -----------------------------------------------------------------------------

unalias grep 2>/dev/null

grep()
{
  set -- -EsI -d skip -D skip "$@"
  #       │││  │       └───── silently skip devices
  #       │││  └───────────── silently skip directories
  #       ││└──────────────── ignore binary files
  #       │└───────────────── no errors about missing/unreadable files
  #       └────────────────── use ERE syntax

  # display results in colour if supported
  [ $((TERM_COLOURDEPTH)) -ge 8 ] && set -- --colour=auto "$@"

  # skip version control directories
  set -- \
      --exclude-dir=.git \
      --exclude-dir=.svn \
      "$@"

  command grep "$@"
}

# -----------------------------------------------------------------------------
# function wrappers
# -----------------------------------------------------------------------------

g()
{ # search files in the current directory
  grep --line-number "$@" *
}

gg()
{ # search files and directories in the current directory
  g --recursive "$@"
}
