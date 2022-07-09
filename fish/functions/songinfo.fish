function songinfo
    set -l songs $argv
    for song in $songs
        switch $song
            case '*.mp3'
                id3v2 -l $song
            case '*.m4a' '*.m4p' '*.mp4' '*.aac'
                mp4info $song
            case '*'
                echo >&2 "don't know how to get info for "(path extension $song)" files!"
                return 1
        end
    end
end
