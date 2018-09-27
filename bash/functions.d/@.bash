function @ 
{ #: - converts a Unix timestamp to an RFC 2822–formatted string
  #: $ @ <timestamp>
  date -d "@$1" --rfc-2822; 
}
