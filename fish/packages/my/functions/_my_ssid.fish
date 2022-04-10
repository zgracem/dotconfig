function _my_ssid --description 'Display current SSID'
    type -q airport; or return 127
    airport --getinfo 2>/dev/null | string match -rg '.*\bSSID: (.+)$'
end
