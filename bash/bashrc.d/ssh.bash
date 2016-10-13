# ssh shortcuts & setup

alias  a='newwin --title Athena ssh Athena'
alias aa='newwin --title Athena ssh Athena.remote'
alias m='newwin  --title Minerva ssh Minerva'
alias er='newwin --title Erato ssh Erato'
alias hiroko='newwin --title Hiroko ssh Hiroko'

wf()
{ # Because WebFaction's sshd doesn't AcceptEnv
  # Based on: http://superuser.com/a/163228
  local title="WebFaction"
  local host="$title"

  [[ $OSTYPE == cygwin ]] && host=${host,,}

  if [[ -n $Z_SOLARIZED ]]; then
    newwin --title "$title" \
      env TERM="$Z_SOLARIZED:$TERM" \
        ssh -t "$host" "Z_SOLARIZED=\${TERM%:*}; TERM=\${TERM##*:}; export Z_SOLARIZED; exec \$HOME/opt/bin/bash --login"
        # `ssh -t` is required to explicitly allocate a terminal, otherwise the
        # remote server won't request $TERM at all, obviating our little trick
  else
    newwin --title "$title" ssh "$host"
  fi

}

# Because cygwin ssh can't handle non-lowercase hostnames(?)
if [[ $OSTYPE == cygwin ]]; then
  alias  a='newwin --title Athena ssh athena'
  alias aa='newwin --title Athena ssh athena.remote'
  alias m='newwin  --title Minerva ssh minerva'
  alias er='newwin --title Erato ssh erato'
  alias hiroko='newwin --title Hiroko ssh hiroko'
fi
