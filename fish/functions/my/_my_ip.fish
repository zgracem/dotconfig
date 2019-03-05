function _my_ip
  if in-path ip
    ip -o route get to 1.1.1.1 | string replace -rf '.*src ([\d.]+).*' '$1'
  else if in-path dig
    dig +short @resolver1.opendns.com myip.opendns.com
  else if in-path nslookup
    echo (nslookup myip.opendns.com resolver1.opendns.com 2>/dev/null \| string replace -fr '^Address: +(.*)' '$1')[-1]
  end
end
