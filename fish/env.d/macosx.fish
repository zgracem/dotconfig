in-path xcrun; or exit

set -l sdk_file $XDG_CACHE_HOME/dotfiles/MacOSX-sdk-path.txt

path is -f $sdk_file; or make -s -C $XDG_CONFIG_HOME sdk

read -gx SDKROOT <$sdk_file
