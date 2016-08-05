ret()
{
  # If our only argument is a positive or negative number,
  # return that exit code.
  if [[ $@ =~ ^[[:digit:]-]+$ ]]; then
    return $1
  else
    echo >&2 "Usage: ret [n]"
    return 1
  fi
}
