# See also ~/.config/bash/bash_completion.d/howto.bash

howto()
{
  local search="$1"

  local -a howto_dirs=(
    "$dir_dropbox/txt/howto"
    "$dir_dropbox/Projects/howto"
  )
  local -a howto_files=()

  local d f; for d in "${howto_dirs[@]}"; do
    for f in "$d/$search".*; do
      [[ -f $f ]] && break 2
      f=""
    done
  done

  if [[ -n $f ]]; then
    printf '%b%s%b\n' "$esc_ul" "$f" "$esc_reset"
    less -F "$f"
  else
    scold "not found: $search"
    return 1
  fi
}

### ZGM rewrote 2017-03-16
# howto()
# {
#   local dir_howto="$HOME/txt/howto"

#   if (( $# == 0 )); then
#     cd "$dir_howto"
#     return
#   elif [[ $1 == -e ]]; then
#     local do_edit='true'
#     shift
#   fi

#   local subject="$@"
#   local file="${dir_howto}/${subject}.markdown"

#   if [[ $do_edit == true ]]; then
#     _z_edit "$file"
#     return 0
#   elif [[ -f $file ]]; then
#     less -F "$file"
#   else
#     local answer='n'

#     printf '%s' "${file/#$HOME/$'~'} does not exist. "
#     read -e -p 'Create it? [y/N] ' answer

#     if [[ $answer =~ [yY] ]]; then
#       _z_edit "$file"
#     fi
#   fi
# }
