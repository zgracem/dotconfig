centre()
{ #: - centres text in the terminal window
  #: $ centre "<text>"
  local text="$*"
  local width padding

  if ! width=${COLUMNS-$(tput cols)}; then
    scold "unable to determine terminal width"
    return 70
  fi

  padding=$(( (width - ${#text}) / 2 ))

  if (( padding <= 0 )); then
    scold "text is too long to centre in this window"
    return 65
  else
    padding=$(( padding + ${#text} ))
  fi

  printf "%*s\n" $padding "$text"
}
