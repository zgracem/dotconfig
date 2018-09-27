_inPath jq || return

json()
{ #: - pretty-print a .json file
  jq . < "$1"
}
