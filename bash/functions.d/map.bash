map()
{ #: - applies a command to each item in a list
  #: $ map <command>: <item> [<item> ...]
  #: > http://redd.it/aks3u

  if [[ $# -lt 2 ]] || [[ ! $@ =~ :[[:space:]] ]]; then
    scold "${FUNCNAME[0]}: invalid syntax"
    fdoc_usage >&2
    return 64
  fi

  local cmd

  until [[ $1 == *: ]]; do
    cmd+="$1 "
    shift
  done

  cmd+="${1%:} "
  shift

  local i; for i in "$@"; do
    eval "${cmd//\\/\\\\} \"${i//\\/\\\\}\""
  done
}
