# do not create function in Midnight Commander
if [[ -z $MC_SID ]]; then
  cd()
  {
    builtin pushd "${@:-$HOME}" 1>/dev/null
  }

  alias --  -='pushd +1 1>/dev/null'  # -  = go back 1 dir
  alias -- --='pushd -0 1>/dev/null'  # -- = go forward 1 dir
fi

cdls()
{ # change to, and immediately list, a directory
  cd "$@" && ls
}

cdll()
{ # change to, and immediately list (at length), a directory
  cd "$@" && ll
}

ccd()
{ # reset everything
  builtin cd ~      # move to $HOME
  builtin dirs -c   # clear directory stack
  clear_scrollback  # clear screen & scrollback
}
