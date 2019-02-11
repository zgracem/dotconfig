rootme()
{ # temporarily become root for $1 minutes (default is 3)

  local def=5
  local tmout=$(( ${1:-$def} * 60 ))

  # rename window, if applicable
  if _inScreen; then
    printf '%b' "\\eksudo${ST}"
  elif _inTmux; then
    tmux rename-window sudo 2>/dev/null
  fi

  sudo TMOUT=$tmout -s

  # restore window name
  if _inScreen; then
    printf '%b' "\\ekbash${ST}"
  elif _inTmux; then
    tmux set-window-option automatic-rename on 2>/dev/null
  fi
}
