cd()
{
    declare dir=${1:-$HOME}
    pushd "$dir" 1>/dev/null
}

alias --  -='pushd +1 1>/dev/null'  # -  = go back 1 dir
alias -- --='pushd -0 1>/dev/null'  # -- = go forward 1 dir

cdls()
{   # change to, and immediately list, a directory
    cd "$@" && ls
}

cdll()
{   # change to, and immediately list (at length), a directory
    cd "$@" && ll
}
