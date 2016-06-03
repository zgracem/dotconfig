# -----------------------------------------------------------------------------
# ~/.config/bash/private.bash
# you should not be reading this
# -----------------------------------------------------------------------------
# countdown
# -----------------------------------------------------------------------------

# export countTo='2016-05-26 23:54 -0600'

if [[ -x $dir_scripts/countdown.sh && -n $countTo ]]; then
  c() {
    local output

    printf -v output "%b " "$esc_red\xe2\x99\xa5$esc_reset"
    output+=$("$dir_scripts/countdown.sh" "$@" "$countTo")

    echo "$output"
  }
  cs() { c -s; }
  cl() { c -l; }
  # alias  c="$dir_scripts/countdown.sh '${countTo}'"
  # alias cl="$dir_scripts/countdown.sh -l '${countTo}'"
  # alias cs="$dir_scripts/countdown.sh -s '${countTo}'"
fi

# -----------------------------------------------------------------------------

# # supplementary files
if [[ -d $dir_config/bash/private.d ]]; then
    for file in "$dir_config"/bash/private.d/*.bash; do
        [[ -f $file ]] && . "$file"
    done
else
    return 0
fi
