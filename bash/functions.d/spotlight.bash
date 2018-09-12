[[ $PLATFORM == mac ]] || return

sp()
{ #: - performs a Spotlight search for files named $1
  local term=$@
  mdfind -name "$term" | while read -r line; do
    command grep -i --colour=auto "$term" <<< "${line/#$HOME/$'~'}";
  done
}
