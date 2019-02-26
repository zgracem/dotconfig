function dim -a image --description 'Get the pixel dimensions of an image'
	set -l regex '.*: (\d+)$'
  set -l width
  set -l height

  if in-path sips
    set width (sips --getProperty pixelWidth $image | string replace -rf $regex '$1')
    or return
    set height (sips --getProperty pixelHeight $image | string replace -rf $regex '$1')
    or return
  else
    set -l dims (file -bp $image | string replace -rf '.*, (\d+) ?x ?(\d+),.*' '$1\n$2')
    or return

    set width $dims[1]
    set height $dims[2]
  end

  printf "%s: %d × %d\\n" $image $width $height
end
