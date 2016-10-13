map()
{ # applies a function to each item in a list
  # Usage: map COMMAND: ITEM [ITEM ...]
  # Based on: http://redd.it/aks3u

  if [[ $# -lt 2 ]] || [[ ! $@ =~ :[[:space:]] ]]; then
    scold "${FUNCNAME[0]}: invalid syntax"
    scold "Usage: ${FUNCNAME[0]} COMMAND: ITEM [ITEM ...]"
    return 1
  fi

  local cmd

  until [[ $1 =~ :$ ]]; do
    cmd+="$1 "
    shift
  done

  cmd+="${1%:} "
  shift

  local i
  for i in "$@"; do
    eval "${cmd//\\/\\\\} \"${i//\\/\\\\}\""
  done
}
