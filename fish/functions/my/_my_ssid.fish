function _my_ssid
  airport --getinfo | string replace -rf '.*\bSSID: (.+)$' '$1'
end
