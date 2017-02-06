strip_ansi()
{
  local regex; printf -v regex "%b\[[0-9]+(;[0-9]+)*m" "\e"
  sed -E "s/${regex}//g"
}
