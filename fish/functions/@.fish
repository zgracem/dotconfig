function @ --description 'Convert a UNIX timestamp to an RFC 2822-formatted string'
  date -d "@$argv[1]" --rfc-2822
end
