function ?
{ #: - prints the true/false status of the last command
  #: $ some_command ; ? #=> exit status of `some_command`
  local last_exit=$?
  local text="" colour="" reset=$'\e[0m'

  if [[ $last_exit -eq 0 ]]; then
    colour=$'\e[92m'
    text="true"
  else
    colour=$'\e[91m'
    if [[ $last_exit -gt 128 ]] && sigspec=$(builtin kill -l "$last_exit" 2>/dev/null); then
      last_exit="$last_exit=${sigspec#SIG}"
    elif [[ $last_exit -ge 64 ]] && [[ $last_exit -le 78 ]]; then
      # Someone's been reading sysexits(3)... ;)
      local -ra exits=( [64]="USAGE"    [65]="DATAERR"     [66]="NOINPUT"
        [67]="NOUSER"   [68]="NOHOST"   [69]="UNAVAILABLE" [70]="SOFTWARE"
        [71]="OSERR"    [72]="OSFILE"   [73]="CANTCREAT"   [74]="IOERR"
        [75]="TEMPFAIL" [76]="PROTOCOL" [77]="NOPERM"      [78]="CONFIG" )
      last_exit="$last_exit=${exits[$last_exit]}"
    fi

    text="false [$last_exit]"
  fi

  printf "%b\\n" "${colour}${text}${reset}"
}
