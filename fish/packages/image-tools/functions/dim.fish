function dim --description 'Get the pixel dimensions of an image' -a image
    set -l width
    set -l height

    if in-path sips
        set width (_sips_getProperty pixelWidth $image)
        or return
        set height (_sips_getProperty pixelHeight $image)
        or return
    else
        set -l regex '.*, (\d+) ?x ?(\d+),.*'
        set -l dims (file -bp $image | string replace -rf $regex '$1\n$2')
        or return

        set width $dims[1]
        set height $dims[2]
    end

    printf "%s: %d × %d\\n" $image $width $height
end
