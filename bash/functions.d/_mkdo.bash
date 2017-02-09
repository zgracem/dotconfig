mkcd()
{ #: - create a directory, then move into it
  command mkdir -p "$1" \
    && cd "$1"
}

mkcp()
{ #: - create a directory, then copy files into it
  #: $ mkcp <file> [<file> ...] <destination>
  command mkdir -p -- "${@: -1}" \
    && cp -v -- "$@"
}

mkmv()
{ #: - create a directory, then move files into it
  #: $ mkmv <file> [<file> ...] <destination>
  command mkdir -p -- "${@: -1}" \
    && mv -v -- "$@"
}
