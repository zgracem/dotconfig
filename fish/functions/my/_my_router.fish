function _my_router
  if macos?
    netstat -rn | string replace -fr '^default +([\d.]+).*$' '$1'
  else if cygwin?
    ipconfig | string replace -fr '.*Default Gateway.*: ([\d.]+).*' '$1'
  end
end
