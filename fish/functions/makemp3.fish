in-path ffmpeg; or exit

function makemp3 -d "Convert any audio file to MP3 (libmp3lame, max quality VBR)"
    set -f ffmpeg_args
    set -a ffmpeg_args -codec:a libmp3lame
    set -a ffmpeg_args -qscale:a 0
    set -a ffmpeg_args -map_metadata 0
    set -a ffmpeg_args -write_id3v1 1
    set -a ffmpeg_args -id3v2_version 3

    for input in $argv
        set -l output (path change-extension .mp3 $input)
        ffmpeg -i $input $ffmpeg_args $output
    end
end
