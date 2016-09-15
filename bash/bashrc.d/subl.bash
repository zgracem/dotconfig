# Sublime Text
s()
{
  if [[ ! -t 0 ]]; then
    # we're getting stdin from something, discard arguments
    subl < /dev/stdin 
  else
    subl --add "${@:-$PWD}"
  fi
}
