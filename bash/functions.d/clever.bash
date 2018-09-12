CLEVER_SAVE_FILE="$HOME/src/clever.bash"

clever()
( #: - saves the previous command for future reference
  #: $ clever [-f <file>] "<comment>"
  #: | -f = save to <file> (default ~/.clever, overrides CLEVER_SAVE_FILE)
  #: | comment = will be placed adjacent to command in save file
  local comment; printf -v comment "# %(%F %T)T" -1
  local prev_cmd=$(history -p '!!')
  local save_file=${CLEVER_SAVE_FILE:-$HOME/.clever}

  if [[ $1 == -f ]]; then
    save_file=$2
    shift 2
  fi

  if (( $# )); then
    comment+=" -- $*"
  fi

  printf '%s\n%s\n\n' "$comment" "$prev_cmd" | tee -a "$save_file"
)
