flac2alac()
{ #: - losslessly converts FLAC to Apple Lossless (for iTunes import)
  #: $ flac2alac <file> [<file> ...]
  #: < ffmpeg
  _require ffmpeg || return

  (( $# == 0 )) && set -- $PWD/*.flac

  local input; for input in "$@"; do
    ffmpeg -i "$in_file" -acodec alac -vn "${in_file/%flac/m4a}"
  done
}
