_inPath plutil || return

plist()
{
  if (( $# != 1 )); then
    scold "Usage: $FUNCNAME file"
    return 64
  else
    plutil -p "$1" | less -F
    return $?
  fi
}
