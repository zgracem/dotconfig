function _my_localip
  set -l pattern '^.*Setup:/Network/Interface/(en\d)/AirPort$'
  set -l netcard (echo list | scutil | string replace -fr $pattern '$1')
  and ipconfig getifaddr $netcard
end
