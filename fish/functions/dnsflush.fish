function dnsflush --description 'Flush the DNS cache'
  if macos?
    sudo dscacheutil -flushcache
    and sudo killall -HUP mDNSResponder
  else if cygwin?
    ipconfig /flushdns
  else
    echo >&2 "don't know how to flush DNS on" (uname -s)
  end
end
