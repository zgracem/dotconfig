# See also ~/.config/bash/bash_completion.d/howto.bash

howto()
{
  local search="$1"

  local -a howto_dirs=(
    "$HOME/txt/howto"
    "$HOME/Dropbox/Projects/howto"
  )
  local -a howto_files=()

  local d f; for d in "${howto_dirs[@]}"; do
    for f in "$d/$search".*; do
      [[ -f $f ]] && howto_files+=("$f")
    done
  done

  if (( ${#howto_files} > 0 )); then
    for f in "${howto_files[@]}"; do
      printf '%b%s%b\n' "$esc_ul" "${f/#$HOME/$'~'}" "$esc_reset"
      less -F "$f"
    done
  else
    scold "not found: $search"
    return 1
  fi
}
