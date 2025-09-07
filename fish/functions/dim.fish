function dim --description 'Get the pixel dimensions of images or video'
    command -q sips; and command -q mediainfo; or return 127

    set -f img_formats (sips --formats | string match -rg "^\S+\s+(\w+)\b.*" | sort -u)
    for file in $argv
        switch (path extension $file | string lower)
            case .$img_formats .jpg
                set -f dims (sips -g pixelWidth -g pixelHeight $file | string match -rg 'pixel\S+: (\d+)')
            case '*'
                set -f output_fmt "Video;%Width% %Height%" "Image;%Width% %Height%"
                set -f dims (mediainfo --Output="$output_fmt" $file | string split " ")
        end
        or begin
            echo >&2 "$file: could not find dimensions"
            continue
        end
        printf "%4d × %4d\t%s\\n" $dims[1] $dims[2] $file
    end
end
