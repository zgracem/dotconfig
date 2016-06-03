# -----------------------------------------------------------------------------
# ~/.config/bash/private.d/countdown.bash
# -----------------------------------------------------------------------------

# export count_to='2016-05-26 23:54 -0600'

if [[ -x $dir_scripts/countdown.sh && -n $count_to ]]; then
  c() {
    local output

    printf -v output "%b " "$esc_red\xe2\x99\xa5$esc_reset"
    output+=$("$dir_scripts/countdown.sh" "$@" "$count_to")

    echo "$output"
  }
  cs() { c -s; }
  cl() { c -l; }
  # alias  c="$dir_scripts/countdown.sh '${count_to}'"
  # alias cl="$dir_scripts/countdown.sh -l '${count_to}'"
  # alias cs="$dir_scripts/countdown.sh -s '${count_to}'"
fi
