function clear-spotify-cache --description "Clear Spotify's cache(s)"
  set --local user_cache ~/Library/Caches

  set --local spotify_caches $user_cache/com.spotify.{client{,.helper},installer}
  set --local cache_files $spotify_caches/Cache.*
  set --local cache_dirs $spotify_caches/{Browser,Data}*

  killall Spotify 2>/dev/null
  command rm -f $cache_files
  command rm -rf $cache_dirs
end
