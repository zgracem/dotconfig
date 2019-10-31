if is-macos
  function airport --description 'Get information for 802.11 interface'
    /System/Library/PrivateFrameworks/Apple80211.framework/Versions/Current/Resources/airport $argv
  end
end
