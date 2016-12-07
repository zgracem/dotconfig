# -----------------------------------------------------------------------------
# flags
# -----------------------------------------------------------------------------

unalias grep 2>/dev/null

grep()
{
  set -- -EsI "$@"
  #       ││└──────── ignore binary files
  #       │└───────── no errors about missing/unreadable files
  #       └────────── use ERE syntax

  set -- -d skip -D skip "$@"
  #       │       └── silently skip devices
  #       └────────── silently skip directories

  # display results in colour
  (( TERM_COLOURDEPTH >= 8 )) && set -- --colour=auto "$@"

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
