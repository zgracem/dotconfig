function yt-json --description "Download only JSON info from YouTube"
    yt-dlp --no-config --skip-download --write-info-json $argv
end
