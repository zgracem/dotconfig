_inPath sf-pwgen || return

newpw()
{
  local length="${1:-16}"
  sf-pwgen --count 1 --length "$length"
}
