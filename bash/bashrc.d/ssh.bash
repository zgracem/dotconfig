# ssh shortcuts & setup

alias  a='newwin --title Athena ssh Athena'
alias aa='newwin --title Athena ssh Athena.remote'
alias m='newwin  --title Minerva ssh Minerva'
alias er='newwin --title Erato ssh Erato'
alias hiroko='newwin --title Hiroko ssh Hiroko'

wf()
{ # Because WebFaction's sshd doesn't AcceptEnv
  # Based on: http://superuser.com/a/163228
  local host="WebFaction"

  [[ $OSTYPE =~ cygwin ]] && host=${host,,}

  if [[ -n $Z_SOLARIZED ]]; then
    newwin --title WebFaction \
      env TERM="$Z_SOLARIZED:$TERM" ssh -t "$host" "Z_SOLARIZED=\${TERM%:*}; TERM=\${TERM##*:}; export Z_SOLARIZED; exec \$HOME/opt/bin/bash --login"
    # ┌──────────────────────────────────┘
    # `-t` is required to explicitly allocate a terminal, otherwise
    # the remote server won't request $TERM at all, obviating our little trick.
  else
    newwin --title WebFaction ssh "$host"
  fi

}

# Because cygwin ssh can't handle non-lowercase hostnames(?)
if [[ $OSTYPE =~ cygwin ]]; then
  alias  a='newwin --title Athena ssh athena'
  alias aa='newwin --title Athena ssh athena.remote'
  alias m='newwin  --title Minerva ssh minerva'
  alias er='newwin --title Erato ssh erato'
  alias hiroko='newwin --title Hiroko ssh hiroko'

  # for a in "${!BASH_ALIASES[@]}"; do
  #   if [[ ${BASH_ALIASES[$a]} =~ \ ssh\  ]]; then
  #     c="${BASH_ALIASES[$a]}"
  #     quietly unalias "$a"
  #     alias "$a"="${c,,}"
  #   fi
  # done
  # unset -v a c
fi
