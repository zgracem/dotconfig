function ytthumbs
    yt-dlp --skip-download --no-write-info-json --write-all-thumbnails \
        --output="thumbnail:%(id)s_thumbs/%(id)s.%(ext)s" $argv
end
