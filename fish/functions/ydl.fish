function ydl
    set -l config ~/.config/yt-dlp/config-youtube
    yt-dlp --config-location=$config $argv
end
