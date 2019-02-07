_inPath ffmpeg || return

makemp3()
{ #: - converts an audio file to MP3 (libmp3lame, max quality VBR)
  #: $ makemp3 <file> [<file> ...]
  #: < ffmpeg
  local input; for input in "$@"; do
    ffmpeg -i "$input" \
      -codec:a libmp3lame -qscale:a 0 \
      -map_metadata 0 -id3v2_version 3 -write_id3v1 1 \
      "${input%.*}.mp3"
  done
}
