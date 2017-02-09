# Usage:
#   echo "foo bar baz" | chop " "2 #=> bar
#   echo "foo:bar:baz" | chop :2-3 #=> bar baz
chop()
{ # >> http://2048.fi/shellnotes.txt
  cut -d"${1:0:1}" -f"${1:1}"
}
