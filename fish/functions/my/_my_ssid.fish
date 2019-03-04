function _my_ssid
  in-path airport; or return 127
  airport --getinfo | string replace -rf '.*\bSSID: (.+)$' '$1'
end
