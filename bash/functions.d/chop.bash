chop()
{ #: - prints fields from stdin by number
  #: $ chop <delim><field|start-end>
  # >> http://2048.fi/shellnotes.txt
  cut -d"${1:0:1}" -f"${1:1}"
}
