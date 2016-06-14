# Usage: re='^[0-9]+' re 12345; q

re()
{
  if [[ -z $re ]]; then
    echo >&2 "re: not found"
    return 2
  elif [[ $1 =~ $re ]]; then
    # printf "%q =~ %q\n" "$1 =~ $re"
    return 0
  else
    return 1
  fi
}
