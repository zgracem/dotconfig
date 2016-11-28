_edit()
{ # open file(s) in the appropriate editor
  # Usage: _edit FILE[:LINE] [FILE[:LINE] ...]

  local -a files=("$@")
  local -r lineno_regex=':([[:digit:]]+)$'

  local file; for file in "${files[@]}"; do
    if [[ $file =~ $lineno_regex ]]; then
      local line="${BASH_REMATCH[1]}"
      file="${file%:*}"
    fi

    # use a console editor if working remotely
    if [[ -n $SSH_CONNECTION ]]; then
      local window_title="${EDITOR##*/}"

      if [[ $EDITOR == *vim && -n $line ]]; then
        newwin --title "$window_title" "$EDITOR" +$line "$file"
      else
        newwin --title "$window_title" "$EDITOR" "$file"
      fi
    else
      # use a GUI editor
      if [[ $VISUAL == *subl* && -n $line ]]; then
        file="${file}:${line}"
      fi

      local VISUAL="${VISUAL%%?( -)-wait}"
      "$VISUAL" "$file"
    fi
  done
}
