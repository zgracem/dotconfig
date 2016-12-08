# -----------------------------------------------------------------------------
# SSH setup & shortcuts
# -----------------------------------------------------------------------------

_ssh()
{
  local host="$1"
  local title="${host%%.*}"

  local send_env=(TERM_PROGRAM Z_SOLARIZED)

  # Because cygwin's ssh can't handle non-lowercase hostnames(?)
  [[ $OSTYPE == cygwin ]] && host=${host,,}

  # WebFaction's sshd doesn't AcceptEnv, so set important vars manually
  # >> http://superuser.com/a/163228
  if [[ $host == WebFaction ]]; then
    local cmd="exec bash --login"
    local assign
    local export

    local var; for var in "${send_env[@]}"; do
      if [[ -n ${!var} ]]; then
        assign+="${assign+; }$var=${!var}"
        export+="${export+ }$var"
      fi
    done

    cmd="$assign; export $export; $cmd"
  fi

  newwin --title "$title" ssh -t "$host" "$cmd"
}

alias  a='_ssh Athena'
alias aa='_ssh Athena.remote'
alias  m='_ssh Minerva'
alias er='_ssh Erato'
alias wf='_ssh WebFaction'
alias hiroko='_ssh Hiroko'
