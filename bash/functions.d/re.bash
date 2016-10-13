# Usage: re='^[0-9]+' re 12345; q

re()
{
  if [[ -z $re ]]; then
    echo >&2 "re: not found"
    return 2
  else
    [[ $1 =~ $re ]]
  fi
}
