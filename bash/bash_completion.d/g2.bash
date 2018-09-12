# for my directory-bookmarking function

__z_complete_g2()
{
  local -a wordlist=()
  local place

  # named variables
  for place in ${!dir_*}; do
    wordlist+=("${place#dir_}")
  done

  # bookmarked directories
  wordlist+=("${!mydirs[@]}")

  # directories under ~
  for place in "$HOME/"*/; do
    place=${place#$HOME/}   # strip home path and leading slash
    place=${place%/}        # strip trailing slash
    wordlist+=("$place")
  done

  # directory stack
  if [[ -n ${DIRSTACK[0]} ]] && (( ${#DIRSTACK[@]} > 1 )); then
    wordlist+=("${DIRSTACK[@]}")
  fi

  compopt -o nospace
  COMPREPLY=( $(compgen -W "${wordlist[*]}" -- "${COMP_WORDS[COMP_CWORD]}" ) )
}

complete -o dirnames -o plusdirs -d -F __z_complete_g2 -- g2
