function songinfo --description 'Print metadata for a song file' -a song
  switch "$song"
    case "*.mp3"
      id3v2 -l "$song"
    case "*.m4[ap]" "*.mp4" "*.aac"
      mp4info "$song"
    case "*"
      echo >&2 "no metadata found in $song"
      return 1
  end
end
