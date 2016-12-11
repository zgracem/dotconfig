rootme()
{ # temporarily become root for $1 minutes (default is 3)

  local def=5
  local tmout=$(( ${1:-$def} * 60 ))

  # rename window, if applicable
  if _inScreen; then
    printf '%b' "\eksudo${ST}"
  elif _inTmux; then
    tmux rename-window sudo 2>/dev/null
  fi

  # local prompt="${esc_user}%u${esc_reset}@%H"
  # prompt+=" → "
  # prompt+="${esc_brred}%U${esc_reset}@%h"
  # prompt+=$'\n'"Password: "

  sudo \
    ${Z_SOLARIZED:+Z_SOLARIZED=$Z_SOLARIZED} \
    TMOUT=$tmout \
    -s
    # -p "${prompt}" \

  # restore window name
  if _inScreen; then
    printf '%b' "\ekbash${ST}"
  elif _inTmux; then
    tmux set-window-option automatic-rename on 2>/dev/null
  fi
}
