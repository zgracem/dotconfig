ret()
{
  # If our only argument is a number, return that exit code.
  if [[ $@ =~ ^[[:digit:]]+$ ]]; then
    return $1
  else
    echo >&2 "Usage: ret [n]"
    return 254
  fi
}
