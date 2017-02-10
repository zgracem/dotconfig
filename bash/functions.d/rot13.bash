rot13()
{ #: - translate text to or from ROT13
  #: $ rot13 "uryyb jbeyq"
  #: $ rot13 mystery.txt > zlfgrel.txt
  #: $ spoilers | rot13
  local mask='a-zA-Z n-za-mN-ZA-M'

  if [[ -f $1 ]]; then
    # file
    tr $mask < "$1"
  else
    # string or standard input
    tr $mask <<< "${@-$(</dev/stdin)}"
  fi
}
