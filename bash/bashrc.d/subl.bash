# Sublime Text
s()
{ #: - launches Sublime Text
  #: $ s <file> [<file> ...]
  #: $ echo "$list_of_files" | s
  if [[ ! -t 0 ]]; then
    # accept a list of files to open on standard input
    local file; while read -r file || [[ -n $file ]]; do
      set -- "$@" "$(readlink -e "$file")"
    done < /dev/stdin
  fi

  subl --add "${@:-$PWD}"
}
