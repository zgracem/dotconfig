# -----------------------------------------------------------------------------
# ~/.config/bash/_functions.bash
# -----------------------------------------------------------------------------

# load function self-documentation library
# shellcheck source=../../lib/bash/fxdoc/_init.bash
. ~/lib/bash/fxdoc/_init.bash

e()
{ #: -- print each argument to stdout on its own line
  printf '%s\n' "$@"
}

x() 
{ #: -- execute a command for each argument passed on stdin
  #: $ <input> | x <command>
  xargs -r -d'\n' "$@"; 
  #      │  └── delimit w/ newline only (instead of all whitespace chars)
  #      └───── do not run if input is empty
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

### ZGM disabled 2017-06-15 -- separately declared in ~/.config/sh/profile.sh
#
# _inPath()
# { #: -- returns 0 if $1 is installed in $PATH
#   command -v "$1" >/dev/null
# }
#
# _isGNU()
# { #: -- returns 0 if $1 uses GNU switches
#   command "$1" --version >/dev/null 2>&1
# }
##############################################################################

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

# -----------------------------------------------------------------------------
# other
# -----------------------------------------------------------------------------

_require()
{ #: -- like _inPath(), but fails with an error message
  _inPath "$1" && return

  command_not_found_handle "$1"
  return 127
}
