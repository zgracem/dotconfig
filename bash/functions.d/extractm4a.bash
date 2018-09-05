extractm4a()
{ #: - extracts an M4A audio track from a video container
  #: $ extractm4a <file> [<file> ...]
  #: < ffmpeg
  _require ffmpeg || return

  local input; for input in "$@"; do
    ffmpeg -i "$input" -c:a copy -vn -sn "${input%.*}_extract.m4a"
    #                   │         │   └─ no subtitles
    #                   │         └───── no video
    #                   └─────────────── copy audio as-is
  done
}
