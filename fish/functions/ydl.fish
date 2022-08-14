function ydl -d "Download from YouTube"
    set -l config ~/.config/yt-dlp/config-youtube
    yt-dlp --config-location=$config $argv
end
