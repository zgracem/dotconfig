# -----------------------------------------------------------------------------
# ~/.config/bash/private.d/countdown.bash
# -----------------------------------------------------------------------------

export liz="2016-07-21 16:51"

if [[ -x $dir_scripts/countdown.sh && -n $liz ]]; then
  liz() {
    local output

    printf -v output "%b " "$esc_red\xe2\x99\xa5$esc_reset"
    output+=$("$dir_scripts/countdown.sh" "$@" "$liz")

    echo "$output"
  }
fi
