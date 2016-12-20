# Find a file whose name contains a given string
ff() { _z_find file "$PWD" "$@"; }

# Find a directory whose name contains a given string
fd() { _z_find dir "$PWD" "$@"; }

# General finding function
_z_find()
{ # Usage: _z_find f[ile]|d[ir] SCOPE TERM

  local find_type=$1 scope=$2; shift 2
  local term=$@

  case $find_type in
    f|d|file|dir)
      find_type="${find_type:0:1}"
      ;;
    *)
      scold "Usage: ${FUNCNAME[0]} f[ile]|d[ir] SCOPE TERM"
      return 64
      ;;
  esac

  find -H "$scope" \
       -xtype $find_type \
       -iname '*'"$term"'*' \
       -print 2>/dev/null \
  | sed "s|^$HOME|~|g" \
  | command grep -i --colour=auto "$term"
}

# -----------------------------------------------------------------------------

# List all files under $PWD changed today
today() { _z_find_daysold -1; }

# List all files under $PWD changed this week
thisweek() { _z_find_daysold -7; }

# List all files in $PWD changed in the last $1 days
_z_find_daysold()
{
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
