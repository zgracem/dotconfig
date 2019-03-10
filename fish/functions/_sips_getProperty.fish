function _sips_getProperty -a property image
  set -l regex '.*: (\d+)$'
  sips --getProperty $property $image | string replace -rf $regex '$1'
end
