function my --description 'Display network information'
	switch "$argv[1]"
    case 'ip' 'localip' 'router' 'ssid'
      eval "_my_$argv[1]"
    case ''
      echo "Public IP:" (_my_ip)
      echo " Local IP:" (_my_localip)
      echo "Router IP:" (_my_router)
      echo "     SSID:" (_my_ssid)
    case '*'
      echo >&2 "error: don't know about your $argv[1]"
      return 1
  end
end

function _my_ip
  dig +short @resolver1.opendns.com myip.opendns.com
end

function _my_localip
  set -l pattern '^.*Setup:/Network/Interface/(en\d)/AirPort$'
  set -l netcard (echo list | scutil | string replace -fr $pattern '$1')
  and ipconfig getifaddr $netcard
end

function _my_router
  netstat -rn | string replace -fr '^default +([\d.]+).*$' '$1'
end

function _my_ssid
  airport -I | string replace -rf '.*\bSSID: (.+)$' '$1'
end
