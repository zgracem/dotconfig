vgrep()
{
  declare -p | strip_ansi | grep -i "$@" 
}
