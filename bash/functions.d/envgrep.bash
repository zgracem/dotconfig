envgrep()
{ #: - search in names and values of environment variables
  declare -p | strip_ansi | grep -i "$@" 
}
