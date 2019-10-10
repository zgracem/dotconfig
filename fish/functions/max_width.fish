function max_width -a new_w file -d 'Resize an image to fit within a specified pixel width'
  set -l new_file (string replace -r '(.*)\.(.*)' '$1_'$new_w'px.$2' $file)

  if in-path sips
    set -l old_w (_sips_getProperty pixelWidth $file)
    set -l old_h (_sips_getProperty pixelHeight $file)
    set -l ratio (math -s3 $old_w/$old_h)
    set -l new_h (math -s0 $new_w/$ratio)

    sips -z $new_h $new_w $file --out $new_file >/dev/null 2>&1
  else if in-path convert
    convert $file -resize $new_w $new_file
  else
    echo >&2 "error: need ‘sips’ or ‘convert’ to resize images"
    return 127
  end
end
