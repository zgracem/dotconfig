#: - converts a Unix timestamp to an RFC 2822–formatted string
#: $ @ <timestamp>
function @ 
{ 
  date -d "@$1" --rfc-2822; 
}
