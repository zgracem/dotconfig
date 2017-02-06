# -----------------------------------------------------------------------------
# ~/.config/bash/_functions.bash
# -----------------------------------------------------------------------------

e()
{ # print each argument to stdout on its own line
  printf "%s\n" "$@"
}

# -----------------------------------------------------------------------------
# I/O functions
# -----------------------------------------------------------------------------

scold()
{ # echo to standard error
  printf "%b\n" "$*" >&2
}

verbose()
{ # prints a message, conditional on the value of $VERBOSITY
  #
  # Usage: verbose [level] "message"
  #
  #   verbose 1 "slightly verbose"
  #   verbose 2 "more verbose"
  #   verbose 3 "quite verbose"
  #   verbose "any level except zero"

  local level=1

  if [[ $1 == +([0-9]) ]]; then
    level=$1
    shift
  fi

  if (( VERBOSITY >= level )); then
    printf "%b\n" "$@"
  fi
}

# -----------------------------------------------------------------------------
# true/false functions
# -----------------------------------------------------------------------------

_inPath()
{ # exits 0 if $1 is installed in $PATH
  command -v "$1" >/dev/null
}

_isGNU()
{ # exits 0 if $1 uses GNU switches
  command "$1" --version >/dev/null 2>&1
}

_isFunction()
{ # exits 0 if $1 is defined as a function
  declare -f "$1" >/dev/null
}

_inScreen()
{ # exits 0 if inside a GNU screen session
  [ -n "$STY" ] && [ -p "$SCREENDIR/$STY" ]
}

_inTmux()
{ # exits 0 if inside a tmux session
  [ -S "${TMUX%%,*}" ]

  # When a new session is created, tmux sets the environment variable TMUX to
  # "<socket>,<pid>,<session>". So we strip everything after (and including)
  # the first comma and test whether the resulting path is indeed a socket.
}
