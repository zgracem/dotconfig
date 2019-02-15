function myip --description 'Display the current publicly-facing IP address'
  command dig +short @resolver1.opendns.com myip.opendns.com
end
