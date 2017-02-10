cdls()
{ #: -- change to, and immediately list, a directory
  cd "$@" && ls
}

cdll()
{ #: -- change to, and immediately list (at length), a directory
  cd "$@" && ll
}
