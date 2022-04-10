function _my_localip --description 'Display current local IP address'
    if is-macos
        set -l pattern '^.*Setup:/Network/Interface/(en\d)/AirPort$'
        set -l netcard (echo list | scutil | string match -rg $pattern)
        and ipconfig getifaddr $netcard
    else if is-cygwin
        ipconfig | string match -rg '.*IPv4 Address.*: ([\d.]+).*'
    end
end
