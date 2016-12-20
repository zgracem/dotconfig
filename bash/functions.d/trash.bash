trash()
{
  if [[ $PLATFORM == mac ]]; then
    local f; for f in "$@"; do
      local filename
      if filename=$(readlink -e "$f"); then
        osascript >/dev/null <<-EOF
          set fileItself to POSIX file (POSIX path of "$filename")
          tell application "Finder"
            move fileItself to trash
          end tell
				EOF
        # The above line MUST STAY tab-indented!
        # Also, we can't do a normal `&&` because of the heredoc.
        (( $? == 0 )) && echo "${filename/#$HOME/$'~'} → ~/.Trash"
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
      filebase=${f##*/}
      filebase=${filebase%/}

      t="$dir_trash/$filebase"

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
