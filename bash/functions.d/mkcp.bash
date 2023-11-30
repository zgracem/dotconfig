mkcp()
{ #: -- create a directory, then copy files into it
  #: $ mkcp <file> [<file> ...] <destination>
  command mkdir -p -- "${@: -1}" &&
       cp -v -- "$@"
}
