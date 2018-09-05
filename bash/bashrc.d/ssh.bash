# -----------------------------------------------------------------------------
# SSH setup & shortcuts
# -----------------------------------------------------------------------------

_ssh()
{
  local host="$1"
  local title="${host%%.*}"

  local send_env=(PTERM TERM_PROGRAM)

  # Because cygwin's ssh can't handle non-lowercase hostnames(?)
  [[ $OSTYPE == cygwin ]] && host=${host,,}

  # WebFaction's sshd doesn't AcceptEnv, so set important vars manually
  # >> http://superuser.com/a/163228
  if [[ $host =~ WebFaction|vshraya ]]; then
    local cmd="env"

    local var; for var in "${send_env[@]}"; do
      if [[ -n ${!var} ]]; then
        cmd+=" $var=${!var}"
      fi
    done

    cmd="$cmd bash --login"
  fi

  newwin --title "$title" ssh -t "$host" "$cmd"
}

alias  a='_ssh Athena'
alias aa='_ssh Athena.remote'
alias er='_ssh Erato'
alias wf='_ssh WebFaction'
alias hiroko='_ssh Hiroko'
alias vssh='_ssh vshraya'
