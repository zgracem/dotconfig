function ydl -d "Download from YouTube"
    set -l config $XDG_CONFIG_HOME/yt-dlp/config-youtube
    yt-dlp --config-location=$config $argv
end
