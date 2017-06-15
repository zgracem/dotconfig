newpw()
{ #: - generates a new password
  #: $ newpw [<length>]
  #: | length = length of password (default: 16)
  #: < sf-pwgen
  _require sf-pwgen || return
  local length="${1-16}"
  sf-pwgen --count 1 --length "$length"
}
