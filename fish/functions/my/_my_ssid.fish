function _my_ssid
  type -q airport; or return 127
  airport --getinfo 2>/dev/null | string replace -rf '.*\bSSID: (.+)$' '$1'
end
