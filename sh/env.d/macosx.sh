command -v xcrun >/dev/null || exit

sdk_file=$XDG_CACHE_HOME/dotfiles/MacOSX-sdk-path.txt

[[ -f $sdk_file ]] || make -s -C "$XDG_CONFIG_HOME" sdk

export SDKROOT=$(<"$sdk_file")
