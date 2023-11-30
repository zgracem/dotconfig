mkmv()
{ #: -- create a directory, then move files into it
  #: $ mkmv <file> [<file> ...] <destination>
  command mkdir -p -- "${@: -1}" &&
       mv -v -- "$@"
}
