catimg()
{
  if [[ $TERM_PROGRAM == iTerm.app ]] && _inPath imgcat; then
    imgcat "$@"
  elif _inPath catimg; then
    command catimg "$@"
  else
    scold "not available :("
    return 69
  fi
}
