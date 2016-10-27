pbsort()
{ # sort contents of clipboard
  
  # add a newline to the end for sorting purposes
  (pbpaste;echo) \
  | sort -u \
  | pbcopy
}

cppwd()
{ # copy current directory's path to clipboard
  pbcopy <<< "$PWD"
}

[[ $PLATFORM == windows ]] || return

cpcd()
{ # copy current directory's Windows path to clipboard
  cygpath -aw "$PWD" \
  | tr -d '\n' \
  | pbcopy
}
