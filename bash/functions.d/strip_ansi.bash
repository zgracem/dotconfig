strip_ansi()
{ #: - strips ANSI formatting escape codes from args or stdin
  local regex; printf -v regex "%b\\[[0-9]+(;[0-9]+)*m" "\\e"
  sed -E "s/${regex}//g" <<< "${*-$(</dev/stdin)}"
}
