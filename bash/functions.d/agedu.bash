# >> http://www.chiark.greenend.org.uk/~sgtatham/agedu/

_inPath agedu || return

agedu()
{
  local -a opts=()

  # Directory to scan
  opts+=(--scan "$HOME")

  # Location of database file
  opts+=(--file "$XDG_RUNTIME_DIR/agedu.dat")

  # Web server preferences
  opts+=(--web --address 10.0.1.10:60053 --auth none)

  # Remove database file after web server stops
  opts+=(--remove)

  command agedu "${opts[@]}"
}
