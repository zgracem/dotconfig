mkcd()
{ #: -- create a directory, then move into it
  command mkdir -p "$1" &&
       cd "$1" ||
       return
}
