_inPath sips || return

heic2jpeg()
{ #: converts HEIC files (iOS 11+) to JPEG
  #: $ heic2jpeg IMAGE [IMAGES ...]

  (( $# == 0 )) && set -- "$PWD"/*.{heic,HEIC}

  local img; for img in "$@"; do
    sips -s format jpeg "$img" --out "${img%.*}.jpg" || break
  done
}
