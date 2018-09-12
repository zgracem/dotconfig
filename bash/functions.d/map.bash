map()
{ #: -- applies a command to each item in a list (or stdin)
  #: $ map <command>: <item> [<item> ...]
  #: $ map <command> <<< <item>[\n<item>[\n<item>...]]
  #: > http://redd.it/aks3u

  if [[ ! -t 0 ]]; then
    cmd="$*"
    local i; while read -r i || [[ -n $i ]]; do
      "$cmd" "$i"
    done
    return
  fi

  if [[ $# -lt 2 ]] || [[ ! $* =~ :[[:space:]] ]]; then
    fx_usage >&2
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
