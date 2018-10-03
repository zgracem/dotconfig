pidof()
{ #: - returns the PID(s) of process(es) named $1, or false if nothing found
  #: $ pidof <name>
  #: @ killall()
  local proc="$1"
  local pid
  pid=$(_z_pid | sed -nE "s/[[:space:]]*([[:digit:]]+) .*\\<${proc}(\\.exe)?$/\\1/ip")

  [[ -n $pid ]] && echo "$pid"
}

pidis()
{ #: - returns the name of the process with PID $1, or false if nothing found
  #: $ pidis <pid>
  local pid="$1"
  [[ $pid =~ ^[[:digit:]]+$ ]] || return 64

  local proc
  proc=$(_z_pid -p "$pid" | tail -n+2)

  if [[ -z $proc ]]; then
    return 1
  elif [[ $PLATFORM == windows ]]; then
    # Assumes output format of PID,TTY,STIME,COMMAND
    tr -s " " <<< "$proc" | cut -d" " -f5-
  else
    echo "$proc"
  fi
}

_z_pid()
{ #: @ pidof
  #: @ pidis
  local flags
  case $PLATFORM in
    windows)  flags="-sW" ;;
    #                 │└────── also show Windows processes
    #                 └─────── summary format

    *)        flags="-cx -o pid,command" ;;
    #                 ││  └─── output this info only
    #                 │└────── include processes w/ no controlling terminal
    #                 └─────── show only the executable name, not the full cmd
  esac

  [[ ${FUNCNAME[1]} == pidis ]] && flags=${flags/pid,/}

  # Leave `flags` unquoted so it expands properly
  # shellcheck disable=SC2086
  command ps $flags "$@"
}
