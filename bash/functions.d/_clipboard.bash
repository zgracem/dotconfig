# shortcuts
alias c=pbcopy
alias p=pbpaste

pbsort()
{ #: - sort contents of clipboard in place
  (pbpaste;echo) | sort -u | pbcopy
  #        │             └─ remove duplicates
  #        └─────────────── add a newline to the end for sorting purposes
}

cppwd()
{ #: - copy current directory's POSIX path to clipboard
  pbcopy <<< "$PWD"
}

[[ $PLATFORM == windows ]] || return

cpcd()
{ #: - copy current directory's Windows path to clipboard
  cygpath -aw "$PWD" \
  | tr -d '\n' \
  | pbcopy
}
