# do not create function in Midnight Commander
[[ -n $MC_SID ]] && return

cd()
{
  local NEWPWD="${*:-$HOME}"
  [[ $PWD == "$NEWPWD" ]] && return
  builtin pushd "$NEWPWD" 1>/dev/null || return
}

alias --  -='pushd +1 1>/dev/null'  # -  = go back 1 dir
alias -- --='pushd -0 1>/dev/null'  # -- = go forward 1 dir
