function cleanup-spotify -d "Cleanup Spotify cache"
    killall -v Spotify

    set -l app_support ~/Library/"Application Support"/Spotify
    set -l launch_agent ~/Library/LaunchAgents/com.spotify.webhelper.plist
    set -l state_dir ~/Library/"Saved Application State"/com.spotify.client.savedState/
    set -l user_cache ~/Library/Caches
    set -l spotify_caches $user_cache/com.spotify.{client{,.helper},installer}
    set -l cache_files $spotify_caches/Cache.*

    rm -rf $app_support $launch_agent $state_dir $cache_files
end
