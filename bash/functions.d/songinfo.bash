(_inPath id3v2 && _inPath mp4info) || return

songinfo()
{ #: - prints metadata for song files
  #: $ songinfo <file>

  local song="$1"

  case "$song" in
    *.mp3)
      id3v2 -l "$song"
      ;;
    *.m4[ap]|*.mp4|*.aac)
      mp4info "$song"
      ;;
    *)
      scold "${FUNCNAME[0]}: ${song}: no metadata found"
      return 1
      ;;
  esac
}
