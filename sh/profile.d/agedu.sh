# >> http://www.chiark.greenend.org.uk/~sgtatham/agedu/

_inPath agedu || return

agedu()
{
  # Directory to scan
  set -- --scan "${1:-$HOME}"

  # Location of database file
  set -- "$@" --file "$XDG_RUNTIME_DIR/agedu.dat"

  # Web server preferences
  set -- "$@" --web --address $(localip):60053 --auth none

  # Remove database file after web server stops
  set -- "$@" --remove

  command agedu "$@"
}
