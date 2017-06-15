songinfo()
{ #: - prints metadata for song files
  #: $ songinfo <file>
  (_require id3v2 || _require mp4info) || return

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
      return 65
      ;;
  esac
}
