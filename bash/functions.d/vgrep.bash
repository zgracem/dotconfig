vgrep()
{
  # Use the same colour for grep matches as specified in GREP_COLORS
  local colour=${GREP_COLORS#*ms=}; colour=${colour%%:*}

  declare -p | grep -i "$1" \
  | LESS= LESS_TERMCAP_so=$'\e'"[${colour}m" LESS_TERMCAP_se=$'\e[39m' \
    less -EQUXi +/$'\v'"$1"
  #       │││││ │ └─ highlight matches w/out moving to first one
  #       │││││ └─── initial command: search
  #       ││││└───── case-insensitive searching         (--ignore-case)
  #       │││└────── don't clear the screen on exit     (--no-init)
  #       ││└─────── treat BS, TAB, and CR as special   (--UNDERLINE-SPECIAL)
  #       │└──────── never ring the terminal bell       (--QUIET)
  #       └───────── automatically quit at end of file  (--QUIT-AT-EOF)
}
