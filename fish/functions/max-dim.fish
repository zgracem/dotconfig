function max-dim --description 'Resize an image to fit within a specified pixel size' -a pixels file
    set -l new_file (string replace -r '(.*)\.(.*)' '$1_'$pixels'px.$2' $file)

    if in-path sips
        sips -Z $pixels $file --out $new_file >/dev/null 2>&1
    else if in-path convert
        convert $file -resize "$pixels"x"$pixels" $new_file
    else
        echo >&2 "error: don't know how to resize images"
        return 127
    end
end
