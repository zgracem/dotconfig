# ZGM disabled 2023-02-15 -- This seems to break Ruby builds.
# Manually run in case of "missing header file" errors.
# See https://stackoverflow.com/questions/51761599/cannot-find-stdio-h/60002595#60002595

#command -v xcrun >/dev/null || return
#
#sdk_file=$XDG_CACHE_HOME/dotfiles/MacOSX-sdk-path.txt
#
#[[ -f $sdk_file ]] || make -s -C "$XDG_CONFIG_HOME" sdk
#
#export SDKROOT=$(<"$sdk_file")
