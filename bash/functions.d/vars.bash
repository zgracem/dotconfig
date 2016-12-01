vgrep()
{
  declare -p \
  | grep -i "$*" \
  | LESS= LESS_TERMCAP_so=$'\e[95m' LESS_TERMCAP_se=$'\e[39m' \
    less -EQUXi # +"/$*"
  #       ││││└─ case-insensitive searching (--ignore-case)
  #       │││└── don't clear the screen on exit (--no-init)
  #       ││└─── treat BS, TAB, and CR as special (--UNDERLINE-SPECIAL)
  #       │└──── never ring the terminal bell (--QUIET)
  #       └───── automatically quit at end of file (--QUIT-AT-EOF)
}
