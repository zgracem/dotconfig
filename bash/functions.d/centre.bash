centre()
{
  local text="$*"
  local width padding

  if ! width=${COLUMNS-$(tput cols)}; then
    scold "unable to determine terminal width"
    return 1
  fi

  padding=$(( (width - ${#text}) / 2 ))

  if (( padding <= 0 )); then
    scold "text is too long to centre in this window"
    return 1
  else
    padding=$(( padding + ${#text} ))
  fi

  printf "%*s\n" $padding "$text"
}
