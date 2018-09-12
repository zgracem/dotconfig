ff()
{ #: - finds file(s) in PWD whose name contains a given string
  _z_find file "$PWD" "$@"
}

fd()
{ #: - finds directory/ies in PWD whose name contains a given string
  _z_find dir "$PWD" "$@"
}

_z_find()
{ #: $ _z_find f[ile]|d[ir] <scope> <term>

  local find_type=$1 scope=$2; shift 2
  local term=$*

  case $find_type in
    f|d|file|dir)
      find_type="${find_type:0:1}"
      ;;
    *)
      scold "Usage: ${FUNCNAME[0]} f[ile]|d[ir] SCOPE TERM"
      return 64
      ;;
  esac

  local line

  find -H "$scope" \
       -xtype "$find_type" \
       -iname "*$term*" \
       -print 2>/dev/null \
  | while read -r line; do
    command grep -i --colour=auto "$term" <<< "${line/#$HOME/$'~'}";
  done
}

# -----------------------------------------------------------------------------

today()
{ #: - lists all files in PWD changed today
  _z_find_daysold -1
}

thisweek()
{ #: - lists all files in PWD changed this week
  _z_find_daysold -7
}

_z_find_daysold()
{ #: - lists all files in PWD changed in the last $1 days
  #: $ _z_find_daysold <days>
  local days="$1" age
  local number_re='^[-+]?[[:digit:]]+$'

  if ! [[ $days =~ $number_re ]]; then
    scold "Error: $days: not a number"
    return 65
  elif ! _isGNU find; then
    scold "Error: GNU find(1) required"
    return 69
  fi

  # No +/- prefix means "exactly", which is less useful w/ minutes
  [[ ${days:0:1} =~ [-+] ]] || days="-$days"

  # Use `-mmin $minutes` instead of `-mtime $days` because of peculiarities 
  # in GNU find/C arithmetic. See <http://unix.stackexchange.com/a/112407>
  age=$(( days * 24 * 60 ))

  # Add a "+" to positive results of the above
  (( age >= 0 )) && age="+$age"

  find -H "$PWD" -maxdepth 1 \
       -xtype f \
       -daystart -mmin "$age" \
       -print
}
