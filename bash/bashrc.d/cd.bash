# do not create function in Midnight Commander
if [[ -z $MC_SID ]]; then
  cd() { builtin pushd "${@:-$HOME}" 1>/dev/null; }

  alias --  -='pushd +1 1>/dev/null'  # -  = go back 1 dir
  alias -- --='pushd -0 1>/dev/null'  # -- = go forward 1 dir
fi
