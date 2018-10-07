rot13()
{ #: - translate text to or from ROT13
  #: $ rot13 "uryyb jbeyq"
  #: $ rot13 mystery.txt > zlfgrel.txt
  #: $ spoilers | rot13
  local set1="a-mn-zA-MN-Z" 
  local set2="n-za-mN-ZA-M"

  if [[ -f $1 ]]; then
    # file
    tr "$set1" "$set2" < "$1"
  else
    # string or standard input
    tr "$set1" "$set2" <<< "${@-$(</dev/stdin)}"
  fi
}
