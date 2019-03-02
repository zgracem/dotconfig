function _my_ssid
  airport -I | string replace -rf '.*\bSSID: (.+)$' '$1'
end
