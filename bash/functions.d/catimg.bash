catimg()
{
  if [[ $TERM_PROGRAM == iTerm.app ]] && _inPath imgcat; then
    imgcat "$@"
  elif quietly type -P catimg; then
    command catimg -h $LINES "$@"
  else
    scold "not available :("
    return 1
  fi
}
