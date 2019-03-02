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
