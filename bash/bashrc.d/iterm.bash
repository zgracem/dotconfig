[[ $TERM_PROGRAM == iTerm.app ]] || return

# Reference:  https://iterm2.com/documentation-escape-codes.html
#             https://iterm2.com/documentation-shell-integration.html
#             https://iterm2.com/misc/bash_startup.in

iterm::esc()
{
  printf "${OSC}1337;%b${BEL}" "$@"
}

iterm::set_user_var()
{ # Usage: iterm::set_user_var <name> <value>

  local name="$1"
  local value="$2"

  value=$(base64 -w 0 <<< "$value") || return

  iterm::esc "SetUserVar=$name=$value"
}

iterm::set_badge()
{ # Usage: iterm::set_badge "string"

  local badge
  badge=$(base64 -w 0 <<< "$@") || return

  iterm::esc "SetBadgeFormat=$badge"
}

iterm::state()
{
  iterm::esc "RemoteHost=$USER@$HOSTNAME"
  iterm::esc "CurrentDir=$PWD"
}

iterm::PS1_ante()
{ # Usage: place the output from this at the beginning of PS1 (not as a command
  #        substitution!)
  printf '\['
  iterm::esc "D;\$?"
  iterm::state
  iterm::esc "A"
  printf '\]'
}

iterm::PS1_post()
{ # Usage: place at the very end of PS1
  printf '\['
  iterm::esc "B"
  printf '\]'
}

iterm::version()
{
  iterm::esc "ShellIntegrationVersion=99"
}

iterm::state
iterm::version
