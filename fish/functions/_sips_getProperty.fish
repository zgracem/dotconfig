function _sips_getProperty -a property image
    set -l regex ".*$property: (.+)\$"
    sips --getProperty $property $image | string match -rg $regex
end
