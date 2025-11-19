# Gets the pixel size of images and video, the print size in inches of PDFs, and
# the duration of audio files.
#
# Requires:
#   /usr/bin/sips (macOS)
#   brew install mediainfo mp4v2
#   brew install --cask soulver soulver-cli
#
function dim --description 'Get the pixel dimensions of images or video'
    command -q sips; and command -q mediainfo; or return 127

    set -f img_formats (sips --formats | tail -n+3 | string match -rg "^\S+\s+(\w+)\b.*" | sort -u)
    # https://mediaarea.net/en/MediaInfo/Support/Formats
    set -f audio_formats ogg wav mp3 wma rm ra flac aiff
    set -f video_formats mkv avi mp4 wmv mov
    for file in $argv
        set -f output_format '%4d × %4d'
        set -l ext (path extension $file | string lower)
        switch $ext
            case .$img_formats .jpg
                set -f dims (sips -g pixelWidth -g pixelHeight $file | string match -rg 'pixel\S+: (\d+)')
                if string match -q .pdf $ext
                    set -l dpi (sips -g dpiWidth -g dpiHeight $file | string match -rg 'dpi\S+: (\d+)')
                    set -f dims[1] (math "$dims[1] / $dpi[1]")
                    set -f dims[2] (math "$dims[2] / $dpi[2]")
                    set -f output_format '%g" × %g"'
                end
            case .$video_formats
                set -f dims (mediainfo --Output="Video;%Width% %Height%" $file | string split " ")
            case .$audio_formats
                set -f dims (mediainfo --Output="Audio;%Duration/String3%" $file)
                set -f output_format '%s'
            case .m4a
                set -f secs (mp4info $file | string match -r '\d+\.\d+ secs')
                set -f dims (soulver "$secs[1] as laptime")
                set -f output_format '%s'
            case '*'
                echo >&2 "$file: don't know how to read $ext files"
                continue
        end
        # or begin
        #     echo >&2 "$file: could not find dimensions"
        #     continue
        # end
        printf "$output_format\t%s\n" $dims $file
    end
end
