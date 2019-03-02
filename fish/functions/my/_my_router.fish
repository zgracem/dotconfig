function _my_router
  netstat -rn | string replace -fr '^default +([\d.]+).*$' '$1'
end
