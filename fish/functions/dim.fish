function dim --description 'Get the pixel dimensions of an image' -a image
    set -l regex '.*, (\d+) ?x ?(\d+),.*'
    set -l dims (file -bp $image | string replace -rf $regex '$1\n$2')
    or return

    set -f width $dims[1]
    set -f height $dims[2]

    printf "%s: %d × %d\\n" $image $width $height
end
