_inPath sf-pwgen || return

newpw()
{
  local length="${1:-16}"
  sf-pwgen --algorithm memorable --count 1 --length "$length"
}
