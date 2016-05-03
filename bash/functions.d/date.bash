nowz()
{ # date & time in ISO 8601 format
  local date_fmt="%FT%TZ"

  if (( ${BASH_VERSINFO[0]}${BASH_VERSINFO[1]} >= 42 )); then
    printf "%(${date_fmt})T\n" -1
  else
  	date --utc +"${date_fmt}"
  fi
}
