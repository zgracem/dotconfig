in-path ffmpeg; or exit

function extractm4a -d "Extract an M4A audio track from a video container"
    set -l suffix extract
    for input in $argv
        set -l output (path change-extension "" $input)"_$suffix.m4a"
        ffmpeg -i $input -c:a copy -vn -sn $output
        #                 │         │   └─ no subtitles
        #                 │         └───── no video
        #                 └─────────────── copy audio as-is
    end
end
