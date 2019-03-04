function _my_localip
  if macos?
    set -l pattern '^.*Setup:/Network/Interface/(en\d)/AirPort$'
    set -l netcard (echo list | scutil | string replace -fr $pattern '$1')
    and ipconfig getifaddr $netcard
  else if cygwin?
    ipconfig | string replace -rf '.*IPv4 Address.*: ([\d.]+).*' '$1'
  end
end
