get_property()
{ #: - wrapper for sips(1) to strip all the non-property output
  #: $ get_property <property> <file>

  _require sips || return
  local property="$1" file="$2"

  sips --getProperty "$property" "$file" \
  | sed -nE "s#^[[:space:]]+$property: (.+)\$#\\1#p"
}
