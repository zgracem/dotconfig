function ? 
{ #: - prints the true/false status of the last command
  #: $ some_command ; ? #=> exit status of `some_command`
  local last_exit=$?
  local text="" colour="" reset=$'\e[0m'

  if (( last_exit == 0 )); then
    text="true"
    colour=$'\e[92m'
  else
    text="false [$last_exit]"
    colour=$'\e[91m'
  fi

  printf "%b\\n" "${colour}${text}${reset}"
}
