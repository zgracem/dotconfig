is-macos; or exit

function airport --description 'Get information for 802.11 interface'
    set -l PATH $PATH
    set -p PATH /System/Library/PrivateFrameworks/Apple80211.framework/Versions/Current/Resources
    command airport $argv
end
