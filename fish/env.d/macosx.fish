# ZGM re-enabled 2023-05-07 -- now Ruby builds need this???
# Make sure to `sudo xcode-select --switch /Library/Developer/CommandLineTools` first

## ZGM disabled 2023-02-15 -- This seems to break Ruby builds.
## Manually run in case of "missing header file" errors.
## See https://stackoverflow.com/questions/51761599/cannot-find-stdio-h/60002595#60002595
#exit

in-path xcrun; or exit

set -l sdk_file $XDG_CACHE_HOME/dotfiles/MacOSX-sdk-path.txt

path is -f $sdk_file; or make -s -C $XDG_CONFIG_HOME sdk

read -gx SDKROOT <$sdk_file
