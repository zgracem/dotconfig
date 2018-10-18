# Sublime Text
s()
{ #: - launches Sublime Text and adds files or dirs to topmost window
  #: $ s <file_or_dir> [file_or_dir ...]
  #: $ ls -1 *.md | s
  if [[ ! -t 0 ]]; then
    # accept a list of files to open on standard input
    local file; while read -r file || [[ -n $file ]]; do
      set -- "$@" "$(readlink -e "$file")"
    done < /dev/stdin
  fi

  subl --add "${@:-$PWD}"
}
