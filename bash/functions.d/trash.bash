trash()
{ #: - move file(s) to the Trash
  #: $ trash <file> [<file2> ...]
  if _inPath trash; then
    trash "$@"
    return
  fi

  if [[ $PLATFORM == mac ]]; then
    local f; for f in "$@"; do
      local filename
      if filename=$(readlink -e "$f"); then
        osascript >/dev/null \
          -e "set theFile to POSIX file (POSIX path of \"${filename}\")" \
          -e 'tell app "Finder" to move theFile to trash' \
        && echo "${filename/#$HOME/$'~'} → ~/.Trash"
      else
        scold "not found: $f"
        return 66
      fi
    done
	elif (( ${BASH_VERSINFO[0]}${BASH_VERSINFO[1]} >= 42 )); then
    local dir_trash="$HOME/.Trash"

    if [[ ! -d $dir_trash ]]; then
      mkdir -p "$dir_trash" &>/dev/null
    fi

    local fmt="%s/%s %(%H.%M.%S)T"

    local t
    local f; for f in "$@"; do
      local filebase=${f##*/}
      filebase=${filebase%/}
      local fileext=${f##*.}

      t="$dir_trash/$filebase.$fileext"

      if [[ -e $t ]]; then
        t_base=${filebase%.*}
        t_ext=${f##*$t_base}
        printf -v t "${fmt}%s" "$dir_trash" "$t_base" -1 "$t_ext"

        if [[ -e $t ]]; then
          printf -v t "${fmt}_%d%s" "$dir_trash" "$filebase" -1 "$RANDOM" "$fileext"
        fi
      fi
      command mv -fv -- "$f" "$t"
    done
  else
  	scold "bash ${BASH_VERSINFO[0]}.${BASH_VERSINFO[1]}: not supported"
  	return 69
  fi
}
