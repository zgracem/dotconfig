command -v eza >/dev/null || return

unalias ls ll 2>/dev/null
unset -f ls ll lsf

eza()
{
  command eza "$@"
}

ls()
{
  eza --all "$@"
}

ll()
{
  ls --long --time-style=long-iso "$@"
}

lsf()
{
  ll --group --inode --extended "$@"
}
