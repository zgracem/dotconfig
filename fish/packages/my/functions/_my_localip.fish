function _my_localip --description 'Display current local IP address'
    if is-macos
        set -l pattern '^.*Setup:/Network/Interface/(en\d)/AirPort$'
        set -l netcard (echo list | scutil | string replace -fr $pattern '$1')
        and ipconfig getifaddr $netcard
    else if is-cygwin
        ipconfig | string replace -rf '.*IPv4 Address.*: ([\d.]+).*' '$1'
    end
end
