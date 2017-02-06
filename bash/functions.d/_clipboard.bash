# shortcuts
c() { pbcopy; }
p() { pbpaste; }

tc()
{ # copies standard input to clipboard and displays it on standard output
  tee /dev/stdout < /dev/stdin | pbcopy
}

pbsort()
{ # sort contents of clipboard
  (pbpaste;echo) | sort -u | pbcopy
  #        │             └─ remove duplicates
  #        └─────────────── add a newline to the end for sorting purposes
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
