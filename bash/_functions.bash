# -----------------------------------------------------------------------------
# ~/.config/bash/_functions.bash
# -----------------------------------------------------------------------------

p()
{ #: -- print each argument to stdout on its own line
  printf '%s\n' "$@"
}

# -----------------------------------------------------------------------------
# I/O functions
# -----------------------------------------------------------------------------

scold()
{ #: -- echo to standard error
  printf '%b\n' "$*" >&2
}

verbose()
{ #: -- prints a message, conditional on the value of $VERBOSITY
  #
  #: $ verbose [level] "message"
  #
  # Examples:
  #    verbose 1 "be slightly verbose"
  #    verbose 2 "more verbose"
  #    verbose 3 "quite verbose"
  #    verbose "any level except zero"

  local level=1

  if [[ $1 == +([0-9]) ]]; then
    level=$1
    shift
  fi

  if (( VERBOSITY >= level )); then
    printf '%b\n' "$@"
  fi
}

# -----------------------------------------------------------------------------
# true/false functions
# -----------------------------------------------------------------------------

_isFunction()
{ #: -- returns 0 if $1 is defined as a function
  declare -f "$1" >/dev/null
}

_inScreen()
{ #: -- returns 0 if inside a GNU screen session
  [ -n "$STY" ] && [ -p "$SCREENDIR/$STY" ]
}

_inTmux()
{ #: -- returns 0 if inside a tmux session
  [ -S "${TMUX%%,*}" ]

  # When a new session is created, tmux sets the environment variable TMUX to
  # "<socket>,<pid>,<session>". So we strip everything after (and including)
  # the first comma and test whether the resulting path is indeed a socket.
}
