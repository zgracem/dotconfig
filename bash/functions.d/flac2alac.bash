flac2alac()
{ #: - losslessly converts FLAC to Apple Lossless (for iTunes import)
  #: $ flac2alac <file> [<file> ...]
  #: < ffmpeg
  _require ffmpeg || return

  (( $# == 0 )) && set -- "$PWD"/*.flac

  local input; for input in "$@"; do
    ffmpeg -i "$input" -acodec alac -vn "${input/%flac/m4a}"
  done
}
