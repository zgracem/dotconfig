function dim --description 'Get the pixel dimensions of an image' -a image
    if command -q sips
        set -l sips_rx "^\s+\w+: (.+)"
        set -f width (sips --getProperty pixelWidth $image | string match -rg $sips_rx)
        or return
        set -f height (sips --getProperty pixelHeight $image | string match -rg $sips_rx)
        or return
    else
        set -l regex '.*, (\d+) ?x ?(\d+),.*'
        set -l dims (file -bp $image | string replace -rf $regex '$1\n$2')
        or return

        set -f width $dims[1]
        set -f height $dims[2]
    end

    printf "%s: %d × %d\\n" $image $width $height
end
