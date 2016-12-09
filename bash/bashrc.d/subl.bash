# Sublime Text
s()
{
  if [[ ! -t 0 ]]; then
    # accept a list of files to open on standard input
    local file; while read -r file || [[ -n $file ]]; do
      set -- "$@" "$file"
    done < /dev/stdin
  fi

  subl --add "${@:-$PWD}"
}
